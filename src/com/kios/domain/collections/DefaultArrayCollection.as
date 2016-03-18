package com.kios.domain.collections {
	
	import com.kios.domain.interfaces.ICollection;
	import mx.collections.ArrayCollection;
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.iterators.ArrayCollectionIterator;
	import flash.events.EventDispatcher;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	public class DefaultArrayCollection extends EventDispatcher implements ICollection {
		
		
		private var _collection:ArrayCollection;
		
		
		public function DefaultArrayCollection() {
			_collection = new ArrayCollection();
		}
		
		public function addItem(item:Object):void {
			_collection.addItem(item);
			dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, true, false, CollectionEventKind.ADD, 0, 0, [item]));
		}
		
		public function removeItem(item:Object):Boolean {
		    for(var i:Number = 0; i < _collection.length; i++){
		    	if(_collection.getItemAt(i) == item) {
		    		_collection.removeItemAt(i);
		    		dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, true, false, CollectionEventKind.REMOVE, 0, 0, [item]));
		    		return true;
		    	}
		    }
		    
		    return false;
		}
		
		public function removeItemAt(index:Number):Boolean {
			if(index > _collection.length || index < 0) {
				throw new Error("El indice al cual tratas de accesar esta fuera de los limites de la coleccion");
			}
			
			var item:Object = _collection.removeItemAt(index);
			if(item != null) {
				dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, true, false, CollectionEventKind.REMOVE, 0, 0, [item]));
				return true;
			}
			
			return false;
		}
		
		public function removeAllItems():void {
			_collection.removeAll();
			dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, true, false, CollectionEventKind.RESET, 0, 0));
		}
		
		public function getItemAt(index:Number):Object {
			if(index > _collection.length || index < 0) {
				throw new Error("El indice al cual tratas de accesar esta fuera de los limites de la coleccion");
			}
			return _collection.getItemAt(index);
		}
		
		public function length():Number {
			return _collection.length;
		}
		
		public function iterator():IIterator {
			return new ArrayCollectionIterator(_collection);
		}
	}
}