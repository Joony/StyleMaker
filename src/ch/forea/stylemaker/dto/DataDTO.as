package ch.forea.stylemaker.dto {
	import ch.forea.dto.AbstractDTO;

	/**
	 * @author alyoka
	 */
	public class DataDTO extends AbstractDTO {
		public var categories:Vector.<CategoryDTO>;
		public var background:ImageDTO;
		public var logo:ImageDTO;		public var doorLeft:ImageDTO;		public var doorRight:ImageDTO;		public var menuLeftBg:ImageDTO;		public var menuRightBg:ImageDTO;		public var subMenuBg:ImageDTO;		public var printBtn:ImageDTO;		public var closeBtn:ImageDTO;		public var fileSize:uint;	}
}
