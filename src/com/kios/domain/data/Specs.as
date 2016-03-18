package com.kios.domain.data {
	
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.iterators.ObjectIterator;
	
	public class Specs {
	
	    /**
		 * Objeto que almacena especificaciones.
		 */
	     private var _specs:Object;
	     
	     
	    /**
		 * Constructor
		 */
	     public function Specs() {
	     	_specs = {};
	     }
	    /**
		 * Método que añade ó actualiza una característica a la especificación.
		 * @param String key Tipo de característica.
		 * @param Object value Valor de la característica.
		 */
	     public function setValue(key:String, value:Object):void {
	     	_specs[key] = value;
	     }
	    /**
		 * Método que devuelve el valor de una característica de la especificación.
		 * @param String key Tipo de característica.
		 * @return Object
		 */
	     public function getValue(key:String):Object {
	     	/*if(_specs[key] == null) {
	     		throw new Error("Este valor no esta definido");
	     	}*/
	     	return _specs[key];
	     }
	    /**
		 * Método que remueve el valor de una característica de la especificación.
		 * @param String key Tipo de característica.
		 * @return Boolean
		 */
	     public function removeValue(key:String):Boolean {
	         if(_specs[key]) {
	         	delete _specs[key];
	         	return true;
	         }
	         
	         return false;
	     }
	     
	     public function get specs():Object {
	     	return _specs;
	     } 
	    /**
		 * Método que nos dice si la especificación es igual a la pasada como parámetro.
		 * @param ProductSpecs specs.
		 * @return Boolean
		 */
	     public function equals(specs:Specs):Boolean {
	     	for(var prop:String in specs.specs) {
	     		if(specs.getValue(prop) != _specs[prop]) {
	     			return false;
	     		}
	     	}
	     	return true;
	     }
	    /**
		 * Método que nos devuelve un iterador para poder iterar sobre las características de la especificación.
		 * @return IIterator
		 */
	     public function specsIterator():IIterator {
	     	return new ObjectIterator(_specs);
	     }   
	}
}