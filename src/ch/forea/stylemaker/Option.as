package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.SampleDTO;

	import flash.display.Sprite;

	/**
	 * @author jonathanmcallister
	 */
	public class Option extends Sprite{
		public var data:SampleDTO;
		
		public function Option(data:SampleDTO){
			this.data = data;
			addChild(data.thumbSmall);
		}
	}
}
