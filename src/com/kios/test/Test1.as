package com.kios.test {
	
	import com.kios.domain.collections.DefaultArrayCollection;
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.data.ProductTypes;
	import com.kios.domain.interfaces.ICollection;
	
	public class Test1 {
		
		public static function init():void {
			
			var collection:ICollection = new DefaultArrayCollection();
			collection.addItem({});
			collection.addItem({});
			collection.addItem({});
			collection.addItem({});
			trace(collection.length());
			var iterator:IIterator = collection.iterator();
			while(iterator.hasNext()) {
				trace("->"+iterator.next());
			}
			
		}
		
	}
}