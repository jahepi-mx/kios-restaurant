package com.kios.domain.utils {
	
	import flash.utils.Dictionary;
	
	public class Registry {
		
		
		private static var _instance:Registry;
		private var _data:Object;
		
		
		public function Registry(lock:Locked) {
			if(lock == null) {
				throw new Error("Esta clase no puede ser instanciada diréctamente.");
			}
			_data = {};
		}
		
		public static function getInstance():Registry {
			if(_instance == null) {
				_instance = new Registry(new Locked());
			}
			
			return _instance;
		}
		
		public function setValue(key:String, data:Object):void {
			_data[key] = data;
		}
		
		public function getValue(key:String):Object {
			return _data[key];
		}
		
		public function removeValue(key:String):Boolean {
			if(_data[key]) {
			   delete _data[key];
			   return true;
			}
			
			return false;
		}
		
		public function clean():void {
			_data = {};
		}
		
	}
}

class Locked {}