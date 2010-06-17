package ch.forea.stylemaker {
	import ch.forea.stylemaker.dto.CategoryDTO;
	import ch.forea.stylemaker.dto.DataDTO;
	import ch.forea.stylemaker.dto.ImageDTO;
	import ch.forea.stylemaker.dto.SampleDTO;

	/**
	 * @author alyoka
	 */
	public class DataCreator {
		public function createData():DataDTO{
			var data:DataDTO = new DataDTO();
			data.fileSize = 1000;
			data.background = createImage("img/background.png");			data.logo = createImage("img/logo.png");			data.doorLeft = createImage("img/screen_door_left.png");			data.doorRight = createImage("img/screen_door_right.png");			data.menuLeftBg = createImage("img/option_door_left.png");			data.menuRightBg = createImage("img/option_door_right.png");			data.subMenuBg = createImage("img/pull_out_background.png");			data.printBtn = createImage("img/icon_print.png");			data.closeBtn = createImage("img/icon_close.png");			
			var d:Vector.<CategoryDTO> = new Vector.<CategoryDTO>;
			d.push(createCategory("Matress Top", [createSample("T1","t", 1, "T1"),
										createSample("T2","t", 2, "T2"),
										createSample("T3","t", 3, "T3")
										]));
			d.push(createCategory("Matress Border", [createSample("B1","b", 1, "B1"),
										createSample("B2","b", 2, "B2"),
										createSample("B3","b", 3, "B3")
										]));			d.push(createCategory("Base/Platform", [createSample("P1","p", 1, "P1"),
										createSample("P2","p", 2, "P2"),
										createSample("P3","p", 3, "P3")
										]));			d.push(createCategory("Edge Tape", [createSample("E1","e", 1, "E1"),
										createSample("E2","e", 2, "E2"),
										createSample("E3","e", 3, "E3")
										]));			d.push(createCategory("Leg", [createSample("L1","l", 1, "L1"),
										createSample("L2","l", 2, "L2")
										]));			d.push(createCategory("Headboard", [createSample("HB1","hb", 1, "HB1"),
										createSample("HB2","hb", 2, "HB2"),
										createSample("HB3","hb", 3, "HB3"),
										createSample("HB4","hb", 4, "HB4"),
										createSample("HB5","hb", 5, "HB5")
										]));			d.push(createCategory("Mattress", [createSample("F1","f", 1, "F1"),
										createSample("F2","f", 2, "F2"),
										createSample("F3","f", 3, "F3"),
										createSample("F4","f", 4, "F4"),
										createSample("F5","f", 5, "F5"),
										createSample("F6","f", 6, "F5")]));			data.categories = d;
			return data;
		}
		
		private function createImage(uri:String):ImageDTO{
			var i:ImageDTO = new ImageDTO();
			i.uri = "img/options/"+uri;
			return i;
		}
		
		private function createSample(name:String, letter:String, id:int, productCode:String):SampleDTO{
			var s:SampleDTO = new SampleDTO();
			s.name = name;
			s.thumbSmall = createImage(letter+"/"+id+"_small.png");
			s.thumbLarge = createImage(letter+"/"+id+"_large.png");			s.image = createImage(letter+"/"+id+"_image.png");
			s.productCode = productCode;
			return s;
		}
		
		private function createCategory(name:String, samples:Array):CategoryDTO{
			var c:CategoryDTO = new CategoryDTO();
			c.name = name;
			c.samples = Vector.<SampleDTO>(samples);
			return c;
		}
	}
}
