package com.kios.domain.iterators {
	
	import com.kios.domain.interfaces.IIterator;
	
	public class ObjectIterator implements IIterator {
		
		
		private var _keyValues:Array;
		private var _object:Object;
		private var _index:Number;
		private var _length:Number;
		
		
		public function ObjectIterator(object:Object) {
			_object = object;
			_keyValues = new Array();
			_index = 0;
			_length = populateArray();
		}
		
		public function hasNext():Boolean {
			return _index < _length;
		}
		
		public function next():Object {
			if(_index < _length) {
				var object:Object = {key:_keyValues[_index], value:_object[_keyValues[_index]]};
				_index++;
				return object;
			}
			
			throw new Error("Has alcanzado el limite de la colección");
		}
		
		public function reset():void {
			_index = 0;
		}
		
		private function populateArray():Number {
			for(var prop:String in _object) {
				_keyValues.push(prop);
			}
			
			return _keyValues.length;
		}
		
		
	}
}