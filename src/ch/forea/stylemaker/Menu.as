package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;

	import flash.display.Sprite;
	import flash.utils.Dictionary;

	public class Menu extends Sprite {
		
		public function Menu() {
			var background:ImageDTO = new ImageDTO();
			background.uri = 'img/option_door_left.png';
			addChild(background.image);
			
			var logo:ImageDTO = new ImageDTO();
			logo.uri = 'img/logo.png';
			addChild(logo.image);
			
			var data_creator:DataCreator = new DataCreator();
			var data:Dictionary = data_creator.createData();
			
			createSubMenu(data[SampleDTO.TYPE_TOP], 125);
			createSubMenu(data[SampleDTO.TYPE_BORDER], 207);
			createSubMenu(data[SampleDTO.TYPE_BASE], 289);			createSubMenu(data[SampleDTO.TYPE_EDGE], 371);			createSubMenu(data[SampleDTO.TYPE_LEG], 453);			createSubMenu(data[SampleDTO.TYPE_HEADBOARD], 535);			createSubMenu(data[SampleDTO.TYPE_MATTRESS], 617);
			
		}
		
		private function createSubMenu(data:Array, y:int):void{
			var sub_menu:SubMenu = new SubMenu(data);
			sub_menu.y = y;
			addChild(sub_menu);
		}
		
	}
}
