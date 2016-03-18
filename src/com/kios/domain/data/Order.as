package com.kios.domain.data {
	
	import com.kios.domain.collections.DefaultArrayCollection;
	import com.kios.domain.interfaces.ICollection;
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.interfaces.IProduct;
	
	public class Order {
		
		/**
		 * Colección que almacena los productos y paquetes de la orden.
		 */
		private var _products:ICollection;
		/**
		 * Almacena el id de la orden.
		 */
		private var _id:Number;
		/**
		 * Almacena la especificaciones de la orden
		 */
        private var _specs:Specs;
		
		
		/**
		 * Constructor
		 * @param String name Nombre de la orden.
		 */
		public function Order() {
			_products = new DefaultArrayCollection();
			_specs = new Specs();
		}
		/**
		 * Método que añade un nuevo producto o paquete a la orden.
		 * @param IProduct product Cualquier instacia de clase que implemente la interfaz IProduct, puede ser un producto o un paquete.
		 */
		public function addProduct(product:IProduct):void {
			_products.addItem(product);
		}
		/**
		 * Método que remueve un producto o paquete de la orden.
		 * @param IProduct product Cualquier instacia de clase que implemente la interfaz IProduct, puede ser un producto o un paquete.
		 */
		public function removeProduct(product:IProduct):Boolean {
			return _products.removeItem(product);
		}
		/**
		 * Remueve un paquete o producto por número de posición que ocupa en la colección.
		 * @param Number index número de índice
		 * @return Boolean
		 */
		public function removeProductAt(index:Number):Boolean {
			return _products.removeItemAt(index);
		}
		/**
		 * Devuelve un paquete o producto por número de posición que ocupa en la colección.
		 * @param Number index número de índice
		 * @return IProduct
		 */
		public function getProductAt(index:Number):IProduct {
			return _products.getItemAt(index) as IProduct;
		}
		/**
		 * Remueve un paquete o producto por su id (Propiedad Id).
		 * @param Number id Id del producto
		 * @return Boolean
		 */
		public function removeProductById(id:Number):Boolean {
			var iterator:IIterator = productsIterator();
			while(iterator.hasNext()) {
				var product:IProduct = iterator.next() as IProduct;
				if(product.id == id) {
					return removeProduct(product);
				}
			}
			return false;
		}
		/**
		 * Obtiene un paquete o producto por su id (Propiedad Id).
		 * @param Number id Id del producto
		 * @return IProduct
		 */
		public function getProductById(id:Number):IProduct {
			var iterator:IIterator = productsIterator();
			while(iterator.hasNext()) {
				var product:IProduct = iterator.next() as IProduct;
				if(product.id == id) {
					return product;
				}
			}
			return null;
		}
		/**
		 * Busca productos o paquetes por su especificación.
		 * @param ProductSpecs productsSpecs Especificaciones del producto o paquete.
		 * @return ICollection
		 */
		public function searchProducts(productsSpecs:Specs):ICollection {
			var iterator:IIterator = productsSpecs.specsIterator();
			var collection:ICollection = new DefaultArrayCollection();
			while(iterator.hasNext()) {
				var product:IProduct = iterator.next() as IProduct;
				if(product.specEquals(productsSpecs)) {
					collection.addItem(product);
				}
			}
			return collection;
		}
		/**
		 * Devuelve el número de productos y paquetes en la orden.
		 * @return Number
		 */
		public function productsLength():Number {
			return _products.length();
		}
		/**
		 * Devuelve un iterador para poder iterar sobre los productos y paquetes actuales de la orden.
		 * @return IIterator
		 */
		public function productsIterator():IIterator {
			return _products.iterator();
		}
		/**
		 * Remueve todos los productos y paquetes de la orden.
		 */
		public function removeAllProducts():void {
			_products.removeAllItems();
		}
		
		public function setSpec(key:String, value:Object):void {
			_specs.setValue(key, value);
		}
		
		public function getSpec(key:String):Object {
			return _specs.getValue(key);
		}
		
		public function set id(id:Number):void {
			_id = id;
		}
		
		public function get id():Number {
			return _id;
		}
		
	}
}