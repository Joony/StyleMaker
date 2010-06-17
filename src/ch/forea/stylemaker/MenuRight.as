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
			addChild(background);
			
			var closeButton:ImageDTO = new ImageDTO();
			closeButton.uri = 'img/icon_close.png';
			closeButton.x = 10;
			closeButton.y = 10;
			closeButton.addEventListener(MouseEvent.MOUSE_DOWN, close);
			addChild(closeButton);
			
			var printButton:ImageDTO = new ImageDTO();
			printButton.uri = 'img/icon_print.png';
			printButton.x = 10;
			printButton.y = 660;			printButton.addEventListener(MouseEvent.MOUSE_DOWN, print);
			addChild(printButton);
		}
		
		private function print(e:MouseEvent):void{
			dispatchEvent(new Event(PRINT));
		}
		
		private function close(e:MouseEvent):void{
			dispatchEvent(new Event(CLOSE));
		}
	}
}
