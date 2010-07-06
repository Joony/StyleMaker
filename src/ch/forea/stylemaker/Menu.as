package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.CategoryDTO;
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;
	import ch.forea.stylemaker.event.SubMenuEvent;

	import flash.display.Sprite;
	import flash.events.Event;

	public class Menu extends Sprite {
		
		private var subMenus:Array = [];
		private var newWidth:Number;
		
		public function Menu(){}
		
		public function setData(data:Vector.<CategoryDTO>, background:ImageDTO, subMenuBackground:ImageDTO, logo:ImageDTO):void{
			var background:ImageDTO = background;
			addChild(background.image);
			
			newWidth = background.image.width;
			
			var logo:ImageDTO = logo;
			addChild(logo.image);
			
			for(var i:uint = 0; i < data.length; i++){
				createSubMenu(data[i].samples, data[i].name, 200 + 123 * i, subMenuBackground);
			}
			
		}
		
		public override function get width():Number{
			return newWidth;
		}
		
		private function createSubMenu(data:Vector.<SampleDTO>, name:String, y:int, background:ImageDTO):void{
			var sub_menu:SubMenu = new SubMenu();
			sub_menu.addEventListener(SubMenuEvent.UPDATE_PREVIEW, updatePreview);			sub_menu.addEventListener(Event.SELECT, selectSubMenu);
			sub_menu.setData(data, name, background, newWidth);
			sub_menu.y = y;
			subMenus[subMenus.length] = sub_menu;
			addChild(sub_menu);
		}
		
		private function updatePreview(e:SubMenuEvent):void{
			e.stopImmediatePropagation();
			dispatchEvent(e);
		}
		
		private function selectSubMenu(e:Event):void{
			for each(var i:SubMenu in subMenus)
				(i == e.currentTarget) ? i.command(SubMenu.OPEN) : i.command(SubMenu.CLOSE);
		}
		
		public function deselectMenu():void{
			for each(var i:SubMenu in subMenus)
				i.command(SubMenu.CLOSE);
		}
		
		public function getSelectedOptions():Array{
			var selectedOptions:Array = [];
			for(var i:uint = 0; i < subMenus.length; i++){
				selectedOptions[selectedOptions.length] = (subMenus[i] as SubMenu).selectedOption;
			}
			return selectedOptions;
		}
		
	}
}
