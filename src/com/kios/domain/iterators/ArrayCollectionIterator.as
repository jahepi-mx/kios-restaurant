package com.kios.domain.iterators {
	
	import com.kios.domain.interfaces.IIterator;
	import mx.collections.ArrayCollection;
	
	public class ArrayCollectionIterator implements IIterator {
		
		
		private var _collection:ArrayCollection;
		private var _index:Number;
		
		
		public function ArrayCollectionIterator(collection:ArrayCollection) {
			_collection = collection;
			_index = 0;
		}
		
		public function next():Object {
			if(_index < _collection.length) {
				return _collection.getItemAt(_index++);
			}
			
			throw new Error("Has alcanzado el limite de la colección");
		}
		
		public function hasNext():Boolean {
			return _index < _collection.length;
		}
		
		public function reset():void {
			_index = 0;
		}
	}
}