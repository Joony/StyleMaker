package ch.forea.stylemaker.event {
	import Boolean;
	import String;
	import ch.forea.stylemaker.dto.PreviewDTO;
	import ch.forea.stylemaker.dto.SampleDTO;

	import flash.events.Event;

	/**
	 * @author jonathanmcallister
	 */
	public class SubMenuEvent extends Event {
		
		public static const EventName:String = 'EventName';
		
		public var preview:PreviewDTO;

        /**
         * Constructor
         *
         * @param type The type of event. Event listeners can
         * access this information through the inherited type property.
         *
         * @param eventVariable A custom event variable to pass along with 
         * the event.
         *
         * @param bubbles Determines whether the Event object participates
         * in the bubbling stage of the event flow. Event listeners can
         * access this information through the inherited bubbles property.
         *
         * @param cancelable Determines whether the Event object can be
         * canceled. Event listeners can access this information through
         * the inherited cancelable property.
         */
        public function SubMenuEvent(type:String, 
                                   name:String,
                                   sample:SampleDTO, 
                                   bubbles:Boolean = true, 
                                   cancelable:Boolean = false){
            preview = new PreviewDTO();
            preview.name = name;
            preview.sample = sample;
            super(type, bubbles, cancelable);
        }

        /**
         * Creates a copy of the CustomEvent object and sets the value
         * of each property to match that of the original.
         *
         * @return A new CustomEvent object with property values that
         * match those of the original.
         */
        override public function clone():Event {
            return new SubMenuEvent(type, preview.name, preview.sample, bubbles, cancelable);
        }
		
	}
}
