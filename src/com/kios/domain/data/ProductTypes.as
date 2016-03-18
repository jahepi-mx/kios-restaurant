package com.kios.domain.data {
	
	public class ProductTypes {
	
	   
	   
	   public static const BEBIDA:String = "BEBIDAS";
	   public static const POSTRE:String = "POSTRES";
	   public static const COMIDA:String = "ALIMENTOS";
	   public static const PAQUETE:String = "PAQUETES";
	   public static const CREACION:String = "CREACIONES";
	   
	   public static const CREACION_ID:Number = 3; 
	   public static const PAQUETE_ID:Number = 2; 
	   public static const PRODUCT_ID:Number = 1; 
	   
	   
	   public function ProductTypes() {
	   	   throw new Error("Esta clase no puede ser instanciada");
	   }
	   
	
	}
}