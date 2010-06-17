package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;
	import ch.forea.stylemaker.event.SubMenuEvent;

	import com.gskinner.motion.GTween;
	import com.gskinner.motion.GTweener;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * @author jonathanmcallister
	 */
	public class SubMenu extends Sprite {
		
		private var data:Vector.<SampleDTO>;
		private var title:String;
		private var options:Sprite = new Sprite();
		private var selected_option_image:ImageDTO;
		private var selected_option_title:TextField = new TextField();
		private var selected_option_button:Sprite = new Sprite();
		
		public function SubMenu(){}
		
		public function setData(data:Vector.<SampleDTO>, name:String):void {
			this.data = data;
			this.title = name;
			
			var selectedOption:SampleDTO = data[uint(getRandomNumber(0, data.length - 1))];
			
			var options_background:ImageDTO = new ImageDTO();
			options_background.uri = 'img/pull_out_background.png';
			options_background.image.x = -1280 + 320 + (60 * data.length) + 14;
			options.addChild(options_background.image);
			options.alpha = 0;
			addChild(options);
			
			selected_option_button.x = 185;
			selected_option_button.y = 4;
			selected_option_button.addEventListener(MouseEvent.MOUSE_DOWN, selected);
			addChild(selected_option_button);
			
			selected_option_image = selectedOption.thumbLarge;
			selected_option_button.addChild(selected_option_image.image);
			
			for(var i:uint = 0; i < data.length; i++){
				var option:Option = new Option(data[i]);
				option.x = 320 + 60 * i;
				option.y = 14;
				option.addEventListener(MouseEvent.MOUSE_DOWN, selectItem);
				options.addChild(option);
			}
			
			var title:TextField = new TextField();
			title.defaultTextFormat = new TextFormat(null, 20, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			title.text = name;
			title.y = 20;
			title.width = 180;
			title.height = 25;
			addChild(title);
			
			selected_option_title.defaultTextFormat = new TextFormat(null, 14, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			selected_option_title.text = selectedOption.name;
			selected_option_title.y = 50;
			selected_option_title.width = 180;
			selected_option_title.height = 25;
			selected_option_title.selectable = false;
			addChild(selected_option_title);
			
			dispatchEvent(new SubMenuEvent(SubMenuEvent.UPDATE_PREVIEW, name, selectedOption));
		}

		public static const OPEN:String = "open";		public static const CLOSE:String = "close";		private static const STATE_OPEN:String = "state_open";		private static const STATE_OPENING:String = "state_opening";		private static const STATE_CLOSED:String = "state_closed";		private static const STATE_CLOSING:String = "state_closing";
		private var state:String = STATE_CLOSED;
		public function command(message:String):void{
			switch(state){
				case STATE_OPEN:
					if(message == OPEN)
						return;
					else if(message == CLOSE){
						GTweener.to(options, .3, {alpha:0}, {repeatCount:1, onComplete:closed});	
						state = STATE_CLOSING;					}
				break;
				case STATE_OPENING:
					if(message == OPEN)
						return;
					else if(message == CLOSE){
						GTweener.to(options, .3, {alpha:0}, {repeatCount:1, onComplete:closed});
						state = STATE_CLOSING;						}
				break;
				case STATE_CLOSED:
					if(message == OPEN){
						GTweener.to(options, .5, {alpha:1}, {repeatCount:1, onComplete:opened});
						state = STATE_OPENING;						}else if(message == CLOSE)
						return;	
				break;
				case STATE_CLOSING:
					if(message == OPEN){
						GTweener.to(options, .5, {alpha:1}, {repeatCount:1, onComplete:opened});
						state = STATE_OPENING;	
					}else if(message == CLOSE)
						return;	
				break;
			}
		}
		
		private function opened(t:GTween):void{
			state = STATE_OPEN;
		}

		private function closed(t:GTween):void{
			state = STATE_CLOSED;
		}
	
		private function selected(e:MouseEvent):void{
			e.stopImmediatePropagation();
			dispatchEvent(new Event(Event.SELECT));
		}
	
		private function selectItem(e:MouseEvent):void{
			var selection:SampleDTO = (e.currentTarget as Option).data;
			selected_option_title.text = selection.name;
			selected_option_button.removeChild(selected_option_image.image);
			selected_option_image = selection.thumbLarge;
			selected_option_button.addChild(selected_option_image.image);
			dispatchEvent(new SubMenuEvent(SubMenuEvent.UPDATE_PREVIEW, title, selection));
		}
		
		private function getRandomNumber(low:uint, high:uint, skip:int = -1):uint{
     		if(skip >= 0){
 				var r:Number = 1;//Math.random();                                                                                                                                                                                                   
 				if(r == 1) return high;
 				var random:uint = Math.floor(r * (high - low)) + low;
				if(random >= skip) random++;
 				return random;
			}
 			return Math.floor(Math.random() * (1 + high - low)) + low;
 		}
	}
}
