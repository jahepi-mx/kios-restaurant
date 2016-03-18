package com.kios.domain.interfaces {
	
	import com.kios.domain.collections.DefaultArrayCollection;
	import com.kios.domain.data.Specs;
	
	/**
	 * @ABSTRACT
	 * Esta clase encapsula toda la funcionalidad de 
	 * cualquier tipo de producto ya sean paquetes,
	 * combos, etc...
	 */ 
	public class IProduct {
		
		
		/**
		 * Almacena el id del producto (Para su identificación cuando se guarde en la DB o en algún medio persistente).
		 */
		protected var _id:Number;
		/**
		 * Colección que almacena los elementos del producto.
		 */
		protected var _elements:ICollection;
		/**
		 * Almacena las especificaciones del producto (nombre, precio, etc...).
		 */
		protected var _specs:Specs;
		
		
		
		public function IProduct(specs:Specs) {
			_elements = new DefaultArrayCollection();
			_specs = specs;
		}
		
		
		/**
		 * ABSTRACT METHODS, MUST BE IMPLEMENTED IN SUBCLASSES
		 */
		public function addElement(element:Object):void {};
		public function removeElement(element:Object):Boolean { return false; };
		public function removeElementByID(id:Number):Boolean { return false; };
		public function clone():Object { return null; };
		
		/**
		 * Remueve todos los elemetos.
		 */
		public function removeAllElements():void {
			_elements.removeAllItems();
		}		
		/**
		 * Devuelve un iterador para poder iterar sobre los elementos actuales.
		 * @return IIterator
		 */
		public function elementsIterator():IIterator {
			return _elements.iterator();
		}
		/**
		 * Devuelve el número de elementos.
		 * @return Number
		 */
		public function elementsLength():Number {
			return _elements.length();
		}
		
		public function setSpec(key:String, value:Object):void {
			_specs.setValue(key, value);
		}
		
		public function getSpec(key:String):Object {
			return _specs.getValue(key);
		}
		
		public function specEquals(spec:Specs):Boolean {
			return _specs.equals(spec);
		}
		
		public function specIterator():IIterator {
			return _specs.specsIterator();
		}
		
		public function get id():Number {
			return _id;
		}
		
		public function set id(id:Number):void {
			_id = id;
		}

	}
}