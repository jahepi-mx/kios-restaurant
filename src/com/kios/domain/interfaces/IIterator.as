package com.kios.domain.interfaces {
	
	public interface IIterator {
		function next():Object;
		function hasNext():Boolean;
		function reset():void;
	}
}