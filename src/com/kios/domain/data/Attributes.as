package com.kios.domain.data {
	
	public class Attributes {
		
		/**
		 * Atributos para las especificaciones. 
		 */
		 
		//GENERALES
		public static const TYPE:String = "Tipo";
		public static const TYPE_KEY:String = "Clave Producto";
		public static const NAME:String = "Nombre";
		public static const ELABORATION_TIME:String = "Tiempo de Elaboración";
		public static const DESCRIPTION:String = "Descripción";
		public static const IMAGE:String = "Imagen";
		public static const VIDEO:String = "Video";
		public static const COST:String = "Costo";
		public static const PRICE1:String = "Precio 1";
		public static const PRICE2:String = "Precio 2";
		public static const PRICE3:String = "Precio 3";
		public static const CUSTOMIZABLE:String = "	Personalizable";
		public static const ORDERED:String = "Ordenado";
		public static const PROMO:String = "Promoción";
		public static const WEIGHT:String = "Peso";
		public static const RECIPE:String = "Receta";
		public static const AUTOR:String = "Autor";
		//INSUMOS
		public static const INS_TYPE:String = "Tipo Insumo";
		public static const INS_MAX:String = "Maximo de Insumos";
		public static const INS_TYPE_CLAVE:String = "Clave Tipo Insumo";
		public static const INS_MODEL:String = "Modelo Insumo";
		public static const INS_RIP:String = "Insumo RIP";
		public static const INS_CREA:String = "Participa Creacion";
		public static const INS_BARRAS:String = "Codigo de Barras";
		public static const INS_ULTCOSTO:String = "Ultimo Costo";
		public static const INS_COSTANT:String = "Costo Anterior";
		public static const INS_CADUCIDAD:String = "Caducidad";
		//PRODUCTOS
		public static const PRD_HORAINI:String = "Inicio Exhibicion";
		public static const PRD_HORAFIN:String = "Final Exhibicion";
		public static const PRD_HRINIPRO:String = "Inicio Promocion";
		public static const PRD_HRFINPRO:String = "Termino Promocion";

		
		public function Attributes() {
			throw new Error("Esta clase no puede ser instanciada.");
		}
	}
}