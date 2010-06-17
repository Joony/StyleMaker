package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.CategoryDTO;
	import ch.forea.stylemaker.dto.SampleDTO;

	import flash.display.Sprite;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;

	/**
	 * @author alyoka
	 */
	public class Print extends Sprite{
		
		private var categories:Vector.<CategoryDTO>;
		
		public function Print(categories:Vector.<CategoryDTO>){
			this.categories = categories;	
		}

		public function print(selectedIndexes:Array):void{
			layout(selectedIndexes);
			sendToPrint();
		}
		
		private function layout(selected:Array):void{
			while(this.numChildren){
				this.removeChildAt(0);
			}
			
			var index:uint;
			var sample:SampleDTO;
			for(var i:uint = 0; i<selected.length; i++){
				index = selected[i];
				sample = categories[i].samples[index];
				
				
			}
		}
		
		private function sendToPrint():void{
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
