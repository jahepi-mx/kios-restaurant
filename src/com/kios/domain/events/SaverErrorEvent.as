package com.kios.domain.events {
	
	import flash.events.Event;
	
	public class SaverErrorEvent extends Event {
	
	    public static var ONSAVERERROR:String = "onSaveError";
	    private var _message:String;
	     
	     
	    public function SaverErrorEvent(type:String, message:String, bubbles:Boolean = true, cancelable:Boolean = false) {
	        super(type, bubbles, cancelable);
	     	_message = message;
	     }
	     
	     public function get message():String {
	     	return _message;
	     }
	}
}