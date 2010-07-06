package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.KeyDTO;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author jonathanmcallister
	 */
	public class Key extends Sprite {
		
		private var image:ImageDTO;
		private var highlight:ImageDTO;
		private var _text:String;		private var _shift:String;
		private var _action:String;
		private var shiftEnabled:Boolean = false;
		
		public function get text():String{
			return _text;
		}
		public function get shift():String{
			return _shift;
		}
		public function get action():String{
			return _action;
		}
		
		public function Key(data:KeyDTO) {
			image = data.image;
			highlight = data.highlight;
			if(highlight) highlight.image.mouseEnabled = false;
			_text = data.text;			_shift = data.shift;
			_action = data.action;
			addChild(image.image);
//			if(highlight){
//				image.image.addEventListener(MouseEvent.MOUSE_DOWN, select);//				image.image.addEventListener(MouseEvent.MOUSE_UP, deselect);
//				image.image.addEventListener(MouseEvent.ROLL_OUT, deselect);
//			}
		}
		
		public function select():void{
			if(highlight && !shiftEnabled) {
				addChild(highlight.image);
				highlight.image.mouseEnabled = false;
			}
			
		}
		
		public function deselect():void{
			if(highlight && !shiftEnabled && contains(highlight.image)) removeChild(highlight.image);
		}
		
		public function shiftHighlight(enabled:Boolean):void {
			shiftEnabled = enabled;
			if(highlight){
				if(shiftEnabled){
					if(!contains(highlight.image)){
						addChild(highlight.image);
					}
				}else{
					if(contains(highlight.image)){
						removeChild(highlight.image);
					}
				}
			}
		}
		
	}
}
