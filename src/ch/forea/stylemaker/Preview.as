package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.CategoryDTO;

	import flash.display.Sprite;

	/**
	 * @author jonathanmcallister
	 */
	public class Preview extends Sprite {
		
		public function Preview(data:Vector.<CategoryDTO>) {
			
			for(var i:uint = 0; i < data.length; i++){
				var layer:Sprite = new Sprite();
				layer.addChild(data[i].samples[0].image.image);
				addChild(layer);
			}
			
		}
		
		public function select():void{
			
		}
	}
}
