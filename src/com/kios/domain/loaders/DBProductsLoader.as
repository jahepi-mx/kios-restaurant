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

	public class DBProductsLoader extends EventDispatcher implements ILoader {
		
		
		public static const BEBIDA_ID:Number = 1;
		public static const COMIDA_ID:Number = 2;
		public static const POSTRE_ID:Number = 3;
		
		
	    private var _collection:ICollection;
	    private var _rpc:RemoteObjectAdapter;
	    private var _productID:Number;
	    
	    
	    
	    public function DBProductsLoader(productID:Number) {
	    	_collection = new DefaultArrayCollection();
	    	_productID = productID;
	    	_rpc = new RemoteObjectAdapter();
			_rpc.addEventListener(FaultEvent.FAULT, onError);
			_rpc.addEventListener(ResultEvent.RESULT, onResult);
	    }
	    
	    
	    public function load():void {
           //Llamar al método remoto.
            _rpc.call("getProductos", _productID);
	    }
	    
	    private function onResult(event:ResultEvent):void {
	    	//Implementar la materialización de los datos de la DB.
	    	var result:Array = event.result as Array;
	    	var productID:Number = 0;
	    	var productData:Object;
	    	var product:Product;
	    	for(var i:Number = 0; i < result.length; i++) {
	    		productData = result[i];
	    		if(productID != productData.PRD_CLAVE) {
	    			//Añadimos un nuevo producto a nuestra colección.
	    			productID = productData.PRD_CLAVE;
	    			product = LoaderHelper.productBuilder(productData);
	   			    addIngredient(product, productData);
	    			_collection.addItem(product);
	    		} else {
	    			//Como es el mismo producto, añadimos los demás ingredientes.
	    			addIngredient(product, productData);
	    		}
	    	}
	    	
	    	
	    	dispatchEvent(new LoaderEvent(LoaderEvent.ONLOAD, _collection));
	    }
	    
	    private function addIngredient(product:Product, productData:Object):void {
	    	var ingredient:Ingredient = LoaderHelper.ingredientBuilder(productData, true);
	    	product.addElement(ingredient);
	    }
	    
	    private function onError(event:FaultEvent):void {
	    	dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.ONLOADERROR, "Error al cargar datos"));
	    }
	
	}
}