package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.CategoryDTO;
	import ch.forea.stylemaker.dto.PreviewDTO;

	import flash.display.Sprite;
	import flash.utils.Dictionary;

	/**
	 * @author jonathanmcallister
	 */
	public class Preview extends Sprite {
		
		private var layers:Dictionary = new Dictionary();
		
		public function Preview(data:Vector.<CategoryDTO>) {
			
			for(var i:uint = 0; i < data.length; i++){
				var layer:Sprite = new Sprite();
				addChild(layer);
				layers[data[i].name] = layer;
			}
			
		}
		
		public function select(data:PreviewDTO):void{
			var targetLayer:Sprite = layers[data.name];
			while(targetLayer.numChildren)
				targetLayer.removeChildAt(0);			
			layers[data.name].addChild(data.sample.image.image);
		}
	}
}
