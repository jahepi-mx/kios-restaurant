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
	
	public class DBCreationsLoader extends EventDispatcher implements ILoader {
		
		
		 private var _collection:ICollection;
	     private var _rpc:RemoteObjectAdapter;
	     
	     
	     public function DBCreationsLoader() {
	    	_collection = new DefaultArrayCollection();
	    	_rpc = new RemoteObjectAdapter();
			_rpc.addEventListener(FaultEvent.FAULT, onError);
			_rpc.addEventListener(ResultEvent.RESULT, onResult);
		 }
		 
		  public function load():void {
           //Llamar al método remoto.
            _rpc.call("getCreations");
	    }
	    
	    private function onResult(event:ResultEvent):void {
	    	//Implementar la materialización de los datos de la DB.
	    	var result:Array = event.result as Array;
	    	var productID:Number = 0;
	    	var productData:Object;
	    	var product:Product;
	    	for(var i:Number = 0; i < result.length; i++) {
	    		productData = result[i];
	    		if(productID != productData.CCR_CLAVE) {
	    			//Añadimos un nuevo producto a nuestra colección.
	    			productID = productData.CCR_CLAVE;
	    			var productSpecs:Specs = new Specs();
	    	        productSpecs.setValue(Attributes.TYPE, ProductTypes.CREACION);
	    	        productSpecs.setValue(Attributes.TYPE_KEY, ProductTypes.CREACION_ID);
	    		    productSpecs.setValue(Attributes.NAME, productData.CCR_NOMBRE);
	    		    productSpecs.setValue(Attributes.AUTOR, productData.CCR_AUTOR);
	   			    product = new Product(productSpecs);
	   			    product.id = productID;
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
	    	var ingredient:Ingredient = LoaderHelper.ingredientBuilder(productData);
	    	product.addElement(ingredient);
	    }
	    
	    private function onError(event:FaultEvent):void {
	    	dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.ONLOADERROR, "Error al cargar datos"));
	    }
	}
}