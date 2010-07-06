package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.DataDTO;
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;
	import ch.forea.stylemaker.event.SubMenuEvent;

	import com.gskinner.motion.GTween;
	import com.gskinner.motion.GTweener;
	import com.gskinner.motion.easing.Circular;
	import com.gskinner.motion.easing.Sine;

	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.clearInterval;
	import flash.utils.setTimeout;

	/**
	 * @author jonathanmcallister
	 */
	public class StyleMaker extends Sprite {
		
		private var fullscreenButton:Sprite = new Sprite();
		private var door_left:ImageDTO;		private var door_right:ImageDTO;
		private var preview:Preview;
		private var productCode:TextField;		private var menu_left:Menu = new Menu();		private var menu_right:MenuRight;
		private var dataLoader:DataLoader;
		private var print:Print;
		private var fileSize:uint;
		private var preloader:Sprite;
		private var environmentVariables:Object;
		private var inactivityTimer:uint;
		private var keyboard:OnscreenKeyboard;
		
		[Embed(source="../../../../fonts/Goudy.swf#GoudyBold21Text")]
    	public var GoudyBold21:Class;
    	
    	[Embed(source="../../../../fonts/Goudy.swf#GoudyBold30Text")]
    	public var GoudyBold30:Class;
		
		public function StyleMaker() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			environmentVariables = getEnvironmentVariables(stage);
			
			var m:Sprite = new Sprite();
			m.graphics.beginFill(0xff);
			m.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			m.graphics.endFill();
			addChild(m);
			this.mask = m;
			
			//if(environmentVariables["kiosk"] == true)
//				Mouse.hide();
			
			
//			CREATING XML
//			trace("data", new XMLCreator().parse(new DataCreator().createData()));
//			
//			trace(new DataCreator().createData());
//			
			dataLoader = new DataLoader();
			dataLoader.addEventListener(Event.COMPLETE, loaded); 	
			dataLoader.load();		
//			
			preloader = new Sprite();
			preloader.graphics.beginFill(0xff);
			preloader.graphics.drawRect(-10, -10, 20, 20);
			preloader.graphics.endFill();
			preloader.x = stage.stageWidth / 2;
			preloader.y = stage.stageHeight / 2;
			addChild(preloader);
			
			
		}
		
		private function inactivityCheck(e:MouseEvent = null):void{
			if(inactivityTimer) clearInterval(inactivityTimer);
			inactivityTimer = setTimeout(reset, dataLoader.data.inactivityTimeout * (60 * 1000));
		}

		private function reset():void{
			close();
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
			
			print = new Print((dataLoader.data.clone() as DataDTO).categories, dataLoader.data.background, dataLoader.data.printlogo);
		}
		
		private function checkLoad(e:Event):void {
			trace(dataLoader.data.bytesLoaded);
			
			preloader.rotation += 10;
			
			if(dataLoader.data.loaded){
				removeChild(preloader);
				removeEventListener(Event.ENTER_FRAME, checkLoad);
				trace("FILESIZE = " + dataLoader.data.bytesLoaded);
				init();
			}
		}
		
		private function init():void{
			addChild(dataLoader.data.background.image);
			
			preview = new Preview(dataLoader.data.categories);
			preview.x = 585;
			preview.y = 240;
			addChild(preview);
			
			productCode = new TextField();
			productCode.defaultTextFormat = new TextFormat(null, 21, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			productCode.x = 1400;
			productCode.y = 1040;
			productCode.width = 400;
			productCode.height = 50;
			addChild(productCode);
			
			door_left = dataLoader.data.doorLeft;
			door_left.image.addEventListener(MouseEvent.MOUSE_DOWN, open_doors);
			addChild(door_left.image);
			
			door_right = dataLoader.data.doorRight;
			door_right.x = stage.stageWidth - door_right.image.width;
			door_right.image.addEventListener(MouseEvent.MOUSE_DOWN, open_doors);
			//door_right.filters = [new BlurFilter(20, 20, BitmapFilterQuality.HIGH)];
			addChild(door_right.image);
			
			menu_left.addEventListener(SubMenuEvent.UPDATE_PREVIEW, updatePreview);
			menu_left.setData(dataLoader.data.categories, dataLoader.data.menuLeftBg, dataLoader.data.subMenuBg, dataLoader.data.logo);
			menu_left.x = 0 - menu_left.width;
			addChild(menu_left);

			stage.addEventListener(MouseEvent.MOUSE_DOWN, closeSubMenus);
			
			menu_right = new MenuRight(dataLoader.data.menuRightBg, dataLoader.data.printBtn, dataLoader.data.closeBtn, dataLoader.data.emailBtn);
			menu_right.x = stage.stageWidth;
			menu_right.addEventListener(MenuRight.PRINT, printPage);
			menu_right.addEventListener(MenuRight.CLOSE, close);
			menu_right.addEventListener(MenuRight.EMAIL, email);
			addChild(menu_right);
			
			keyboard = new OnscreenKeyboard();
			keyboard.setData(dataLoader.data.keyboard);
			keyboard.addEventListener(MouseEvent.MOUSE_DOWN, closeKeyboard);
			//addChild(keyboard);
			
			
			fullscreenButton.graphics.beginFill(0xff, 0);
			fullscreenButton.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			fullscreenButton.graphics.endFill();
			fullscreenButton.addEventListener(MouseEvent.MOUSE_DOWN, fullscreen);
			fullscreenButton.mouseEnabled = true;
			addChild(fullscreenButton);

			
		}
		
		private function getEnvironmentVariables(referenceToStage:DisplayObject):Object{
			var environmentVariables:Object = (referenceToStage.root.loaderInfo as LoaderInfo).parameters;
//			var url:String = ExternalInterface.call("document.location.search.toString");
//			var pairs:Array = url.split("?");
//			if(pairs[1]){
//				pairs = pairs[1].split("&");
//				var keysAndValues:Array;
//				var l:uint = pairs.length;
//				for(var i:uint=0;i<l;i++){
//					keysAndValues = pairs[i].split("=");
//					environmentVariables[keysAndValues[0]] = (keysAndValues[1] == "true") ? true : (keysAndValues[1] == "false") ? false : keysAndValues[1];
//				}
//			}
			return environmentVariables;
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
		
		private function closeKeyboard(e:MouseEvent):void{
			if(contains(keyboard)) removeChild(keyboard);			
		}
		
		private function updatePreview(e:SubMenuEvent):void{
			preview.select(e.preview);
			
			var selected:Array = menu_left.getSelectedOptions();
			var sample:SampleDTO;
			var id:String = "Product code: ";
			for(var i:uint = 0; i<selected.length; i++){
				sample = dataLoader.data.categories[i].samples[selected[i]];
				id += sample.productCode;
			}
			productCode.text = id;
		}
		
		private function close(e:Event = null):void{
			menu_left.deselectMenu();
			if(stage.hasEventListener(MouseEvent.MOUSE_MOVE)) stage.removeEventListener(MouseEvent.MOUSE_MOVE, inactivityCheck);
			if(inactivityTimer) clearInterval(inactivityTimer);
			close_menu();
		}
		
		private function email(e:Event):void{
			menu_left.deselectMenu();
			trace("email")
			addChild(keyboard);
		}
		
		private function open_doors(e:MouseEvent = null):void{
			if(!stage.hasEventListener(MouseEvent.MOUSE_MOVE))
				stage.addEventListener(MouseEvent.MOUSE_MOVE, inactivityCheck);
			inactivityCheck();
			GTweener.to(door_left, 1.5, {x:0 - door_left.image.width}, {repeatCount:1,ease:Circular.easeOut,onComplete:open_menu});
			GTweener.to(door_right, 1.5, {x:stage.stageWidth}, {repeatCount:1,ease:Circular.easeOut});		}
		private function open_menu(t:GTween = null):void{
			GTweener.to(menu_left, 1, {x:0}, {repeatCount:1,ease:Sine.easeOut});				GTweener.to(menu_right, 1, {x:stage.stageWidth - menu_right.width}, {repeatCount:1,ease:Sine.easeOut});	
		}
		
		private function close_menu(e:Event = null):void{
			GTweener.to(menu_left, 1, {x:0 - menu_left.width}, {repeatCount:1, ease:Circular.easeOut, onComplete:close_doors});			GTweener.to(menu_right, 1, {x:stage.stageWidth}, {repeatCount:1, ease:Circular.easeOut});
		}
		private function close_doors(t:GTween = null):void{
			GTweener.to(door_left, 1.5, {x:0}, {repeatCount:1,ease:Sine.easeOut});
			GTweener.to(door_right, 1.5, {x:stage.stageWidth - door_right.image.width}, {repeatCount:1, ease:Sine.easeOut});
		}
	}
}
