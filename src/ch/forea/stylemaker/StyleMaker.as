package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;

	import com.gskinner.motion.GTween;
	import com.gskinner.motion.GTweener;
	import com.gskinner.motion.easing.Circular;
	import com.gskinner.motion.easing.Sine;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author jonathanmcallister
	 */
	public class StyleMaker extends Sprite {
		
		private var door_left:ImageDTO = new ImageDTO();		private var door_right:ImageDTO = new ImageDTO();		private var menu_left:ImageDTO = new ImageDTO();		private var menu_right:ImageDTO = new ImageDTO();
		
		public function StyleMaker() {
			
			var background:ImageDTO = new ImageDTO();
			background.uri = 'img/background.png';
			addChild(background.image);
			
			var bed:ImageDTO = new ImageDTO();
			bed.uri = 'img/default_bed.png';
			bed.image.x = 505;
			bed.image.y = 245;
			addChild(bed.image);
			
			door_left.uri = 'img/screen_door_left.png';
			door_left.image.addEventListener(MouseEvent.MOUSE_DOWN, open_doors);
			addChild(door_left.image);
			
			door_right.uri = 'img/screen_door_right.png';
			door_right.image.x = 638;
			//door_right.image.filters = [new BlurFilter(20, 20, BitmapFilterQuality.HIGH)];
			addChild(door_right.image);
			
			menu_left.uri = 'img/option_door_left.png';
			menu_left.image.x = -313;
			menu_left.image.addEventListener(MouseEvent.MOUSE_DOWN, close_menu);
			addChild(menu_left.image);
			
			//var ps:PrintSetup = new PrintSetup();
			//ps.print();
		}
		
		private function open_doors(e:MouseEvent = null):void{
			GTweener.to(door_left.image, 1, {x:-640}, {repeatCount:1,ease:Circular.easeOut,onComplete:open_menu});
			GTweener.to(door_right.image, 1, {x:1280}, {repeatCount:1,ease:Circular.easeOut});		}
		private function open_menu(t:GTween = null):void{
			GTweener.to(menu_left.image, 1, {x:0}, {repeatCount:1,ease:Sine.easeOut});	
		}
		
		private function close_menu(e:MouseEvent = null):void{
			GTweener.to(menu_left.image, 1, {x:-313}, {repeatCount:1, ease:Circular.easeOut, onComplete:close_doors});
		}
		private function close_doors(t:GTween = null):void{
			GTweener.to(door_left.image, 1, {x:0}, {repeatCount:1,ease:Sine.easeOut});
			GTweener.to(door_right.image, 1, {x:638}, {repeatCount:1, ease:Sine.easeOut});
		}
	}
}
