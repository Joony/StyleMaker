package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.CategoryDTO;
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;
	import ch.forea.stylemaker.event.SubMenuEvent;

	import flash.display.Sprite;
	import flash.events.Event;

	public class Menu extends Sprite {
		
		private var subMenus:Array = [];
		
		public function Menu(){}
		
		public function setData(data:Vector.<CategoryDTO>):void{
			var background:ImageDTO = new ImageDTO();
			background.uri = 'img/option_door_left.png';
			addChild(background);
			
			var logo:ImageDTO = new ImageDTO();
			logo.uri = 'img/logo.png';
			addChild(logo);
			
			for(var i:uint = 0; i < data.length; i++){
				createSubMenu(data[i].samples, data[i].name, 125 + 82 * i);
			}
			
		}
		
		private function createSubMenu(data:Vector.<SampleDTO>, name:String, y:int):void{
			var sub_menu:SubMenu = new SubMenu();
			sub_menu.addEventListener(SubMenuEvent.UPDATE_PREVIEW, updatePreview);			sub_menu.addEventListener(Event.SELECT, selectSubMenu);
			sub_menu.setData(data, name);
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
