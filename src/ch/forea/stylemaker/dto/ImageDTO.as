package ch.forea.stylemaker.dto {
	import flash.net.URLRequest;
	import ch.forea.stylemaker.dto.AbstractDTO;

	import flash.display.Loader;

	/**
	 * @author alyoka
	 */
	public class ImageDTO extends AbstractDTO {
		private var _uri:String;
		public var image:Loader;
		
		public function get uri():String {
			return _uri;
		}
		
		public function set uri(uri:String):void {
			_uri = uri;
			image = new Loader();
			image.load(new URLRequest(_uri));
		}
	}
}
