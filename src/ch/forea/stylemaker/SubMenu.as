package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;
	import ch.forea.stylemaker.dto.TitleDTO;
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
		private var selected_option:uint = 0;
		
		public function SubMenu(){}
		
		public function get selectedOption():uint{
			return selected_option;
		}
		
		public function setData(data:Vector.<SampleDTO>, name:String, background:ImageDTO, width:Number, titles:Vector.<TitleDTO>):void {
			this.data = data;
			this.title = name;
			
			selected_option = getRandomNumber(0, data.length - 1); 
			
			var selectedOptionDTO:SampleDTO = data[selected_option];
			
			var options_background:ImageDTO = background.clone();
			options_background.x = 0 - background.image.width + width;// + (88 * data.length) + 23;
			options_background.y = -5;
			options.addEventListener(MouseEvent.MOUSE_DOWN, doNothing);
			options.addChild(options_background.image);
			options.alpha = 0;
			addChild(options);
			
			selected_option_button.x = 285;
			selected_option_button.y = 4;
			selected_option_button.addEventListener(MouseEvent.MOUSE_DOWN, selected);
			addChild(selected_option_button);
			
			selected_option_image = selectedOptionDTO.thumbLarge;
			selected_option_button.addChild(selected_option_image.image);
			
			for(var i:uint = 0; i < data.length; i++){
				var option:Option = new Option(data[i]);
//				if(name == "Mattress"){
//					option.x = data[i].thumbSmall.x;
//					option.y = data[i].thumbSmall.y;
//					trace(option.x, (width + 10 + 88 * i))
//				}else{
//					option.x = width + 10 + 88 * i;
//					option.y = 16;
//				}
				option.addEventListener(MouseEvent.MOUSE_DOWN, selectItem);
				options.addChild(option);
			}
			
			if(titles && titles.length){
				for(i = 0;i < titles.length; i++){
					var subTitle:TextField = new TextField();
					subTitle.defaultTextFormat = new TextFormat("Goudy Old Style", 21, 0x4f4b45, true);
					subTitle.text = titles[i].text;
					subTitle.x = titles[i].x;					subTitle.y = titles[i].y;
					subTitle.width = 260;
					subTitle.height = 30;
					subTitle.selectable = false;
					subTitle.addEventListener(MouseEvent.MOUSE_DOWN, doNothing);
					options.addChild(subTitle);
				}
			}
			
//			trace all the embedded fonts
//			var fontList:Array = Font.enumerateFonts(false);
//			for (var i:uint=0; i<fontList.length; i++) {
//			    trace("font: "+fontList[i].fontName);
//			}
			
			var title:TextField = new TextField();
			title.defaultTextFormat = new TextFormat("Goudy Old Style", 30, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			title.text = name;
			title.y = 27;
			title.width = 260;
			title.height = 40;
			title.selectable = false;
			title.addEventListener(MouseEvent.MOUSE_DOWN, doNothing);
			addChild(title);
			
			selected_option_title.defaultTextFormat = new TextFormat("Goudy Old Style", 21, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			selected_option_title.text = selectedOptionDTO.name;
			selected_option_title.y = 67;
			selected_option_title.width = 260;
			selected_option_title.height = 30;
			selected_option_title.selectable = false;
			selected_option_title.addEventListener(MouseEvent.MOUSE_DOWN, doNothing);
			addChild(selected_option_title);
			
			dispatchEvent(new SubMenuEvent(SubMenuEvent.UPDATE_PREVIEW, name, selectedOptionDTO));
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
		
		private function doNothing(e:MouseEvent):void{
			if(state == STATE_OPEN)
				e.stopPropagation();
		}
	
		private function selected(e:MouseEvent):void{
			e.stopPropagation();
			if(state != STATE_OPEN)
				dispatchEvent(new Event(Event.SELECT));
			else
				command(CLOSE);
		}
	
		private function selectItem(e:MouseEvent):void{
			if(state == STATE_OPEN){
				e.stopPropagation();
				var selection:SampleDTO = (e.currentTarget as Option).data;
				selected_option_title.text = selection.name;
				selected_option_button.removeChild(selected_option_image.image);
				selected_option_image = selection.thumbLarge;
				selected_option_button.addChild(selected_option_image.image);
				
				for(var i:uint = 0; i < data.length; i++){
					if(selection == data[i])
						selected_option = i;
				}
				
				dispatchEvent(new SubMenuEvent(SubMenuEvent.UPDATE_PREVIEW, title, selection));
			}
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
