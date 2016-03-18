package com.kios.domain.events {
	
	import flash.events.Event;
	import com.kios.domain.interfaces.ICollection;
	
	public class LoaderEvent extends Event {
	
	     public static var ONLOAD:String = "onLoad";
	     private var _collection:ICollection;
	     
	     
	     public function LoaderEvent(type:String, collection:ICollection, bubbles:Boolean = true, cancelable:Boolean = false) {
	     	super(type, bubbles, cancelable);
	     	_collection = collection;
	     }
	     
	     public function get collection():ICollection {
	     	return _collection;
	     }
	}
}