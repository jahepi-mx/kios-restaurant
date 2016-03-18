package com.kios.domain.loaders {
	
	import com.kios.domain.data.*;
	
	public class LoaderHelper {
		
		static public function ingredientBuilder(productData:Object, checkEditable:Boolean = false):Ingredient {
			var ingredientSpecs:Specs = new Specs();
	    	ingredientSpecs.setValue(Attributes.NAME, productData.INS_NOMBRE);
	    	ingredientSpecs.setValue(Attributes.IMAGE, productData.INS_IMAGEN);
	    	ingredientSpecs.setValue(Attributes.WEIGHT, productData.INS_PESO);
	    	ingredientSpecs.setValue(Attributes.PRICE1, productData.INS_PRECIO1);
	    	ingredientSpecs.setValue(Attributes.PRICE2, productData.INS_PRECIO2);
	    	ingredientSpecs.setValue(Attributes.PRICE3, productData.INS_PRECIO3);
	    	ingredientSpecs.setValue(Attributes.INS_BARRAS, productData.INS_BARRAS);
	    	ingredientSpecs.setValue(Attributes.INS_CADUCIDAD, productData.INS_CADUCIDAD);
	    	ingredientSpecs.setValue(Attributes.INS_COSTANT, productData.INS_COSTANT);
	    	ingredientSpecs.setValue(Attributes.INS_ULTCOSTO, productData.INS_ULTCOSTO);
	    	ingredientSpecs.setValue(Attributes.INS_TYPE, productData.TIN_TIPO);
	    	ingredientSpecs.setValue(Attributes.INS_MAX, productData.TIN_MAX);
	    	ingredientSpecs.setValue(Attributes.INS_CREA, productData.INS_CREA);
	    	ingredientSpecs.setValue(Attributes.INS_TYPE_CLAVE, productData.TIN_CLAVE);
	    	ingredientSpecs.setValue(Attributes.INS_RIP, productData.RIP_CLAVE);
	    	ingredientSpecs.setValue(Attributes.INS_MODEL, productData.INS_MODELO);
	    	var ingredient:Ingredient = new Ingredient(ingredientSpecs);
	    	ingredient.id = productData.INS_CLAVE;
	    	//Será falso solo en los insumos que queramos que no sean editables (Creaciones y Paquetes)
	    	if(!checkEditable) {
	    		ingredient.editable = false;
	    	} else {
	    		ingredient.editable = productData.INS_ESTATUS == "A" ? true : false;
	    	}
	    	if(ingredient.editable) {
	    		productData.INS_ESTATUS == "A" ? ingredient.active() : ingredient.deactive();
	    	}
	    	
	    	return ingredient;
		}
		
		public static function productBuilder(productData:Object):Product {
			var product:Product;
			var productSpecs:Specs = new Specs();
	    	productSpecs.setValue(Attributes.TYPE, productData.DEP_NOMBRE);
	    	productSpecs.setValue(Attributes.TYPE_KEY, ProductTypes.PRODUCT_ID);
	    	productSpecs.setValue(Attributes.NAME, productData.PRD_NOMBRE);
	    	productSpecs.setValue(Attributes.COST, productData.PRD_COSTO);
	    	productSpecs.setValue(Attributes.PRICE1, productData.PRD_PRECIO1);
	    	productSpecs.setValue(Attributes.PRICE2, productData.PRD_PRECIO2);
	    	productSpecs.setValue(Attributes.PRICE3, productData.PRD_PRECIO3);
	    	productSpecs.setValue(Attributes.RECIPE, productData.PRD_RECETA);
	    	productSpecs.setValue(Attributes.VIDEO, productData.PRD_VIDEO);
	    	productSpecs.setValue(Attributes.ELABORATION_TIME, productData.PRD_TIMELAB);
	    	productSpecs.setValue(Attributes.PRD_HORAFIN, productData.PRD_HORAFIN);
	    	productSpecs.setValue(Attributes.PRD_HORAINI, productData.PRD_HORAINI);
	    	productSpecs.setValue(Attributes.PRD_HRFINPRO, productData.PRD_HRFINPRO);
	    	productSpecs.setValue(Attributes.PRD_HRINIPRO, productData.PRD_HRINIPRO);
	   		productData.PRD_PERSONAL == "S" ? productSpecs.setValue(Attributes.CUSTOMIZABLE, true) : productSpecs.setValue(Attributes.CUSTOMIZABLE, false);
	   		product = new Product(productSpecs);
	   		product.id = productData.PRD_CLAVE;
	   		
	   		return product;
		} 
		
		
		
	}
}