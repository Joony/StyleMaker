package ch.forea.stylemaker.dto {
	import ch.forea.dto.IClonable;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	/**
	 * @author alyoka
	 */
	public class ImageDTO extends Sprite implements IClonable{
		private var _uri:String;
		private var _loader:Loader;
		
		public function ImageDTO(){
		}
		
		public function get uri():String {
			return _uri;
		}
		
		public function set uri(uri:String):void {
			_uri = uri;
			
			var preload:Sprite = new Sprite();
			preload.graphics.beginFill(0xff);
			preload.graphics.drawCircle(10, 10, 5);
			preload.graphics.endFill();
			clearImage();
			addChild(preload);
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, error);
			_loader.load(new URLRequest(_uri));
		}
		
		private function loaded(e:Event):void{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaded);			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, error);			clearImage();			addChild(_loader.content);
			_loader = null;			
		}
		
		private function error(e:IOErrorEvent):void{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaded);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, error);
			_loader = null;
		}
		
		private function clearImage():void{
			while(numChildren){
				removeChildAt(0);
			}
		}
		
		public function clone():*{
			var i:ImageDTO = new ImageDTO();
			i.x = x;			i.y = y;
			i.uri = uri;
			return i;
		}
		
	}
}
