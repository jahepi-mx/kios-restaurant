package com.kios.domain.loaders {
	
	import com.kios.domain.collections.DefaultArrayCollection;
	import com.kios.domain.data.*;
	import com.kios.domain.events.LoaderErrorEvent;
	import com.kios.domain.events.LoaderEvent;
	import com.kios.domain.interfaces.ICollection;
	import com.kios.domain.interfaces.ILoader;
	import com.kios.domain.utils.RemoteObjectAdapter;
	import flash.events.EventDispatcher;
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class DBIngredientsTypeLoader extends EventDispatcher implements ILoader {
		
		
		 private var _collection:ICollection;
	     private var _rpc:RemoteObjectAdapter;
	     private var _type:Number;
	     
	     
	     public function DBIngredientsTypeLoader(type:Number) {
	    	_collection = new DefaultArrayCollection();
	    	_rpc = new RemoteObjectAdapter();
			_rpc.addEventListener(FaultEvent.FAULT, onError);
			_rpc.addEventListener(ResultEvent.RESULT, onResult);
			_type = type;
		 }
		 
		  public function load():void {
           //Llamar al método remoto.
            _rpc.call("getInsumosByType", _type);
	    }
	    
	    private function onResult(event:ResultEvent):void {
	    	//Implementar la materialización de los datos de la DB.
	    	var result:Array = event.result as Array;
	    	var productData:Object;
	    	var ingredient:Ingredient;
	    	for(var i:Number = 0; i < result.length; i++) {
	    		productData = result[i];
	    		ingredient = LoaderHelper.ingredientBuilder(productData, true);
	    	    _collection.addItem(ingredient);
	    	}
	    	
	    	dispatchEvent(new LoaderEvent(LoaderEvent.ONLOAD, _collection));
	    }
	    
	    private function onError(event:FaultEvent):void {
	    	dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.ONLOADERROR, "Error al cargar datos"));
	    }
		
	}
}