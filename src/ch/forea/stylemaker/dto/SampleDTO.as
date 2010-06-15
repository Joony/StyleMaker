package ch.forea.stylemaker.dto {
	import ch.forea.stylemaker.dto.AbstractDTO;

	/**
	 * @author alyoka
	 */
	public class SampleDTO extends AbstractDTO {
		public var TYPE_TOP:String = "MatressTop";		public var TYPE_BORDER:String = "MatressBorder";		public var TYPE_BASE:String = "Base";		public var TYPE_EDGE:String = "EdgeTape";		public var TYPE_LEG:String = "Leg";		public var TYPE_HEADBOARD:String = "HeadBoard";		public var TYPE_MATTRESS:String = "Mattress";
		
		public var type:String;
		public var name:String;		public var thumb:ImageDTO;		public var image:ImageDTO;
		public var productCode:String;
	}
}
