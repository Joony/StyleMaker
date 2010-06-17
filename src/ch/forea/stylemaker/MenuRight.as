package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author jonathanmcallister
	 */
	public class MenuRight extends Sprite {
		
		public static const PRINT:String = "print";		public static const CLOSE:String = "close";
		
		public function MenuRight() {
			var background:ImageDTO = new ImageDTO();
			background.uri = 'img/option_door_right.png';
			addChild(background.image);
			
			var closeButton:ImageDTO = new ImageDTO();
			closeButton.uri = 'img/icon_close.png';
			closeButton.x = 10;
			closeButton.y = 10;
			addChild(closeButton.image);
			
			var printButton:ImageDTO = new ImageDTO();
			printButton.uri = 'img/icon_print.png';
			printButton.x = 10;
			printButton.y = 660;
			printButton.image.addEventListener(MouseEvent.MOUSE_DOWN, print);
			addChild(printButton.image);
		}
		
		private function print(e:MouseEvent):void{
			dispatchEvent(new Event(PRINT));
		}
	}
}
