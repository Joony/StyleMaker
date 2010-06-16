package ch.forea.stylemaker.dto {
	import ch.forea.stylemaker.dto.AbstractDTO;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author alyoka
	 */
	public class ImageDTO extends AbstractDTO {
		private var _uri:String;
		private var _image:Sprite;
		private var _loader:Loader;
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		public function ImageDTO(){
			_image = new Sprite();
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
			_image.addChild(preload);
			_image.x = x;
			_image.y = y;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			_loader.load(new URLRequest(_uri));
		}
		
		private function loaded(e:Event):void{
			clearImage();
			_image.addChild(_loader.content);
			_loader = null;			
		}
		
		private function clearImage():void{
			while(_image.numChildren){
				_image.removeChildAt(0);
			}
		}
		
		public function get image():DisplayObject {
			return _image;
		}
		
		public function clone():ImageDTO{
			var i:ImageDTO = new ImageDTO();
			i.x = x;			i.y = y;
			i.uri = uri;
			return i;
		}
		
		public function get x():Number {
			return _x;
		}
		
		public function set x(x:Number):void {
			_x = x;
			_image.x = _x;
		}
		
		public function get y():Number {
			return _y;
		}
		
		public function set y(y:Number):void {
			_y = y;
			_image.y = _y;
		}
	}
}
