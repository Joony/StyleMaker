package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.KeyboardScreenDTO;
	import ch.forea.stylemaker.event.KeyEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author jonathanmcallister
	 */
	public class OnscreenKeyboard extends Sprite {

		private var shift : Boolean = false;
		private var shiftKey : Key;

		public function OnscreenKeyboard() {
		}

		public function setData(data : Vector.<KeyboardScreenDTO>) : void {
			var blanker:Sprite = new Sprite();
			blanker.graphics.beginFill(0xff, 0);
			blanker.graphics.drawRect(0, 0, 1920, 1080);
			addChild(blanker);
			
			var screen : Sprite = new Sprite();
			screen.x = data[0].x;
			screen.y = data[0].y;			var b:Sprite = new Sprite();
			b.graphics.beginFill(0xd1f7f9, .8);
			b.graphics.drawRect(0, 0, 830, 520);
			b.addEventListener(MouseEvent.MOUSE_DOWN, doNothing)
			screen.addChild(b);
			for(var i : uint = 0;i < data[0].keys.length; i++) {
				var key : Key = new Key(data[0].keys[i]);
				key.addEventListener(MouseEvent.MOUSE_DOWN, checkHighlight);
				key.addEventListener(MouseEvent.MOUSE_UP, activate);
				key.addEventListener(MouseEvent.ROLL_OVER, checkHighlight);				key.addEventListener(MouseEvent.ROLL_OUT, checkUnhighlight);
				screen.addChild(key);
				if(data[0].keys[i].action == "shift")
					shiftKey = key;
			}
			addChild(screen);
		}

		private function checkHighlight(e : MouseEvent) : void {
			e.stopPropagation();
			var key : Key = e.currentTarget as Key;
			if(e.buttonDown) key.select();		}

		private function checkUnhighlight(e : MouseEvent) : void {
			var key : Key = e.currentTarget as Key;
			if(e.buttonDown) key.deselect();
		}
		
		private function doNothing(e:MouseEvent):void{
			e.stopPropagation();
		}

		private function activate(e : MouseEvent) : void {
			e.stopPropagation();
			var key : Key = e.currentTarget as Key;
			key.deselect();
			switch(key.action) {
				case "shift":
					shift = !shift;
					shiftKey.shiftHighlight(shift);
					break;
				case "delete":
					dispatchEvent(new KeyEvent(KeyEvent.DELETE));
					if(shift) shift = false;					shiftKey.shiftHighlight(shift);					break;
				default:
					dispatchEvent(new KeyEvent(KeyEvent.INSERT, shift ? key.shift : key.text));
					if(shift) shift = false;
					shiftKey.shiftHighlight(shift);
			}
		}
	}
}
