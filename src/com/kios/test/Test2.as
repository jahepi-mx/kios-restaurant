package com.kios.test {
	
	import com.kios.domain.data.Table;
	import com.kios.domain.data.Attributes;
	import com.kios.domain.data.Order;
	import com.kios.domain.data.Product;
	import com.kios.domain.data.ProductTypes;
	import com.kios.domain.data.Ingredient;
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.data.Specs;
	import com.kios.domain.loaders.DBProductsLoader;
	import com.kios.domain.events.*;
	import com.kios.domain.savers.DBCreationSaver;
	import com.kios.domain.interfaces.ISaver;
	import com.kios.domain.data.Package;
	import com.kios.domain.interfaces.IProduct;
	
	public class Test2 {
	
	   public static function init():void {
			
			/*
			  ***CREACIÓN DE LA MESA DE CLIENTES***
			*/
			//Creamos la mesa
			var mesa:Table = Table.getInstance();
			//Le asignamos un id a la mesa para su identificación posterior (WINKS).
			mesa.id = "001"; 
			//Asignamos el número personas que va a tener la mesa.
			mesa.nClients = 3;
			
			
			/*
			  ***CREACIÓN DE LAS ÓRDENES PARA LA MESA***
			*/
			//Creamos las órdenes y le pasamos como parámetro el nombre.
			var orden1:Order = new Order();
			orden1.setSpec(Attributes.NAME, "Emmanuel");
			var orden2:Order = new Order();
			orden1.setSpec(Attributes.NAME, "Uriel");
			var orden3:Order = new Order();
			orden1.setSpec(Attributes.NAME, "Alejandro");
			//Agregamos las órdenes a la mesa
			mesa.addOrder(orden1);
			mesa.addOrder(orden2);
			mesa.addOrder(orden3);
			
			
			/*
			  ***CREACIÓN DE LOS PAQUETES Y PRODUCTOS PARA AGREGAR A LAS ÓRDENES***
			*/
			//Creamos una especificación ya sea para un producto o un paquete;
			var productSpec:Specs = new Specs();
			//Añadimos los valores que necesitamos para esa especificación
			productSpec.setValue(Attributes.TYPE, ProductTypes.BEBIDA);
			productSpec.setValue(Attributes.NAME, "Coca Cola");
			productSpec.setValue(Attributes.DESCRIPTION, "Producto de Cola");
			productSpec.setValue(Attributes.COST, 5);
			productSpec.setValue(Attributes.PROMO, true);
			productSpec.setValue(Attributes.ORDERED, false);
			//Creamos un nuevo producto y le añadimos esa especificación
			var producto1:Product = new Product(productSpec);
			//Podemos cambiar el estado del producto a ordenado si este ya fue enviado a la cocina
			producto1.setSpec(Attributes.ORDERED, true);
			//Añadimos el producto a las ordenes que queramos.
			orden1.addProduct(producto1);
			orden2.addProduct(producto1);
			//Creamos las especificaciones de nuestro paquete.
			var packageSpec:Specs = new Specs();
			packageSpec.setValue(Attributes.TYPE, ProductTypes.PAQUETE);
			packageSpec.setValue(Attributes.NAME, "MEGA KING POLLO CON PAPAS");
			packageSpec.setValue(Attributes.DESCRIPTION, "Contiene una burger con doble queso, refresco de cola, etc...");
			packageSpec.setValue(Attributes.ORDERED, false);
			//Añadimos la especificación al nuevo paquete
			var paquete1:Package = new Package(packageSpec);
			//Podemos cambiar el estado del paquete a ordenado si este ya fue enviado a la cocina
			paquete1.setSpec(Attributes.ORDERED, true);
			//Añadimos productos al paquete.
			paquete1.addElement(producto1);
			//Creamos otro producto y lo añadimos al paquete
			var productSpec2:Specs = new Specs();
			productSpec2.setValue(Attributes.TYPE, ProductTypes.COMIDA);
			productSpec2.setValue(Attributes.NAME, "Arrachera");
			productSpec2.setValue(Attributes.DESCRIPTION, "Arrachera a la parrilla...");
			productSpec2.setValue(Attributes.COST, 190);
			var producto2:Product = new Product(productSpec2);
			paquete1.addElement(producto2);
			//Agregamos el paquete a una orden.
			orden3.addProduct(paquete1);
			
			
			/*
			  ***CREACIÓN DE LOS INGREDIENTES PARA AGREGAR A LOS PRODUCTOS***
			*/
			
			//Creamos nuestra especificación para los ingredientes
			var ingredientSpec:Specs = new Specs();
			ingredientSpec.setValue(Attributes.NAME, "cafeina");
			ingredientSpec.setValue(Attributes.WEIGHT, "2gr");
			ingredientSpec.setValue(Attributes.DESCRIPTION, "...");
			//Creamos un ingrediente y le pasamos la especificación.
			var ingrediente1:Ingredient = new Ingredient(ingredientSpec);
			//Creamos otro ingrediente de la misma manera.
			var ingredientSpec2:Specs = new Specs();
			ingredientSpec2.setValue(Attributes.NAME, "nuez de cola");
			ingredientSpec2.setValue(Attributes.WEIGHT, "10gr");
			ingredientSpec2.setValue(Attributes.DESCRIPTION, "...");
			var ingrediente2:Ingredient = new Ingredient(ingredientSpec2);
			//Creamos otro ingrediente de la misma manera.
			var ingredientSpec3:Specs = new Specs();
			ingredientSpec3.setValue(Attributes.NAME, "chile");
			ingredientSpec3.setValue(Attributes.WEIGHT, "30gr");
			ingredientSpec3.setValue(Attributes.DESCRIPTION, "...");
			var ingrediente3:Ingredient = new Ingredient(ingredientSpec3);
			//Añadimos los ingredientes al producto
			producto1.addElement(ingrediente1);
			producto1.addElement(ingrediente2);
			producto2.addElement(ingrediente3);
			//Los ingredientes tienen 1 propiedad que nos indica si son editables.
			ingrediente1.editable = true;
			//Si son editables los podemos activar.
			ingrediente1.active();
			//Si no son editables, nos arrojara una excepción el programa si intentamos activarlos o desactivarlos.
			//ingrediente2.active();
			
			/*
			  ***REMOVER ORDENES, INGREDIENTES, PRODUCTOS y PAQUETES***
			*/
			
			//producto1.removeElement(ingrediente1);
			//orden1.removeProduct(producto1);
			//mesa.removeOrder(orden1);
			
			 
			//SALIDA
			trace("ID DE LA MESA: "+mesa.id);
		    trace("NUMERO DE ORDENES EN LA MESA: "+mesa.ordersLength());
			var ordenesIterator:IIterator = mesa.ordersIterator();
			trace("-------ORDENES DE LA MESA-------");
			while(ordenesIterator.hasNext()) {
			 	
			  var orden:Order = ordenesIterator.next() as Order;
			  trace("NOMBRE DE LA ORDEN: "+orden.name);
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