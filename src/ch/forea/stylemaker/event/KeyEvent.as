package ch.forea.stylemaker.event {
	import Boolean;
	import String;
	import flash.events.Event;

	/**
	 * @author jonathanmcallister
	 */
	public class KeyEvent extends Event {
		
		public static const INSERT:String = 'insert';		public static const DELETE:String = 'delete';
		
		public var text:String;

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
        public function KeyEvent(type:String, 
                                   text:String = null,
                                   bubbles:Boolean = true, 
                                   cancelable:Boolean = false){
            this.text = text;
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
            return new KeyEvent(type, text, bubbles, cancelable);
        }
		
	}
}
