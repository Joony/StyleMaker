package ch.forea.stylemaker.dto {
	import flash.net.URLRequest;
	import ch.forea.stylemaker.dto.AbstractDTO;

	import flash.display.Loader;

	/**
	 * @author alyoka
	 */
	public class ImageDTO extends AbstractDTO {
		private var _uri:String;
		private var _image:Loader;
		public var x:Number = 0;
		public var y:Number = 0;
		
		public function get uri():String {
			return _uri;
		}
		
		public function set uri(uri:String):void {
			_uri = uri;
			_image = new Loader();
			_image.x = x;
			_image.y = y;
			_image.load(new URLRequest(_uri));
		}
		
		public function get image():Loader {
			return _image;
		}
	}
}
