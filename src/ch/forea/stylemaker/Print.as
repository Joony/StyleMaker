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
			scaleX = .7;			scaleY = .7;
			var b:Sprite = bg.clone().image;
			b.x = -360;
			b.y = -30;
			b.scaleX = b.scaleY = .67;
			addChild(b);
			addChild(content);
			var l:Sprite = logo.clone().image;
			l.x = logo.x;
			l.y = logo.y;
			l.scaleX = l.scaleY = .4;
			addChild(l);	
		}

		public function print(selectedIndexes:Array):void{
			layout(selectedIndexes);
			
//			var bmpd:BitmapData = new BitmapData(1000, 1500);
//			bmpd.draw(this);
//			var flat:Sprite = new Sprite();
//			flat.graphics.beginBitmapFill(bmpd);
//			flat.graphics.drawRect(0, 0, 1000, 1500);
//			flat.graphics.endFill();
//			
//			while(this.numChildren){
//				this.removeChildAt(0);
//			}
//			this.addChild(flat);
			
			sendToPrint();
		}
		
		private function layout(selected:Array):void{
			while(content.numChildren){
				content.removeChildAt(0);
			}
			
			var bed:Sprite = new Sprite();
			bed.x = 50;
			bed.y = 130;
			bed.scaleX = .67;
			bed.scaleY = .67;
			content.addChild(bed);
			
			var index:uint;
			var sample:SampleDTO;
			var id:String = "Product code: ";
			for(var i:uint = 0; i<selected.length; i++){
				index = selected[i];
				sample = categories[i].samples[index];

				id += sample.productCode;
				bed.addChild(sample.image.image);
				content.addChild(createSample(categories[i].name, sample.name, sample.thumbLarge.image, (i/4 >= 1) ? 500 : 100, (i%4)*80 + 640));
			}
			
			var productCode:TextField = new TextField();
			productCode.defaultTextFormat = new TextFormat(null, 21, 0x4f4b45, true);
			productCode.text = id;
			productCode.y = 900;
			productCode.x = 520;
			productCode.width = 400;
			productCode.height = 50;
			productCode.scaleX = productCode.scaleY = .8;
			content.addChild(productCode);
			
			var footer:TextField = new TextField();
			footer.defaultTextFormat = new TextFormat(null, 21, 0x4f4b45, true);
			footer.text = "Thank you for creating your perfect style.  Please visit www.serta.com.au for a list of our stockists.";
			footer.y = 1100;
			footer.x = 95;
			footer.width = 900;
			footer.height = 50;
			footer.scaleX = footer.scaleY = .80;
			content.addChild(footer);
		}
		
		private function createSample(category:String, sample:String, image:Sprite, x:Number = 0, y:Number = 0):Sprite{
			var ph:Sprite = new Sprite();
			ph.x = x;
			ph.y = y;
			
			var title:TextField = new TextField();
			title.defaultTextFormat = new TextFormat(null, 30, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			title.text = category;
			title.y = 20;
			title.width = 260;
			title.height = 50;
			ph.addChild(title);
			title.scaleX = title.scaleY = .67;
			
			var name:TextField = new TextField();
			name.defaultTextFormat = new TextFormat(null, 21, 0x4f4b45, true, null, null, null, null, TextFormatAlign.RIGHT);
			name.text = sample;
			name.y = 50;
			name.width = 260;
			name.height = 50;
			ph.addChild(name);
			name.scaleX = name.scaleY = .67;
			
			image.x = 200;
			image.scaleX = image.scaleY = .67;
			ph.addChild(image);
			return ph;
		}
		
		private function sendToPrint():void{
			var pj:PrintJob = new PrintJob();
			if(pj.start()){
				var ready:Boolean = true;
				try{
					pj.addPage(this, new Rectangle(50, 0, 1000, 1500), new PrintJobOptions(true));
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
