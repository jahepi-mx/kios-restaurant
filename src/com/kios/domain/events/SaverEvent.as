package com.kios.domain.events {
	
	import flash.events.Event;
	
	public class SaverEvent extends Event {
		
		 public static var ONSAVE:String = "onSave";
	     private var _message:String;
	     
	     
	     public function SaverEvent(type:String, message:String, bubbles:Boolean = true, cancelable:Boolean = false) {
	     	super(type, bubbles, cancelable);
	     	_message = message;
	     }
	     
	     public function get message():String {
	     	return _message;
	     }
	}
}