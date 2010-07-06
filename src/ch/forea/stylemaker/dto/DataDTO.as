package ch.forea.stylemaker.dto {
	import ch.forea.dto.AbstractDTO;

	/**
	 * @author alyoka
	 */
	public class DataDTO extends AbstractDTO {
		public var categories:Vector.<CategoryDTO>;
		public var background:ImageDTO;
		public var logo:ImageDTO;
		public var printlogo:ImageDTO;		public var doorLeft:ImageDTO;		public var doorRight:ImageDTO;		public var menuLeftBg:ImageDTO;		public var menuRightBg:ImageDTO;		public var subMenuBg:ImageDTO;		public var printBtn:ImageDTO;		public var emailBtn:ImageDTO;		public var closeBtn:ImageDTO;		public var fileSize:uint;
		public var inactivityTimeout:uint;
		public var keyboard:Vector.<KeyboardScreenDTO>;
		
		private var _loaded:Boolean = false;
		
		public function get bytesLoaded():uint{
			var bytes:uint;
			for each(var c:CategoryDTO in categories){
				bytes += c.bytesLoaded;			}
			bytes += background.bytesLoaded;			bytes += logo.bytesLoaded;			bytes += doorLeft.bytesLoaded;			bytes += doorRight.bytesLoaded;			bytes += menuLeftBg.bytesLoaded;			bytes += menuRightBg.bytesLoaded;			bytes += subMenuBg.bytesLoaded;			bytes += printBtn.bytesLoaded;			bytes += closeBtn.bytesLoaded;
			
			return bytes;
		}
		
		public function get loaded():Boolean{
			if(!_loaded){
				_loaded = true;
				for each(var c:CategoryDTO in categories){
					if(!c.loaded) {
						_loaded = false;
						break;
					}
				}
				if(_loaded){
					_loaded = background.loaded && logo.loaded && doorLeft.loaded && doorRight.loaded && menuLeftBg.loaded && menuRightBg.loaded  && subMenuBg.loaded && printBtn.loaded && closeBtn.loaded;
				}
			}
			return _loaded;
		}
	}
}
