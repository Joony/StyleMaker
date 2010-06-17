package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.CategoryDTO;
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
		
		private var door_left:ImageDTO = new ImageDTO();		private var door_right:ImageDTO = new ImageDTO();		private var menu_left:Menu;		private var menu_right:ImageDTO = new ImageDTO();
		
//		[Embed(source="../../../../img/default_bed.png")]
//		private var Bed:Class;
		
		
		public function StyleMaker() {
			
			var data_creator:DataCreator = new DataCreator();
			var data:Vector.<CategoryDTO> = data_creator.createData().categories;
			
			var background:ImageDTO = new ImageDTO();
			background.uri = 'img/background.png';
			addChild(background.image);
			
//			var bed:ImageDTO = new ImageDTO();
//			bed.x = 505;
//			bed.y = 245;
//			bed.uri = 'img/default_bed.png';
//			addChild(bed.image);
			
			var preview:Preview = new Preview(data);
			preview.x = 505;
			addChild(preview);
			
			door_left.uri = 'img/screen_door_left.png';
			door_left.image.addEventListener(MouseEvent.MOUSE_DOWN, open_doors);
			addChild(door_left.image);
			
			door_right.uri = 'img/screen_door_right.png';
			door_right.image.x = 638;
			//door_right.image.filters = [new BlurFilter(20, 20, BitmapFilterQuality.HIGH)];
			addChild(door_right.image);
			
			menu_left = new Menu(data);
			menu_left.x = -313;
			//menu_left.addEventListener(MouseEvent.MOUSE_DOWN, close_menu);
			addChild(menu_left);
			
			menu_right.uri = 'img/option_door_right.png';
			menu_right.image.x = 1280;
			addChild(menu_right.image);

//			var p:Print = new Print();
//			p.visible = false;
//			addChild(p);
//			p.print(bed.clone().image);
//			removeChild(p);
			
		}
		
		private function open_doors(e:MouseEvent = null):void{
			GTweener.to(door_left.image, 1.5, {x:-640}, {repeatCount:1,ease:Circular.easeOut,onComplete:open_menu});
			GTweener.to(door_right.image, 1.5, {x:1280}, {repeatCount:1,ease:Circular.easeOut});		}
		private function open_menu(t:GTween = null):void{
			GTweener.to(menu_left, 1, {x:0}, {repeatCount:1,ease:Sine.easeOut});				GTweener.to(menu_right.image, 1, {x:1209}, {repeatCount:1,ease:Sine.easeOut});	
		}
		
		private function close_menu(e:MouseEvent = null):void{
			GTweener.to(menu_left, 1, {x:-313}, {repeatCount:1, ease:Circular.easeOut, onComplete:close_doors});			GTweener.to(menu_right.image, 1, {x:1280}, {repeatCount:1, ease:Circular.easeOut});
		}
		private function close_doors(t:GTween = null):void{
			GTweener.to(door_left.image, 1.5, {x:0}, {repeatCount:1,ease:Sine.easeOut});
			GTweener.to(door_right.image, 1.5, {x:638}, {repeatCount:1, ease:Sine.easeOut});
		}
	}
}
