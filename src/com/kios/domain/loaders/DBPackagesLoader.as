package com.kios.domain.loaders {
	
	import com.kios.domain.collections.DefaultArrayCollection;
	import com.kios.domain.data.*;
	import com.kios.domain.events.LoaderErrorEvent;
	import com.kios.domain.events.LoaderEvent;
	import com.kios.domain.interfaces.ICollection;
	import com.kios.domain.interfaces.ILoader;
	import com.kios.domain.utils.RemoteObjectAdapter;
	import flash.events.EventDispatcher;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class DBPackagesLoader extends EventDispatcher implements ILoader {
		
		
		private var _collection:ICollection;
	    private var _rpc:RemoteObjectAdapter;
	    private var _productID:Number;
	    private var _product:Product;
	    
	    
	    public function DBPackagesLoader() {
	    	_collection = new DefaultArrayCollection();
	    	_rpc = new RemoteObjectAdapter();
			_rpc.addEventListener(FaultEvent.FAULT, onError);
			_rpc.addEventListener(ResultEvent.RESULT, onResult);
	    }
	    
	    
	    public function load():void {
           //Llamar al método remoto.
           _rpc.call("getPackages");
	    }
	    
	    private function onResult(event:ResultEvent):void {
	    	//Implementar la materialización de los datos de la DB.
	    	var result:Array = event.result as Array;
	    	var packID:Number = 0;
	    	var packData:Object;
	    	var pack:Package;
	    	for(var i:Number = 0; i < result.length; i++) {
	    		packData = result[i];
	    		if(packID != packData.CPK_CLAVE) {
	    			//Añadimos un nuevo paquete a nuestra colección.
	    			packID = packData.CPK_CLAVE;
	    			var packSpecs:Specs = new Specs();
	    	        packSpecs.setValue(Attributes.TYPE, ProductTypes.PAQUETE);
	    		    packSpecs.setValue(Attributes.NAME, packData.CPK_NOMBRE);
	    	        packSpecs.setValue(Attributes.TYPE_KEY, ProductTypes.PAQUETE_ID);
	    		    pack = new Package(packSpecs);
	    		    pack.id = packID;
	    		    addProduct(pack, packData);
	    		    _collection.addItem(pack);
	    		} else {
	    			//Como es el mismo paquete, añadimos los demás productos.
	    			addProduct(pack, packData);
	    		}	
	    	}	
	    	dispatchEvent(new LoaderEvent(LoaderEvent.ONLOAD, _collection));
	    }
	    
	    private function addProduct(pack:Package, packData:Object):void {
	    	if(_productID != packData.PRD_CLAVE) {
	    		_productID = packData.PRD_CLAVE;
	    		_product = LoaderHelper.productBuilder(packData);
	   		    pack.addElement(_product);
	    	    addIngredient(packData);
	    	} else {
	    		//Como es el mismo producto, añadimos los demás ingredientes.
	    		addIngredient(packData);
	    	}
	    }
	    
	    private function addIngredient(packData:Object):void {
	    	if(!packData.INS_CLAVE) {
	    		return;
	    	}
	    	var ingredient:Ingredient = LoaderHelper.ingredientBuilder(packData);
	    	_product.addElement(ingredient);
	    }
	    
	    private function onError(event:FaultEvent):void {
	    	dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.ONLOADERROR, "Error al cargar las bebidas de la base de datos"));
	    }
	}
}