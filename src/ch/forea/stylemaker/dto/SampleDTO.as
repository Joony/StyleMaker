package ch.forea.stylemaker.dto {
	import ch.forea.dto.AbstractDTO;

	/**
	 * @author alyoka
	 */
	public class SampleDTO extends AbstractDTO {
		public static const TYPE_TOP:String = "Matress Top";		public static const TYPE_BORDER:String = "Matress Border";		public static const TYPE_BASE:String = "Base/Platform";		public static const TYPE_EDGE:String = "Edge Tape";		public static const TYPE_LEG:String = "Leg";		public static const TYPE_HEADBOARD:String = "Headboard";		public static const TYPE_MATTRESS:String = "Mattress";
		
		public var name:String;		public var thumbSmall:ImageDTO;		public var thumbLarge:ImageDTO;		public var image:ImageDTO;
		public var productCode:String;
		
		public function get bytesLoaded():uint{
			return thumbSmall.bytesLoaded + thumbLarge.bytesLoaded + image.bytesLoaded;
		}
	}
}
