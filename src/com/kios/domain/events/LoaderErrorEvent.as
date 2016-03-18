package com.kios.domain.events {
	
	import com.kios.domain.interfaces.ICollection;
	import flash.events.Event;
	
	public class LoaderErrorEvent extends Event {
	      
	      
	     public static var ONLOADERROR:String = "onLoadError";
	     private var _message:String;
	     
	     
	     public function LoaderErrorEvent(type:String, message:String, bubbles:Boolean = true, cancelable:Boolean = false) {
	     	super(type, bubbles, cancelable);
	     	_message = message;
	     }
	     
	     public function get message():String {
	     	return _message;
	     }
	
	}
}