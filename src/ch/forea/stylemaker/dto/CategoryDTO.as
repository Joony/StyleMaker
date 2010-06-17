package ch.forea.stylemaker.dto {
	import ch.forea.dto.AbstractDTO;

	/**
	 * @author alyoka
	 */
	public class CategoryDTO extends AbstractDTO {
		public var name:String;
		public var samples:Vector.<SampleDTO>;
		
		private var _loaded:Boolean = false;
		
		public function get bytesLoaded():uint{
			var bytes:uint;
			for each(var sample:SampleDTO in samples){
				bytes += sample.bytesLoaded;			}
			return bytes;
		}
		
		public function get loaded():Boolean{
			if(!_loaded){
				_loaded = true;
				for each(var sample:SampleDTO in samples){
					if(!sample.loaded) {
						_loaded = false;
						break;
					}
				}
			}
			return _loaded;
		}
	}
}
