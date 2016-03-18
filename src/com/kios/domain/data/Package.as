package com.kios.domain.data {
	
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.interfaces.IProduct;
	
	public class Package extends IProduct {
		
		/**
		 * Constructor
		 * @param ProductSpecs specs Especificaciones del Paquete.
		 */
		public function Package(specs:Specs) {
             super(specs);
		}
		/**
		 * Método que añade un nuevo producto al paquete.
		 * @param Object element Instancia de la clase Product
		 */
		public override function addElement(element:Object):void {
			if(!(element is Product)) {
			     throw new Error("El elemento añadido debe ser una instancia de la clase Producto");
			}
			_elements.addItem(element);
		}
		/**
		 * Método que remueve un producto del paquete.
		 * @param Object element Instancia de la clase Product
		 */
		public override function removeElement(element:Object):Boolean {
			if(!(element is Product)) {
			     throw new Error("El elemento añadido debe ser una instancia de la clase Producto");
			}
			return _elements.removeItem(element);
		}
		/**
		 * Método que remueve un Producto por su ID en el paquete.
		 * @param Number id ID del paquete
		 */
		public override function removeElementByID(id:Number):Boolean {
			var i:IIterator = elementsIterator();
		 	while(i.hasNext()) {
		 		var product:Product = i.next() as Product;
		 		if(product.id == id) {
		 			removeElement(product);
		 			return true;
		 		}
		 	}
		 	return false;
		}
		/**
		 * Devuelve una copia del paquete.
		 * @return Object
		 */
		public override function clone():Object {
			var pack:Package = new Package(_specs);
			pack.id = _id;
			var packsIterator:IIterator = elementsIterator();
			while(packsIterator.hasNext()) {
				var product:Product = packsIterator.next() as Product;
				var productCopy:Product = product.clone() as Product;
				pack.addElement(productCopy);
			}
			return pack;
		}
	}
}