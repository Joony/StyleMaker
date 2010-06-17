package ch.forea.parsing {
  import flash.utils.Dictionary;
  import flash.utils.describeType;
  import flash.utils.getQualifiedClassName;

  /**
   * @author alyoka
   */
  public class XMLCreator {
    private var primitiveTypes : RegExp = /^Boolean$|^int$|^Number$|^String$|^uint$/;
    
    public function parse(dto:*, name:String = null):XML {
      var dtoName:String = name ? name : getQualifiedClassName(dto).replace(/(.*)\:/,"");
      var xml:XML = new XML("<"+dtoName+"/>");

      //1. list dto's public variables and accessors in a dictionary (dict[name]=type)
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
      
      //2. for each of the public vars/accessors create an XML node with the same name and parse the value 
      var type:String;      for(var propertyName:String in dtoprops){
        type = dtoprops[propertyName];
        //if value is a primitive type, assign it to an attribute to save space
        if(primitiveTypes.test(type)){
          xml.@[propertyName] = dto[propertyName].toString();
        } else{
          xml.appendChild(parseSingleObject(dto[propertyName], propertyName, type));
        }
      }
      return xml;
    }
    
    private function parseSingleObject(value:*, name:String, type:String) : XML {
      var xml:XML = new XML("<"+name+"/>");
      
      var array:RegExp = /^Array$/;
      var vector:RegExp = /^__AS3__.vec::Vector.</;
      
      //PRIMITIVES
      if(primitiveTypes.test(type)) {
        xml.appendChild(value.toString());
      //ARRAYS
      }else if(array.test(type)){
        for each(var obj:* in value){
          xml.appendChild(parseSingleObject(obj,"element","object"));
        }
      //VECTORS
      }else if(vector.test(type)){
        var valueType:String = type.replace(/(__AS3__.vec::Vector.<)([A-Za-z0-9.:]*)(>)/, "$2");
        for each(var obj:* in value){
          xml.appendChild(parseSingleObject(obj,"element",valueType));
        }        
      //CUSTOM OBJECTS
      }else{
        return parse(value, name);
      }
      return xml;
    }
  }  
}
