package com.kios.domain.loaders {
	
	import com.kios.domain.collections.DefaultArrayCollection;
	import com.kios.domain.data.*;
	import com.kios.domain.events.*;
	import com.kios.domain.interfaces.ICollection;
	import com.kios.domain.interfaces.ILoader;
	import com.kios.domain.interfaces.IProduct;
	import com.kios.domain.utils.RemoteObjectAdapter;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	//Este servicio retorna una colección de tipo de objetos Order de acuerdo a los id´s
	//De las ordenes indicados
	public class DBOrdersLoader extends EventDispatcher implements ILoader {
		
		
		private var _ids:Array;
		private var _rpc:RemoteObjectAdapter;
		private var _collection:ICollection;
		private var _order:Order;
		
		private var _productID:Number;
	    private var _product:IProduct;
	    private var _packageID:Number;
	    private var _package:IProduct;
		
		public function DBOrdersLoader(ids:Array) {
			_ids = ids;
			_rpc = new RemoteObjectAdapter();
			_collection = new DefaultArrayCollection();
			_rpc.addEventListener(FaultEvent.FAULT, onError);
			_rpc.addEventListener(ResultEvent.RESULT, onResult);
		}
		
		public function load():void {
			trace(_ids[0]);
			_rpc.call("getOrders", _ids);
		}
		
		private function onError(event:FaultEvent):void {
			dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.ONLOADERROR, "Error al cargar la orden"));
		}
		
		private function onResult(event:ResultEvent):void {
			
			if(event.result == null) {
				onError(null);
				return;
			}
			
			for(var i:Number = 0; i < event.result.length; i++) {
				var orderDetails:Array = event.result[i].orderDetailsEnc;
				_order= new Order();
				_order.id = orderDetails[0].ORC_CLAVE;
				_order.setSpec(Attributes.NAME, orderDetails[0].ORC_NOMBRE);
				buildProducts(event.result[i].orderProductDetails);
				buildPackages(event.result[i].orderComboDetails);
				buildCreations(event.result[i].orderCreationDetails);
				_collection.addItem(_order); 
			}
			
			dispatchEvent(new LoaderEvent(LoaderEvent.ONLOAD, _collection));
		}
		
		private function buildProducts(result:Array):void {
			_productID = 0;
			_product = null;
	    	var ordID:Number = 0;
	    	var productData:Object;
	    	for(var i:Number = 0; i < result.length; i++) {
	    		productData = result[i];
	    		//Evalua cuando sea una orden diferente
	    		if(productData.ORD_CLAVE != ordID) {
	    			ordID = productData.ORD_CLAVE;
	    			_productID = 0;
	    			generateProduct(productData);
	    		} else {
	    			generateProduct(productData);
	    		}
	    	}
		}
		
		private function generateProduct(data:Object):void {
			if(_productID != data.PRD_CLAVE) {
	    		_productID = data.PRD_CLAVE;
	    		_product = LoaderHelper.productBuilder(data);
	    		_product.setSpec(Attributes.ORDERED, true);
	    		_order.addProduct(_product);
	    	    generateIngredient(data);
	    	} else {
	    		generateIngredient(data);
	    	}
		}
		
		private function buildCreations(result:Array):void {
			_productID = 0;
			_product = null;
			var ordID:Number = 0;
	    	var productData:Object;
	    	for(var i:Number = 0; i < result.length; i++) {
	    		productData = result[i];
	    		if(ordID != productData.ORD_CLAVE) {
	    			ordID = productData.ORD_CLAVE;
	    			_productID = 0;
	    			generateCreation(productData);
	    		} else {
	    			generateCreation(productData);
	    		}
	    	}
		}
		
		private function generateCreation(data:Object):void {
			if(_productID != data.CCR_CLAVE) {
	    		_productID = data.CCR_CLAVE;
	    		var productSpecs:Specs = new Specs();
	    	    productSpecs.setValue(Attributes.TYPE, ProductTypes.CREACION);
	    	    productSpecs.setValue(Attributes.TYPE_KEY, ProductTypes.CREACION_ID);
	    		productSpecs.setValue(Attributes.NAME, data.CCR_NOMBRE);
	    		productSpecs.setValue(Attributes.AUTOR, data.CCR_AUTOR);
	    		productSpecs.setValue(Attributes.ORDERED, true);
	   			_product = new Product(productSpecs);
	   			_product.id = _productID;
	   			_order.addProduct(_product);
	    	    generateIngredient(data);
	    	} else {
	    		//Como es el mismo producto, añadimos los demás ingredientes.
	    		generateIngredient(data);
	    	}
		}
		
		private function buildPackages(result:Array):void {
	    	_productID = 0;
			_product = null;
	    	var ordID:Number = 0;
	    	var productData:Object;
	    	for(var i:Number = 0; i < result.length; i++) {
	    		productData = result[i];
	    		if(ordID != productData.ORD_CLAVE) {
	    			ordID = productData.ORD_CLAVE;
	    			_packageID = 0;
	    			_productID = 0;
	    			generatePackage(productData);
	    		} else {
	    			//Como es el mismo paquete, añadimos los demás productos.
	    			generatePackage(productData);
	    		}	
	    	}	
		}
		
		private function generatePackage(data:Object):void {
			if(_packageID != data.CPK_CLAVE) {
	    		_packageID = data.CPK_CLAVE;
	    		var packSpecs:Specs = new Specs();
	    	    packSpecs.setValue(Attributes.TYPE, ProductTypes.PAQUETE);
	    		packSpecs.setValue(Attributes.NAME, data.CPK_NOMBRE);
	    	    packSpecs.setValue(Attributes.TYPE_KEY, ProductTypes.PAQUETE_ID);
	    	    packSpecs.setValue(Attributes.ORDERED, true);
	    		_package = new Package(packSpecs);
	    		_package.id = _packageID;
	    		_order.addProduct(_package);
	    		generateProductPackage(data);
	    	} else {
	    		generateProductPackage(data);
	    	}
		}
		
		private function generateProductPackage(data:Object):void {
			if(_productID != data.PRD_CLAVE) {
	    		_productID = data.PRD_CLAVE;
	    		_product = LoaderHelper.productBuilder(data);
	    		_product.setSpec(Attributes.ORDERED, true);
	    		_package.addElement(_product);
	    	    generateIngredient(data);
	    	} else {
	    		//Como es el mismo producto, añadimos los demás ingredientes.
	    		generateIngredient(data);
	    	}
		}
		
		private function generateIngredient(data:Object):void {
	    	var ingredient:Ingredient = LoaderHelper.ingredientBuilder(data, true);
	    	_product.addElement(ingredient);
	    	
	    	if(ingredient.editable) {
	    		if(data.ROP_ACTIVO != null) {
	    			if(data.ROP_ACTIVO == "S") {
	    		        ingredient.active();
	    		    } else {
	    			    ingredient.deactive();
	    		    }
	    		}
	    	}
	    	ingredient.editable = false;
	    }
	    
	    
	}
}