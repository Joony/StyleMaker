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
		
		public function MenuRight(background:ImageDTO, printButton:ImageDTO, closeButton:ImageDTO) {
			var background:ImageDTO = background;
			addChild(background.image);
			
			var closeButton:ImageDTO = closeButton;
			closeButton.x = 10;
			closeButton.y = 10;
			closeButton.image.addEventListener(MouseEvent.MOUSE_DOWN, close);
			addChild(closeButton.image);
			
			var printButton:ImageDTO = printButton;
			printButton.x = 10;
			printButton.y = 660;			printButton.image.addEventListener(MouseEvent.MOUSE_DOWN, print);
			addChild(printButton.image);
		}
		
		private function print(e:MouseEvent):void{
			dispatchEvent(new Event(PRINT));
		}
		
		private function close(e:MouseEvent):void{
			dispatchEvent(new Event(CLOSE));
		}
	}
}
