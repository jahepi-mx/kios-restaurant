package com.kios.domain.data {

	import com.kios.domain.interfaces.ICollection;
	import com.kios.domain.collections.DefaultArrayCollection;
	import com.kios.domain.interfaces.IIterator;	
	
	public class Table {
		
		
		private static var self:Table;
		
		/**
		 * Almacena el id de la mesa.
		 */
		private var _id:Number;
		/**
		 * Almacena el número total de personas en le mesa.
		 */
		private var _nClients:Number;
		/**
		 * Colección que almacena las órdenes de la mesa.
		 */
		private var _orders:ICollection;
        /**
		 * Almacena el tipo de mesa.
		 */
        private var _type:Number; 
		
		
		/**
		 * Constructor
		 * @param Locked lock Instancia de la clase Locked, para evitar instanciación directa.
		 */
		public function Table(lock:Locked) {
			_orders = new DefaultArrayCollection();
		}
		/**
		 * Singleton
		 * @return Table
		 */
		public static function getInstance():Table {
			if(self == null) {
				self = new Table(new Locked());
			}
			
			return self;
		}
        /**
		 * Método que añade una nueva orden en la mesa.
		 * @param Order order Instancia de la clase Order
		 */
		public function addOrder(order:Order):void {
			_orders.addItem(order);
		}
		/**
		 * Método que remueve una orden en la mesa.
		 * @param Order order Instancia de la clase Order que se desea remover.
		 */
		public function removeOrder(order:Order):Boolean {
			return _orders.removeItem(order);
		}
		/**
		 * Devuelve un iterador para poder iterar sobre las órdenes actuales de la mesa.
		 * @return IIterator
		 */
		public function ordersIterator():IIterator {
			return _orders.iterator();
		}
		/**
		 * Devuelve el número de órdenes de la mesa.
		 * @return Number
		 */
		public function ordersLength():Number {
			return _orders.length();
		}
		/**
		 * Devuelve la orden por número de posición que ocupa en la colección.
		 * @param Number index número de índice
		 * @return Order
		 */
		public function getOrderAt(index:Number):Order {
			return _orders.getItemAt(index) as Order;
		}
		/**
		 * Remueve la orden de la mesa por número de posición que ocupa en la colección.
		 * @param Number index número de índice
		 * @return Boolean
		 */
		public function removeOrderAt(index:Number):Boolean {
			return _orders.removeItemAt(index);
		}
		/**
		 * Obtiene una orden por su nombre.
		 * @param String name nombre de la orden
		 * @return Order
		 */
		public function getOrderByName(name:String):Order {
			var iterator:IIterator = ordersIterator();
			while(iterator.hasNext()) {
				var order:Order = iterator.next() as Order;
				if(String(order.getSpec(Attributes.NAME)) == name) {
					return order;
				}
			}
			
			return null;
		}
		/**
		 * Obtiene una orden por su ID
		 * @param String id id de la orden
		 * @return Order
		 */
		 public function getOrderById(id:Number):Order {
		 	var iterator:IIterator = _orders.iterator();
		 	while(iterator.hasNext()) {
		 		var order:Order = iterator.next() as Order
		 		if(order.id == id) {
		 			return order;
		 		}
		 	}
		 	
		 	return null;
		 }
		/**
		 * Remueve una orden por su nombre.
		 * @param String name nombre de la orden
		 * @return Boolean
		 */
		public function removeOrderByName(name:String):Boolean {
			var iterator:IIterator = ordersIterator();
			while(iterator.hasNext()) {
				var order:Order = iterator.next() as Order;
				if(String(order.getSpec(Attributes.NAME)) == name) {
					return removeOrder(order);
				}
			}
			
			return false;
		}
		/**
		 * Remueve una orden por su id.
		 * @param Number id id de la orden
		 * @return Boolean
		 */
		public function removeOrderById(id:Number):Boolean {
			var iterator:IIterator = ordersIterator();
			while(iterator.hasNext()) {
				var order:Order = iterator.next() as Order;
				if(order.id == id) {
					return removeOrder(order);
				}
			}
			
			return false;
		}
		/**
		 * Remueve todas las ordenes de la mesa.
		 */
		public function removeAllOrders():void {
			_orders.removeAllItems();
		}
		
		public function set id(id:Number):void {
			_id = id;
		}
		
		public function get id():Number {
			return _id;
		}
		
		public function set nClients(nClients:Number):void {
			_nClients = nClients;
		}
		
		public function get nClients():Number {
			return _nClients;
		}
		
		public function set type(type:Number):void {
			_type = type;
		}
		
		public function get type():Number {
			return _type;
		}
		
	}
}

class Locked {
	
}