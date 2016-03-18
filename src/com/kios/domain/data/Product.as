package com.kios.domain.data {
	
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.interfaces.IProduct;
	
	public class Product extends IProduct {
		
		/**
		 * Constructor
		 * @param ProductSpecs specs Especificaciones del Producto.
		 */
		public function Product(specs:Specs) {
			super(specs);
		}
		/**
		 * Método que añade un nuevo Ingrediente al producto.
		 * @param Object element Instancia de la clase Ingredient
		 */
		public override function addElement(element:Object):void {
			if(!(element is Ingredient)) {
			     throw new Error("El elemento añadido debe ser una instancia de la clase Ingrediente");
			}
			_elements.addItem(element);
		}
		/**
		 * Método que remueve un Ingrediente del producto.
		 * @param Object element Instancia de la clase Ingredient
		 */
		public override function removeElement(element:Object):Boolean {
			if(!(element is Ingredient)) {
			     throw new Error("El elemento añadido debe ser una instancia de la clase Ingrediente");
			}
			return _elements.removeItem(element);
		}
		/**
		 * Método que remueve un Ingrediente por su ID en el producto.
		 * @param Number id ID del Ingrediente
		 */
		public override function removeElementByID(id:Number):Boolean {
			var i:IIterator = elementsIterator();
		 	while(i.hasNext()) {
		 		var ingredient:Ingredient = i.next() as Ingredient;
		 		if(ingredient.id == id) {
		 			removeElement(ingredient);
		 			return true;
		 		}
		 	}
		 	return false;
		}
		/**
		 * Devuelve una copia del producto.
		 * @return Object
		 */
		public override function clone():Object {
			var product:Product = new Product(_specs);
			product.id = _id;
			var ingredientsIterator:IIterator = elementsIterator();
			while(ingredientsIterator.hasNext()) {
				var ingredient:Ingredient = ingredientsIterator.next() as Ingredient;
				var ingredientCopy:Ingredient = ingredient.clone();
				product.addElement(ingredientCopy);
			}
			
			return product;
		}
	}
}