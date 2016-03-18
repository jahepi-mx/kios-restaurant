package com.kios.domain.savers {
	
	import com.kios.domain.data.Order;
	import com.kios.domain.events.SaverErrorEvent;
	import com.kios.domain.events.SaverEvent;
	import com.kios.domain.interfaces.*;
	import com.kios.domain.utils.RemoteObjectAdapter;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	//Este clase se encarga de salvar una orden y ponerla en la lista de cambio de mesa.
	public class DBOrderTableChangeSaver extends EventDispatcher implements ISaver {
		
		
		private var _order:Order;
		private var _rpc:RemoteObjectAdapter;
		
		
		public function DBOrderTableChangeSaver(order:Order) {
			_order = order;
			_rpc = new RemoteObjectAdapter();
			_rpc.addEventListener(FaultEvent.FAULT, onSaveOrderError);
			_rpc.addEventListener(ResultEvent.RESULT, onSaveOrderChange);
		}
		
		public function save():void {
			//Guardamos la orden primero.
			var orderSaver:DBOrderSaver = new DBOrderSaver(_order);
			orderSaver.addEventListener(SaverErrorEvent.ONSAVERERROR, onSaveOrderError);
			orderSaver.addEventListener(SaverEvent.ONSAVE, onSaveOrder);
			orderSaver.save();
		}
		
		private function onSaveOrder(event:SaverEvent):void {
			//Ahora si guardamos el id de la orden en la lista de espera.
			_rpc.call("saveOrderCambioMesa", _order.id);
		}
		
		private function onSaveOrderError(event:Event):void {
			dispatchEvent(new SaverErrorEvent(SaverErrorEvent.ONSAVERERROR, "Hubo un error al tratar de guardar la orden la lista de cambio de mesa"));
		}
		
		private function onSaveOrderChange(event:ResultEvent):void {
			if(event.result) {
			    dispatchEvent(new SaverEvent(SaverEvent.ONSAVE, "Orden Guardada en la lista de cambio de mesa con exito"));
			} else {
				onSaveOrderError(null);
			}
		}	
	}
}