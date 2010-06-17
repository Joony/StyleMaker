package ch.forea.parsing {
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * @author alyoka
	 */
	public class XMLParser {
		public function parse(xml:XMLList, responseType:String):* {
			//1. instantiate response class
			var dto : *;
			try{
				var responseClass:Class = getDefinitionByName(responseType) as Class;
			}catch(e:Error){
				throw new Error("XMLParser.request: couldn't instantiate "+responseType);	
			}
			dto = new responseClass();

			//2. fill out public vars and accessors of the new instance with data from xml
			//2.1. create a dictionary (dict[name]=type) based on the response class's public variables and accessors
			var dtoDescription:XML = describeType(dto);
			var variables:XMLList = dtoDescription..variable;
			var accessors:XMLList = dtoDescription..accessor;
			var dtoprops:Dictionary = new Dictionary();
			var child:XML;
            for each (child in variables){
                dtoprops[child.@name.toString()] = child.@type.toString();
			}
			for each (child in accessors){
			 	if(child.@access.toString() == "readwrite"){
	                dtoprops[child.@name.toString()] = child.@type.toString();
			 	}
			}
			
			//2.2. for each of the public vars/accessors find an XML tag with the same name,
			//     parse tag's value and assign it to the the response dto's variable/accessor 
			var value:XMLList;
			var type:String;
			for(var propertyName:String in dtoprops){
				value = xml[propertyName];
				delete xml[propertyName];
				if(!value.length()) {
					if(xml.attribute(propertyName).toString() != ""){
						value = xml.attribute(propertyName);
						delete xml.@[propertyName];
					}
				}
				type = dtoprops[propertyName];
				if(value && value.toXMLString() != "") {
					try{
						dto[propertyName] = parseSingleObject(XMLList(value), type);
					}catch(e:Error){
						throw new Error("XMLParser.parseXMLResponse() failed, e: "+e);
					}
				}
			}
			
			//2. if response class is dynamic, add extra properties from xml as dynamic properties
			//NOTE: parses ONLY through attributes and interprets them as Strings!!!
			if(dtoDescription.@isDynamic.toString() == "true") {
				var attName:String;
				for each(var node:XML in xml.attributes()){
					if(node.toString() != ""){
						attName = node.name().toString().replace("@","");
						dto[attName] = node.toString();
					}
				}
			}
			
			return dto;
		}
		
		private function parseSingleObject(value:XMLList, type:String) : * {
			var primitiveTypes : RegExp = /^Boolean$|^int$|^Number$|^String$|^uint$/;
			var array:RegExp = /^Array$/;
			var vector:RegExp = /^__AS3__.vec::Vector.</;
			
			var intCheck:RegExp = /^-{0,1}\d+$/;
			var uintCheck:RegExp = /^\d+$/;
			var numberCheck:RegExp = /^-{0,1}\d*\.{0,1}\d+$/;
			var booleanCheck:RegExp = /^1|0|true|false$/i;
			
			var vectorToClassName:RegExp = /(__AS3__.vec::Vector.<)([A-Za-z0-9.]*)(?:::)*([A-Za-z0-9]*)(>)/g;
			var elements:XMLList;
			var child:*;
			
			//PRIMITIVES
			if(primitiveTypes.test(type)) {

				//just fill out
				switch(type){
					case "int":
						if(!intCheck.test(value)) throw new Error("XMLParser.parseSingleObject property type value:" + value + " should be of type '" + type + "'. Correct xml");
						return new int(parseInt(value.toString()));
					break;
					case "uint":
						if(!uintCheck.test(value)) throw new Error("XMLParser.parseSingleObject property type value:"+value+" should be of type '"+type+"'. Correct xml");
						return new uint(parseInt(value.toString()));
					break;
					case "Number":
						if(!numberCheck.test(value)) throw new Error("XMLParser.parseSingleObject property type value:"+value+" should be of type '"+type+"'. Correct xml");
						return Number(value.toString());
					break;
					case "String":
						return value.toString();
					break;
					case "Boolean":
						if(!booleanCheck.test(value)) throw new Error("XMLParser.parseSingleObject property type value:"+value+" should be of type '"+type+"'. Correct xml");
						return (value.toString() == "true" || value.toString() == "1");
					break;
				}
			
			//ARRAYS
			}else if(array.test(type)){
				var a:Array = [];
				if((value as XMLList).hasComplexContent()){
					//parse through elements and fill them with xml values
					elements = value.children();
					for each(child in elements){
						a.push(child);
					}
				}else{
					//assume value is a comma delimited string - split it and fill out array
					a = value.toString().split(",");
				}
				return a;
				
			//VECTORS
			}else if(vector.test(type)){
				//instantiate vector and parse each of its members
				var c:Class;
				var v:*;
				
				try{
					c = getDefinitionByName(type) as Class;
				}catch(e:Error){
					throw new Error("XMLParser.parseSingleObject, class could not be instantiated: "+type+", error: " + e.message);
				}
				v = new c();
				
				var valueType:String = type.replace(/(__AS3__.vec::Vector.<)([A-Za-z0-9.:]*)(>)/, "$2");
				if(value.hasComplexContent()){
					elements = value.children();
					for each(child in elements){
						v.push(parseSingleObject(XMLList(child), valueType));
					}
					return v.length ? v : null;
				} else{
					//assume value is a comma delimited string - split it and fill out array
					var values:Array;
					if(value.toString() != ""){
						values =  value.toString().split(","); 
					}
					for each(var val:String in values) {
						v.push(parseSingleObject(XMLList("<primitive>"+val+"</primitive>"), valueType));
					} 
					return v.length ? v : null;
				}
				
			//CUSTOM OBJECTS
			}else{
				return parse(XMLList(value), type);
			}
		}
	}	
}
