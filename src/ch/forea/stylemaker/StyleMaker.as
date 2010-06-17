package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.DataDTO;
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.event.SubMenuEvent;

	import com.gskinner.motion.GTween;
	import com.gskinner.motion.GTweener;
	import com.gskinner.motion.easing.Circular;
	import com.gskinner.motion.easing.Sine;

	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author jonathanmcallister
	 */
	public class StyleMaker extends Sprite {
		
		private var fullscreenButton:Sprite = new Sprite();
		private var door_left:ImageDTO;		private var door_right:ImageDTO;
		private var preview:Preview ;		private var menu_left:Menu = new Menu();		private var menu_right:MenuRight;
		private var dataLoader:DataLoader;
		private var print:Print;
		private var fileSize:uint;
		
		[Embed(source="../../../../fonts/Goudy.swf#GoudyBold14Text")]
    	public var GoudyBold14:Class;
    	
    	[Embed(source="../../../../fonts/Goudy.swf#GoudyBold20Text")]
    	public var GoudyBold20:Class;
		
		public function StyleMaker() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var m:Sprite = new Sprite();
			m.graphics.beginFill(0xff);
			m.graphics.drawRect(0, 0, 1280, 768);
			m.graphics.endFill();
			addChild(m);
			this.mask = m;
			
			
//			CREATING XML
//			trace("data", new XMLCreator().parse(new DataCreator().createData()));
//			
//			trace(new DataCreator().createData());
//			
			dataLoader = new DataLoader();
			dataLoader.addEventListener(Event.COMPLETE, loaded); 	
			dataLoader.load();		
//			
			
		}
		
		private function fullscreen(e:MouseEvent):void{
			if(stage.displayState == StageDisplayState.NORMAL){
                try{
                    stage.displayState = StageDisplayState.FULL_SCREEN;
                    removeChild(fullscreenButton);
                }
                catch (e:SecurityError){
                    trace("an error has occured. please modify the html file to allow fullscreen mode");
                }
            }
		}
		
		private function loaded(e:Event):void{
			dataLoader.removeEventListener(Event.COMPLETE, loaded);
			
			fileSize = dataLoader.data.fileSize;
			addEventListener(Event.ENTER_FRAME, checkLoad);
			
			print = new Print((dataLoader.data.clone() as DataDTO).categories, dataLoader.data.background, dataLoader.data.logo);
						
			fullscreenButton.graphics.beginFill(0xff, 0);
			fullscreenButton.graphics.drawRect(0, 0, 1280, 768);
			fullscreenButton.graphics.endFill();
			fullscreenButton.addEventListener(MouseEvent.MOUSE_DOWN, fullscreen);
			fullscreenButton.mouseEnabled = true;
			addChild(fullscreenButton);
		}
		
		private function checkLoad(e:Event):void {
			trace(dataLoader.data.bytesLoaded);
			if(dataLoader.data.loaded){
				removeEventListener(Event.ENTER_FRAME, checkLoad);
				trace("FILESIZE = " + dataLoader.data.bytesLoaded);
				init();
			}
		}
		
		private function init():void{
			addChild(dataLoader.data.background.image);
			
			preview = new Preview(dataLoader.data.categories);
			preview.x = 505;
			addChild(preview);
			
			door_left = dataLoader.data.doorLeft;
			door_left.image.addEventListener(MouseEvent.MOUSE_DOWN, open_doors);
			addChild(door_left.image);
			
			door_right = dataLoader.data.doorRight;
			door_right.x = 638;
			door_right.image.addEventListener(MouseEvent.MOUSE_DOWN, open_doors);
			//door_right.filters = [new BlurFilter(20, 20, BitmapFilterQuality.HIGH)];
			addChild(door_right.image);
			
			menu_left.addEventListener(SubMenuEvent.UPDATE_PREVIEW, updatePreview);
			menu_left.setData(dataLoader.data.categories, dataLoader.data.menuLeftBg, dataLoader.data.subMenuBg, dataLoader.data.logo);
			menu_left.x = -313;
			addChild(menu_left);
			
			menu_right = new MenuRight(dataLoader.data.menuRightBg, dataLoader.data.printBtn, dataLoader.data.closeBtn);
			menu_right.x = 1280;
			menu_right.addEventListener(MenuRight.PRINT, printPage);
			menu_right.addEventListener(MenuRight.CLOSE, close);
			addChild(menu_right);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, closeSubMenus);
		}
		
		private function printPage(e:Event):void{
			print.visible = false;
			addChild(print);
			print.print(menu_left.getSelectedOptions());
			removeChild(print);
		}
		
		private function closeSubMenus(e:MouseEvent):void{
			menu_left.deselectMenu();
		}
		
		private function updatePreview(e:SubMenuEvent):void{
			preview.select(e.preview);
		}
		
		private function close(e:Event):void{
			menu_left.deselectMenu();
			close_menu();
		}
		
		private function open_doors(e:MouseEvent = null):void{
			GTweener.to(door_left, 1.5, {x:-640}, {repeatCount:1,ease:Circular.easeOut,onComplete:open_menu});
			GTweener.to(door_right, 1.5, {x:1280}, {repeatCount:1,ease:Circular.easeOut});		}
		private function open_menu(t:GTween = null):void{
			GTweener.to(menu_left, 1, {x:0}, {repeatCount:1,ease:Sine.easeOut});				GTweener.to(menu_right, 1, {x:1209}, {repeatCount:1,ease:Sine.easeOut});	
		}
		
		private function close_menu(e:Event = null):void{
			GTweener.to(menu_left, 1, {x:-313}, {repeatCount:1, ease:Circular.easeOut, onComplete:close_doors});			GTweener.to(menu_right, 1, {x:1280}, {repeatCount:1, ease:Circular.easeOut});
		}
		private function close_doors(t:GTween = null):void{
			GTweener.to(door_left, 1.5, {x:0}, {repeatCount:1,ease:Sine.easeOut});
			GTweener.to(door_right, 1.5, {x:638}, {repeatCount:1, ease:Sine.easeOut});
		}
	}
}
