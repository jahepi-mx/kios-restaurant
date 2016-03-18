package com.kios.domain.data {
	
	import com.kios.domain.interfaces.IIterator;
	
	public class Ingredient {
		
		/**
		 * Almacena el id del ingrediente (Para su identificación cuando se guarde en la DB o en algún medio persistente).
		 */
		private var _id:Number;
		/**
		 * Valor booleano que indica si el ingrediente puede ser editado (si es verdadero, la propiedad _active podrá ser modificada).
		 */
		private var _editable:Boolean;
		/**
		 * Valor booleano que indica si el ingrediente está activado o desactivado.
		 */
		private var _active:Boolean;
		/**
		 * Almacena las especificaciones del ingrediente (nombre, peso, etc...).
		 */
		private var _specs:Specs;
		
		
		/**
		 * Constructor
		 * @param ProductSpecs specs Especificaciones del ingrediente.
		 */
		public function Ingredient(specs:Specs) {
			_specs = specs;
		}
		/**
		 * Activa el ingrediente.
		 */
		public function active():void {
			if(!_editable) {
				throw new Error("EL ingrediente no puede estar activado si su propiedad 'editable' no es verdadera");
			}
			
			_active = true;
		}
		/**
		 * Desactiva el ingrediente.
		 */
		public function deactive():void {
			if(!_editable) {
				throw new Error("EL ingrediente no puede desactivarse si su propiedad 'editable' no es verdadera");
			}
			
			_active = false;
		}
		/**
		 * Devuelve una copia del ingrediente.
		 * @return Ingredient
		 */
		public function clone():Ingredient {
			var ingredient:Ingredient = new Ingredient(_specs);
			ingredient.id = _id;
			ingredient._active = _active;
			ingredient.editable = _editable;
			return ingredient;
		}
		
		public function setSpec(key:String, value:Object):void {
			_specs.setValue(key, value);
		}
		
		public function getSpec(key:String):Object {
			return _specs.getValue(key);
		}
		
		public function specEquals(spec:Specs):Boolean {
			return _specs.equals(spec);
		}
		
		public function specIterator():IIterator {
			return _specs.specsIterator();
		}
		/**
		 * Metodo para sustituir un ingrediente
		 * @param Ingredient ingredient
		 */
		public function replaceIngredient(ingredient:Ingredient):void {
			id = ingredient.id;
			editable = ingredient.editable;
			var i:IIterator = ingredient.specIterator();
			while(i.hasNext()) {
				var spec:Object = i.next();
				//No debemos sustituir la especificación rip_clave, 
				//para saber cual fue el insumo original.
				if(spec.key != Attributes.INS_RIP) {
					setSpec(spec.key, spec.value);
				}
			}
		}
		
		public function set editable(editable:Boolean):void {
			_editable = editable;
		}
		
		public function get editable():Boolean {
			return _editable;
		}
		
		public function set id(id:Number):void {
			_id = id;
		}
		
		public function get id():Number {
			return _id;
		}
		
		public function get actived():Boolean {
			return _active;
		}	
	}
}