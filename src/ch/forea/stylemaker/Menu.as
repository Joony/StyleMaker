package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;

	import flash.display.Sprite;

	public class Menu extends Sprite {
		
		private var background:ImageDTO = new ImageDTO();
		
		public function Menu() {
			background.uri = 'img/option_door_left.png';
			addChild(background.image);
			
			
		}
		
	}
}
