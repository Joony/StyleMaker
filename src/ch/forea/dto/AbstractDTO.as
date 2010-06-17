package ch.forea.dto {
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class AbstractDTO implements IClonable{
		private static const PATTERN : RegExp = /(.*)\:/;
		
		public function toString() : String {
			var objectString : String = getQualifiedClassName(this) + "(";
			var variables : XMLList = describeType(this)..variable;
			var variablesString : Array = new Array();
			for each (var child:XML in variables) {
				variablesString.push(child.@name + " = " + (child.@type == "Object" ? formatObject(this[child.@name]) : this[child.@name]));
			}
			
			var accessors:XMLList = describeType(this)..accessor;
			for each (child in accessors){
				if(child.@access.toString() != "writeonly"){
               		variablesString.push(child.@name + " = " + (child.@type == "Object" ? formatObject(this[child.@name]) : this[child.@name]));
				}
			}
            objectString += variablesString.join(", ");
            return objectString + ")";  
		}
		
		private function formatObject(object:Object):String{
			var varString:Array = new Array();
			for(var i:String in object){
				varString.push(i + ":" + object[i]);
			}
			return "{" + varString.join(", ") + "}";
		}
		
		/**
		 * Returns the class name for the DTO.
		 */
		public function getClassName() : String {
			return getQualifiedClassName(this).replace(PATTERN, "");
		}
		
		public function clone():*{
			var c:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
			var dto:AbstractDTO = new c();
			var variables : XMLList = describeType(this)..variable;
			for each (var child:XML in variables) {
				cloneChild(child.@type, child.@name, dto);			}
			var accessors:XMLList = describeType(this)..accessor;
			for each (child in accessors){
				if(child.@access.toString() == "readwrite"){
					cloneChild(child.@type, child.@name, dto);
				}
			}
			return dto;
		}
		
		private function cloneChild(type:String, name:String, dto:*):void{
			var array:RegExp = /^Array$/;
			var vector:RegExp = /^__AS3__.vec::Vector.</;
			var element:*;
			
			if(array.test(type)){
				var arr:Array = [];
				for each(element in this[name]){
					arr.push(element is IClonable ? element.clone() : element);
				}
				dto[name] = arr;
			}else if(vector.test(type)){
				var v:* = new (getDefinitionByName(type) as Class)();
				for each(element in this[name]){
					v.push(element is IClonable ? element.clone() : element);
				}
				dto[name] = v;
			}else{
			 	dto[name] = this[name] is IClonable ? this[name].clone() : this[name];
			}
		}
	}
}
