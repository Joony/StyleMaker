package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.CategoryDTO;
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;

	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * @author alyoka
	 */
	public class Print extends Sprite{
		
		private var categories:Vector.<CategoryDTO>;
		private var content:Sprite;
		
		public function Print(categories:Vector.<CategoryDTO>, bg:ImageDTO, logo:ImageDTO){
			this.categories = categories;
			content = new Sprite();
			this.scaleX = .75;			this.scaleY = .75;
			var b:Sprite = bg.clone().image;
			b.x = -400; 
			addChild(b);
			addChild(content);
			var l:Sprite = logo.clone().image;
			l.x = 80;
			l.y = 50;
			addChild(l);	
		}

		public function print(selectedIndexes:Array):void{
			layout(selectedIndexes);
			sendToPrint();
		}
		
		private function layout(selected:Array):void{
			while(content.numChildren){
				content.removeChildAt(0);
			}
			
			var bed:Sprite = new Sprite();
			bed.x = 100;
			addChild(bed);
			var index:uint;
			var sample:SampleDTO;
			var id:String = "Product code: ";
			for(var i:uint = 0; i<selected.length; i++){
				index = selected[i];
				sample = categories[i].samples[index];

				id += sample.productCode;
				bed.addChild(sample.image.clone().image);
				content.addChild(createSample(categories[i].name, sample.name, sample.thumbLarge.clone().image, (i/4 >= 1) ? 100 : 500, (i%4)*80 + 650));
			}
			
			var productCode:TextField = new TextField();
			productCode.defaultTextFormat = new TextFormat(null, 20, 0x4f4b45, true);
			productCode.text = id;
			productCode.y = 600;
			productCode.x = 460;
			productCode.width = 400;
			productCode.height = 25;
			content.addChild(productCode);
		}
		
		private function createSample(category:String, sample:String, image:Sprite, x:Number = 0, y:Number = 0):Sprite{
			var ph:Sprite = new Sprite();
			ph.x = x;
			ph.y = y;
			
			var title:TextField = new TextField();
			title.defaultTextFormat = new TextFormat(null, 20, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			title.text = category;
			title.y = 20;
			title.width = 180;
			title.height = 25;
			ph.addChild(title);
			
			var name:TextField = new TextField();
			name.defaultTextFormat = new TextFormat(null, 14, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			name.text = sample;
			name.y = 50;
			name.width = 180;
			name.height = 25;
			ph.addChild(name);
			
			image.x = 200;
			ph.addChild(image);
			return ph;
		}
		
		private function sendToPrint():void{
			var pj:PrintJob = new PrintJob();
			if(pj.start()){
				var ready:Boolean = true;
				try{
					//
					pj.addPage(this, new Rectangle(100, 0, 1000, 1500), new PrintJobOptions(true));
				}catch(e:Error){
					ready = false;
					//TODO: handle error
				}
				if(ready) pj.send();
			}else{
				//TODO: handle error
			}
		}
	}
}
