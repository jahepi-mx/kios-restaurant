package com.kios.domain.savers {
	
	import com.kios.domain.data.*;
	import com.kios.domain.events.*;
	import com.kios.domain.interfaces.*;
	import com.kios.domain.utils.RemoteObjectAdapter;
	import flash.events.EventDispatcher;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class DBCreationSaver extends EventDispatcher implements ISaver {
       
       
       private var _ingredients:ICollection;
       private var _creatorName:String;
       private var _creationName:String;		
       private var _caller:RemoteObjectAdapter;
       
	  
	   public function DBCreationSaver(creator:String, creation:String, ingredients:ICollection) {
	   	   _ingredients = ingredients;
	   	   _creatorName = creator;
	   	   _creationName = creation;
	   	   _caller = new RemoteObjectAdapter();
	   	   _caller.addEventListener(ResultEvent.RESULT, onSaveCreationSuccess);
		   _caller.addEventListener(FaultEvent.FAULT, onSaveCreationFailure);
	   }
	
	    public function save():void {
	    	var i:IIterator = _ingredients.iterator();
	    	var ids:Array = new Array();
	    	while(i.hasNext()) {
	    		var ingredient:Ingredient = i.next() as Ingredient;
	    		ids.push([ingredient.id, ingredient.getSpec(Attributes.INS_TYPE_CLAVE)]);
	    	}
	    	_caller.call("saveCreation", _creatorName, _creationName, ids);       
	    } 
	    
	    private function onSaveCreationSuccess(event:ResultEvent):void {
	    	var saved:* = event.result;
			if(saved) {
				onSave();
			} else {
				onSaveError();
			}
		}
		
		private function onSaveCreationFailure(event:FaultEvent):void {
			onSaveError();
		}
	    
	    private function onSave():void {
	    	dispatchEvent(new SaverEvent(SaverEvent.ONSAVE, ""));
	    }
	    
	    private function onSaveError():void {
	    	dispatchEvent(new SaverErrorEvent(SaverErrorEvent.ONSAVERERROR, ""));
	    }
	    
	}
}