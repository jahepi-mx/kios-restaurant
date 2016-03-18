package com.kios.domain.utils {
	
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class RemoteObjectAdapter {
		
		
		private var _rpc:RemoteObject;
		
		
		public function RemoteObjectAdapter() {
			_rpc = new RemoteObject();
	        _rpc.source = "Productos";
		    _rpc.destination = "amfphp";
		    _rpc.showBusyCursor = true;
		}
		
		public function addEventListener(type:String, listener:Function):void {
			_rpc.addEventListener(type, listener);
		}
		
		public function call(method:String, ... args):void {
			_rpc[method].send.apply(_rpc, args);
		}
		
		public function removeEventListener(type:String, listener:Function):void {
			_rpc.removeEventListener(type, listener);
		}
		
		public function set source(src:String):void {
			_rpc.source = src;
		}
		
		public function set destination(destination:String):void {
			_rpc.destination = destination;
		}
		
		public function set showBusyCursor(show:Boolean):void {
			_rpc.showBusyCursor = show;
		}
	}
	
}
