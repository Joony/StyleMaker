package ch.forea.stylemaker.dto {
	import ch.forea.dto.AbstractDTO;

	/**
	 * @author alyoka
	 */
	public class CategoryDTO extends AbstractDTO {
		public var name:String;
		public var samples:Vector.<SampleDTO>;
		
		public function get bytesLoaded():uint{
			var bytes:uint;
			for each(var sample:SampleDTO in samples){
				bytes += sample.bytesLoaded;			}
			return bytes;
		}
	}
}
