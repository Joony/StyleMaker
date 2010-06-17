package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.event.SubMenuEvent;

	import com.gskinner.motion.GTween;
	import com.gskinner.motion.GTweener;
	import com.gskinner.motion.easing.Circular;
	import com.gskinner.motion.easing.Sine;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author jonathanmcallister
	 */
	public class StyleMaker extends Sprite {
		
		private var door_left:ImageDTO = new ImageDTO();		private var door_right:ImageDTO = new ImageDTO();
		private var preview:Preview ;		private var menu_left:Menu = new Menu();		private var menu_right:MenuRight = new MenuRight();
		private var dataLoader:DataLoader;
		private var p:Print;
		
		public function StyleMaker() {
			
		
//			CREATING XML
//			var data:DataDTO = new DataDTO();
//			data.categories = new DataCreator().createData();
//			trace("data", xmlc.parse(data));
			
//			trace(new DataCreator().createData());
			
			dataLoader = new DataLoader();
			dataLoader.addEventListener(Event.COMPLETE, loaded); 	
			dataLoader.load();		
			
			
		}
		
		private function loaded(e:Event):void{
			dataLoader.removeEventListener(Event.COMPLETE, loaded);
			//USE THIS
//			trace(dataLoader.data);
			
			var logo:ImageDTO = new ImageDTO();
			logo.uri = 'img/logo.png';
			
			var background:ImageDTO = new ImageDTO();
			background.uri = 'img/background.png';
			addChild(background.image);
			
			preview = new Preview(dataLoader.data.categories);
			preview.x = 505;
			addChild(preview);
			
			door_left.uri = 'img/screen_door_left.png';
			door_left.image.addEventListener(MouseEvent.MOUSE_DOWN, open_doors);
			addChild(door_left.image);
			
			door_right.uri = 'img/screen_door_right.png';
			door_right.image.x = 638;
			door_right.image.addEventListener(MouseEvent.MOUSE_DOWN, open_doors);
			//door_right.image.filters = [new BlurFilter(20, 20, BitmapFilterQuality.HIGH)];
			addChild(door_right.image);
			
			menu_left.addEventListener(SubMenuEvent.UPDATE_PREVIEW, updatePreview);
			menu_left.setData(dataLoader.data.categories);
			menu_left.x = -313;
			//menu_left.addEventListener(MouseEvent.MOUSE_DOWN, close_menu);
			addChild(menu_left);
			
			menu_right.x = 1280;
			menu_right.addEventListener(MenuRight.PRINT, print);			menu_right.addEventListener(MenuRight.CLOSE, close);
			addChild(menu_right);

			stage.addEventListener(MouseEvent.MOUSE_DOWN, closeSubMenus);

			p = new Print(dataLoader.data.categories, background, logo);
//			p.visible = false;
//			addChild(p);
//			removeChild(p);
		}
		
		private function closeSubMenus(e:MouseEvent):void{
			menu_left.deselectMenu();
		}
		
		private function updatePreview(e:SubMenuEvent):void{
			preview.select(e.preview);
		}
		
		private function print(e:Event):void{
			p.print([1,0,0,2,0,0,0]);
		}
		
		private function close(e:Event):void{
			menu_left.deselectMenu();
			close_menu();
		}
		
		private function open_doors(e:MouseEvent = null):void{
			GTweener.to(door_left.image, 1.5, {x:-640}, {repeatCount:1,ease:Circular.easeOut,onComplete:open_menu});
			GTweener.to(door_right.image, 1.5, {x:1280}, {repeatCount:1,ease:Circular.easeOut});		}
		private function open_menu(t:GTween = null):void{
			GTweener.to(menu_left, 1, {x:0}, {repeatCount:1,ease:Sine.easeOut});				GTweener.to(menu_right, 1, {x:1209}, {repeatCount:1,ease:Sine.easeOut});	
		}
		
		private function close_menu(e:Event = null):void{
			GTweener.to(menu_left, 1, {x:-313}, {repeatCount:1, ease:Circular.easeOut, onComplete:close_doors});			GTweener.to(menu_right, 1, {x:1280}, {repeatCount:1, ease:Circular.easeOut});
		}
		private function close_doors(t:GTween = null):void{
			GTweener.to(door_left.image, 1.5, {x:0}, {repeatCount:1,ease:Sine.easeOut});
			GTweener.to(door_right.image, 1.5, {x:638}, {repeatCount:1, ease:Sine.easeOut});
		}
	}
}
