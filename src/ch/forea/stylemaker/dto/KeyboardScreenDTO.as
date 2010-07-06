package ch.forea.stylemaker.dto {
	import ch.forea.dto.AbstractDTO;

	/**
	 * @author alyoka
	 */
	public class KeyboardScreenDTO extends AbstractDTO {
		public var name:String;
		public var keys:Vector.<KeyDTO>;
		public var x:int;
		public var y:int;	}
}
