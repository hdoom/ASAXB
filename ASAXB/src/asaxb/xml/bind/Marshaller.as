package asaxb.xml.bind
{
	
	import asaxb.xml.helpers.MarshalData;
	import asaxb.xml.helpers.XMLData;
	
    import com.dsk23.util.asaxb.adapter.ByteArrayAdapter;

    import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLNodeType;

	public class Marshaller
	{
		
		private var _marshalData:MarshalData;

		public function Marshaller(marshalData:MarshalData)
		{
			_marshalData = marshalData; 
		}
				
		public function marshal(object:*):XML
		{
            if (!object)
                return null;

			var name:String;
			var element:XMLData;
			var parentNode:XML;
			var marshalledValue:*;

			var root:XML = <{_marshalData.rootNodeName}/>;
			
			for each (var attribute:XMLData in _marshalData.attributes)
			{
				marshalledValue = getElementValueFromXML(attribute,object);
				if (marshalledValue==null)
				{
					root.@[attribute.name] = "";
				}
				else
				{
					root.@[attribute.name] = marshalledValue;
				}
			}

			for each (element in _marshalData.elements)
			{
				parentNode = getParentNodeForElement(root,element);
				marshalledValue = getElementValueFromXML(element,object);
                if (marshalledValue == null)
                {
                     // don't add element if it is null
                    continue;
                }
				else if (marshalledValue is XML)
				{
					if(element.name != null) 
					{
						(marshalledValue as XML).setName(element.name);
					}
					parentNode.appendChild(marshalledValue);
				}
				else
				{
					
					var elementNode:XML = new XML();//<{element.name}></{element.name}>;
					var elementValueType:uint = XMLNodeType.TEXT_NODE;
					var nsDef:String = getNameSpaceDef(element.name);
					if (marshalledValue==null)
					{
						elementNode = <{element.name + nsDef}></{element.name}>;						
					}
					else if (element.isCDATA)
					{
						elementNode = CDATA(element.name,marshalledValue, nsDef);
					}
					else
					{
						elementNode = <{element.name + nsDef}>{marshalledValue}</{element.name}>;
					}
					parentNode.appendChild(elementNode);
				}
			}
			
			for each (element in _marshalData.elementsLists)
			{
				parentNode = getParentNodeForElement(root,element);
				var elements:Array = object[element.accessorName];
				for each (var innerElement:* in elements)
				{
					var innerClass:Class = Class(getDefinitionByName(getQualifiedClassName(innerElement)));
					var context:ASAXBContext = ASAXBContext.newInstance(innerClass,_marshalData.applicationDomain);
					var marshaller:Marshaller = context.createMarshaller();
					var elementXML:XML = marshaller.marshal(innerElement);
					parentNode.appendChild(elementXML);
				}
			}			

			return root;
		}
		
		
		private function getNameSpaceDef(elementName:String):String
		{
			var nsDef: String = '';
			if (elementName.indexOf(':')>0)
			{
				nsDef = ' xmlns:'+elementName.split(':')[0]+'="nsVal"';
			}
			return nsDef;
		}
		
		
		
	    public function CDATA(outer: String, inner: String, nsDef:String):XML
    	{
        	return <{outer+nsDef}>{new XML("<![CDATA["+inner+"]]>")}</{outer}>;
    	}
		
		private function getParentNodeForElement(root:XML,element:XMLData):XML
		{
			var parentNode:XML = root;
			if (element.wrapperNodeName)
			{
				parentNode = <{element.wrapperNodeName}/>;
				root.appendChild(parentNode);
			}
			return parentNode;
		}
		
		private function getElementValueFromXML(element:XMLData, object:*):*
		{
            if (!object)
                return null;

            decorateDefaultAdapter(element);

			var result:*;
			switch (element.type)
			{

				case Boolean:				
				case uint:
				case int:
				case String:					
				case Number:
				case Date:
                case ByteArray:
					result = object[element.accessorName];
					break;
					
				default:
					var innerClass:Class = Class(getDefinition(getQualifiedClassName(element.type)));
					var context:ASAXBContext = ASAXBContext.newInstance(innerClass,_marshalData.applicationDomain);
					var marshaller:Marshaller = context.createMarshaller();
					result = marshaller.marshal(object[element.accessorName]);
					break;
			}
			if (element.adapter)
			{
				result = element.adapter.marshal(result);
			}
			return result;
		}

        /**
         * decorate a default adapter implementation for complex types if no adapter has been specified
         * @param element
         */
        private function decorateDefaultAdapter(element:XMLData):void
        {
            if (!element.adapter) {
                switch (element.type) {
                    case ByteArray:
                        element.adapter = new ByteArrayAdapter();
                        break;
                }
            }
        }

		private function getDefinition(className:String):Class
		{
			var klass:Class;
			if (_marshalData.applicationDomain==null)
			{
				klass = getDefinitionByName(className) as Class;
			}
			else
			{
				klass = _marshalData.applicationDomain.getDefinition(className) as Class;				
			}
			return klass;
		}

	}

}