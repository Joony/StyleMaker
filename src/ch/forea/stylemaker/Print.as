package ch.forea.stylemaker {
	import flash.printing.PrintJobOptions;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.printing.PrintJob;

	/**
	 * @author alyoka
	 */
	public class Print extends Sprite{
		
		[Embed(source="../../../../img/logo.png")]
		private var Logo:Class;
		
//		public function print(image:Bitmap, options:Dictionary, selectedIds:Array):void{
		public function print(s:DisplayObject):void{
			graphics.beginFill(0xff);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
			
			addChild(s);
			addChild(new Logo());
			
			var pj:PrintJob = new PrintJob();
			if(pj.start()){
				var ready:Boolean = true;
				try{
					pj.addPage(this, null, new PrintJobOptions(true));
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
