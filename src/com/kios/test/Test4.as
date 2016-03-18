package com.kios.test {
	
	import com.kios.domain.interfaces.ILoader;
	import com.kios.domain.loaders.DBProductsLoader;
	import com.kios.domain.data.*;
	import com.kios.domain.events.LoaderEvent;
	import com.kios.domain.events.LoaderErrorEvent;
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.data.Product;
	
	public class Test4 {
		
		public static function init():void {
			var command:ILoader = new DBProductsLoader(DBProductsLoader.BEBIDA_ID, ProductTypes.BEBIDA);
			command.addEventListener(LoaderEvent.ONLOAD, Test4.onLoad);
			command.addEventListener(LoaderErrorEvent.ONLOADERROR, Test4.onLoadError);
			command.load();
		}
		
		private static function onLoad(event:LoaderEvent):void {
			var i:IIterator = event.collection.iterator();
			while(i.hasNext()) {
				var product:Product = i.next() as Product;
				trace("Producto: "+product.getSpec(Attributes.NAME));
				var ingredientsIterator:IIterator = product.elementsIterator();
				while(ingredientsIterator.hasNext()) {
					var ingredient:Ingredient = ingredientsIterator.next() as Ingredient;
					trace("Ingrediente: "+ingredient.getSpec(Attributes.NAME));
					trace("Ingrediente Editable: "+ingredient.editable);
				}
			}
		}
		
		private static function onLoadError(event:LoaderErrorEvent):void {
			
		}
		
	}
}