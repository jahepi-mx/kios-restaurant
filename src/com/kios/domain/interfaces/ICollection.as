package com.kios.domain.interfaces {
	
	import flash.events.IEventDispatcher;
	
	public interface ICollection extends IEventDispatcher {
		function addItem(item:Object):void;
		function removeItem(item:Object):Boolean;
		function removeItemAt(index:Number):Boolean;
		function removeAllItems():void;
		function getItemAt(index:Number):Object;
		function length():Number;
		function iterator():IIterator;
	}
}