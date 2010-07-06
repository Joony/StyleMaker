package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author jonathanmcallister
	 */
	public class MenuRight extends Sprite {
		
		public static const PRINT:String = "print";		public static const CLOSE:String = "close";		public static const EMAIL:String = "email";
		
		public function MenuRight(background:ImageDTO, printButton:ImageDTO, closeButton:ImageDTO, emailButton:ImageDTO) {
			var background:ImageDTO = background;
			addChild(background.image);
			
			var closeButton:ImageDTO = closeButton;
			closeButton.x = (background.image.width / 2) - (closeButton.image.width / 2);
			closeButton.y = (background.image.width / 2) - (closeButton.image.height / 2);
			closeButton.image.addEventListener(MouseEvent.MOUSE_DOWN, close);
			addChild(closeButton.image);
			
			var printButton:ImageDTO = printButton;
			printButton.x = (background.image.width / 2) - (printButton.image.width / 2);
			printButton.y = 995;			printButton.image.addEventListener(MouseEvent.MOUSE_DOWN, print);
			addChild(printButton.image);
			
			var emailButton:ImageDTO = emailButton;
			emailButton.x = (background.image.width / 2) - (printButton.image.width / 2);
			emailButton.y = 915;
			emailButton.image.addEventListener(MouseEvent.MOUSE_DOWN, email);
			addChild(emailButton.image);
		}
		
		private function print(e:MouseEvent):void{
			dispatchEvent(new Event(PRINT));
		}
		
		private function close(e:MouseEvent):void{
			dispatchEvent(new Event(CLOSE));
		}
		
		private function email(e:MouseEvent):void{
			dispatchEvent(new Event(EMAIL));
		}
	}
}
