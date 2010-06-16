package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class Menu extends Sprite {
		
		private var subMenus:Array = [];
		
		public function Menu() {
			var background:ImageDTO = new ImageDTO();
			background.uri = 'img/option_door_left.png';
			addChild(background.image);
			
			var logo:ImageDTO = new ImageDTO();
			logo.uri = 'img/logo.png';
			addChild(logo.image);
			
			var data_creator:DataCreator = new DataCreator();
			var data:Dictionary = data_creator.createData();
			
			createSubMenu(data[SampleDTO.TYPE_TOP], SampleDTO.TYPE_TOP, 125);
			createSubMenu(data[SampleDTO.TYPE_BORDER], SampleDTO.TYPE_BORDER, 207);
			createSubMenu(data[SampleDTO.TYPE_BASE], SampleDTO.TYPE_BASE, 289);			createSubMenu(data[SampleDTO.TYPE_EDGE], SampleDTO.TYPE_EDGE, 371);			createSubMenu(data[SampleDTO.TYPE_LEG], SampleDTO.TYPE_LEG, 453);			createSubMenu(data[SampleDTO.TYPE_HEADBOARD], SampleDTO.TYPE_HEADBOARD, 535);			createSubMenu(data[SampleDTO.TYPE_MATTRESS], SampleDTO.TYPE_MATTRESS, 617);
			
		}
		
		private function createSubMenu(data:Array, name:String, y:int):void{
			var sub_menu:SubMenu = new SubMenu(data, name);
//			sub_menu.addEventListener(Event.OPEN, close);			sub_menu.addEventListener(Event.SELECT, selectSubMenu);
			sub_menu.y = y;
			subMenus[subMenus.length] = sub_menu;
			addChild(sub_menu);
		}
		
		private function selectSubMenu(e:Event):void{
			trace('captured selected', e.currentTarget)
			for each(var i:SubMenu in subMenus)
				(i == e.currentTarget) ? i.command(SubMenu.OPEN) : i.command(SubMenu.CLOSE);
		}
		
//		private function close(e:Event):void{
//			for each(var i:SubMenu in subMenus){
//				if(i != e.currentTarget)
//					i.close();
//			}
//		}
		
	}
}
