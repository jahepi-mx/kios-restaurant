package com.kios.domain.interfaces {
	
	import flash.events.IEventDispatcher;
	
	public interface ILoader extends IEventDispatcher {
		function load():void;
	}
}