package com.kios.domain.savers {
	
	import com.kios.domain.data.*;
	import com.kios.domain.events.*;
	import com.kios.domain.interfaces.*;
	import com.kios.domain.utils.RemoteObjectAdapter;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class DBOrderSaver extends EventDispatcher implements ISaver {
		
		
		private var _order:Order;
		private var _caller:RemoteObjectAdapter;
		
		
		public function DBOrderSaver(order:Order) {
			_order = order;
			_caller = new RemoteObjectAdapter();
			_caller.addEventListener(FaultEvent.FAULT, onSaveOrderFail);
			_caller.addEventListener(ResultEvent.RESULT, onSaveOrder);
		}
		
		public function save():void {
			var productDetails:Array = new Array();
			var ingredientDetails:Array = new Array();
			var orderSpecs:Object = new Object();
			
		    var i:IIterator = _order.productsIterator();
		    	
		    while(i.hasNext()) {
		    	var product:IProduct = i.next() as IProduct;
		    	if(!product.getSpec(Attributes.ORDERED)) {
		    		var productType:* = product.getSpec(Attributes.TYPE_KEY);
		    		
		    		var productData:Object = new Object();
		    		productData.prdClave = product.id;
		    		productData.prdType = productType;
		    		productData.prdIngs = new Array();
		    		
		    		if(productType == ProductTypes.PRODUCT_ID) {
		    			var ingredients:IIterator = product.elementsIterator();
		    			while(ingredients.hasNext()) { 
		    			    var ing:Ingredient = ingredients.next() as Ingredient;
		    			    var activated:String;
		    			    if(ing.actived) {
		    				    activated = 'S';
		    			    } else {
		    				    activated = 'N';
		    			  }
		    			    productData.prdIngs.push({ingRIP:ing.getSpec(Attributes.INS_RIP), ingID:ing.id, ingActivated:activated});
		    		    }
		    		}
		    		
		    		productDetails.push(productData);
		    	}	
		    }
		    
             if(_order.id) {
                orderSpecs.id = _order.id;
		     } else {
	 	        orderSpecs.nombre = _order.getSpec(Attributes.NAME);
		     }
		     _caller.call("saveOrder", orderSpecs, productDetails);
	    }
	    
	    private function onSaveOrder(event:ResultEvent):void {
	    	var inserted_id:* = event.result;
            if(inserted_id) {
            	
            	if(!_order.id) {
            		_order.id = inserted_id;
            	}
               
               var i:IIterator = _order.productsIterator();
               while(i.hasNext()) {
		    	   var product:IProduct = i.next() as IProduct;
		    	   if(!product.getSpec(Attributes.ORDERED)) {
		    		 	product.setSpec(Attributes.ORDERED, true);
		    		 	if(product is Product) {
		    		 		var ingredients:IIterator = product.elementsIterator();
		    		 		while(ingredients.hasNext()) {
		    		 			var ingredient:Ingredient = ingredients.next() as Ingredient;
		    		 			if(ingredient.editable) {
		    		 				ingredient.editable = false;
		    		 			}
		    		 		}
		    		 	}
		    	   }
		        }
		    	 onSave();
            } else {
            	onSaveError();
            }
	    } 
	    
	    private function onSave():void {
	    	dispatchEvent(new SaverEvent(SaverEvent.ONSAVE, "Orden Guardada con exito"));
	    }
	    
	    private function onSaveError():void {
	    	dispatchEvent(new SaverErrorEvent(SaverErrorEvent.ONSAVERERROR, ""));
	    }
	    
	    private function onSaveOrderFail(event:FaultEvent):void {
	    	onSaveError();
	    }
	}
}