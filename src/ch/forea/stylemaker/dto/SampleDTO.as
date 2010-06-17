package ch.forea.stylemaker.dto {
	import ch.forea.dto.AbstractDTO;

	/**
	 * @author alyoka
	 */
	public class SampleDTO extends AbstractDTO {
		public var name:String;
		public var thumbSmall:ImageDTO;		public var thumbLarge:ImageDTO;		public var image:ImageDTO;
		public var productCode:String;
		
		private var _loaded:Boolean = false;
		
		public function get bytesLoaded():uint{
			return thumbSmall.bytesLoaded + thumbLarge.bytesLoaded + image.bytesLoaded;
		}
		
		public function get loaded():Boolean{
			if(!_loaded){
				_loaded = (thumbSmall.loaded && thumbLarge.loaded && image.loaded);
			}
			return _loaded;
		}
	}
}
