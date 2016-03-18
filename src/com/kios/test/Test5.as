package com.kios.test {
	import com.kios.domain.data.*;
	import com.kios.domain.interfaces.*;
	
	public class Test5 {
		
		public static function getTableInfo():void {
			
			var mesa:Table = Table.getInstance();
			
			//SALIDA
			trace("ID DE LA MESA: "+mesa.id);
		    trace("NUMERO DE ORDENES EN LA MESA: "+mesa.ordersLength());
			var ordenesIterator:IIterator = mesa.ordersIterator();
			trace("-------ORDENES DE LA MESA-------");
			while(ordenesIterator.hasNext()) {
			 	
			  var orden:Order = ordenesIterator.next() as Order;
			  trace("NOMBRE DE LA ORDEN: "+orden.getSpec(Attributes.NAME));
			  trace("NUMERO DE PRODUCTOS EN ESTA ORDEN: "+orden.productsLength());
			  trace("--------------PRODUCTOS DE LA ORDEN "+orden.getSpec(Attributes.NAME)+" -------");
			  var productosIterator:IIterator = orden.productsIterator();
			  
			 	while(productosIterator.hasNext()) {
			 		
			 		var producto:IProduct = productosIterator.next() as IProduct;
			 		trace("--------------"+producto.getSpec(Attributes.TYPE));
			 		trace("--------------"+producto.getSpec(Attributes.NAME));
			 		trace("--------------ELEMENTOS DENTRO DE ESTE PRODUCTO: "+producto.elementsLength());
			 		var elementsIterator:IIterator = producto.elementsIterator();
			 		
			 		while(elementsIterator.hasNext()) {
			 			var element:* = elementsIterator.next();
			 			if(element is Product) {
			 				trace("NOMBRE DEL PRODUCTO: "+element.getSpec(Attributes.NAME));;
			 				var ingredientIterator:IIterator = element.elementsIterator();
			 				trace("IGREDIENTES: ");
			 				while(ingredientIterator.hasNext()) {
			 					var ingredient:Ingredient = ingredientIterator.next() as Ingredient;
			 					var specs:IIterator = ingredient.specIterator();
			 					while(specs.hasNext()) {
			 						var specsResult:Object = specs.next();
			 						trace("atributo: "+specsResult.key+" | valor: "+specsResult.value);
			 					}
			 				}
			 			}else if(element is Ingredient) {
			 				var specs:IIterator = element.specIterator();
			 				trace("IGREDIENTES: ");
			 				trace("---------------------------------------------");
			 				while(specs.hasNext()) {
			 					var specsResult:Object = specs.next();
			 					trace("atributo: "+specsResult.key+" | valor: "+specsResult.value);
			 				}
			 			}
			 		}
			 	}
			 			 
			 }
			
		} 
	}
}