package com.kios.test {
	
	import com.kios.domain.interfaces.ICollection;
	import com.kios.domain.collections.DefaultArrayCollection;
	import com.kios.domain.data.Product;
	import com.kios.domain.data.Attributes;
	import com.kios.domain.data.Specs;
	import com.kios.domain.data.ProductTypes;
	import com.kios.domain.interfaces.IIterator;
	import com.kios.domain.data.Package;
	import com.kios.domain.interfaces.IProduct;
	
	public class Test3 {
		
		
		public static function init():void {
			
			//****Búsqueda de elementos en una colección***//
			
			
			var productos:ICollection = new DefaultArrayCollection();
			
			//Creación de varios tipos de productos.
			var spec1:Specs = new Specs();
			spec1.setValue(Attributes.TYPE, ProductTypes.BEBIDA);
			var producto1:Product = new Product(spec1);
			var producto2:Product = new Product(spec1);
			var producto3:Product = new Product(spec1);
			
			var spec2:Specs = new Specs();
			spec2.setValue(Attributes.TYPE, ProductTypes.COMIDA);
			var producto4:Product = new Product(spec2);
			var producto5:Product = new Product(spec2);
			
			var spec3:Specs = new Specs();
			spec3.setValue(Attributes.TYPE, ProductTypes.POSTRE);
			spec3.setValue(Attributes.NAME, "Pastel de 4 leches");
			
			var specsIterator:IIterator = spec3.specsIterator();
			while(specsIterator.hasNext()) {
				var spec:Object = specsIterator.next();
				trace("Propiedad: "+spec.key+" | Valor:"+spec.value);
			}
			
			var producto6:Product = new Product(spec3);
			var producto7:Product = new Product(spec3);
			var producto8:Product = new Product(spec3);
			var producto9:Product = new Product(spec3);
			var spec4:Specs = new Specs();
			spec4.setValue(Attributes.TYPE, ProductTypes.PAQUETE); 
            var paquete1:Package = new Package(spec4);
			
			productos.addItem(producto1);
			productos.addItem(producto2);
			productos.addItem(producto3);
			productos.addItem(producto4);
			productos.addItem(producto5);
			productos.addItem(producto6);
			productos.addItem(producto7);
			productos.addItem(producto8);
			productos.addItem(producto9);
			productos.addItem(paquete1);
			
			
			var specToSearch:Specs = new Specs();
			specToSearch.setValue(Attributes.TYPE, ProductTypes.PAQUETE);
			var results:ICollection = new DefaultArrayCollection();
			
			var productsIterator:IIterator = productos.iterator();
			while(productsIterator.hasNext()) {
				var producto:IProduct = productsIterator.next() as IProduct;
				if(producto.specEquals(specToSearch)) {
					 results.addItem(producto);
				}
			}
			
			trace("ENCONTRADOS: "+results.length());
			
		}
		
		
	}
}