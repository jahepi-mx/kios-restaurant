package com.kios.domain.interfaces {
	
	import flash.events.IEventDispatcher;
	
	public interface ISaver extends IEventDispatcher {
		function save():void;
	}
}