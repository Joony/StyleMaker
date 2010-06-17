package ch.forea.stylemaker {
	import ch.forea.parsing.XMLParser;
	import ch.forea.stylemaker.dto.DataDTO;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author alyoka
	 */
	public class DataLoader extends EventDispatcher{
		private var urlLoader:URLLoader; 
		public var data:DataDTO;
		
		public function load() : void {	
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			urlLoader.load(new URLRequest("xml/config.xml"));
		}
		
		private function onComplete( event : Event ) : void {
			urlLoader.removeEventListener(Event.COMPLETE, onComplete);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var xml : XML;
			try {
				xml = new XML(urlLoader.data);
			}catch(e : Error) {
				//TODO: handle error
				trace(e);
				return;
			}
			data = new XMLParser().parse(XMLList(xml), "ch.forea.stylemaker.dto.DataDTO");
			dispatchEvent(event);
		}

		private function onIOError( event : IOErrorEvent ) : void {
			//TODO: handle error
			trace(event);
		}		
	}
}
