package asaxb.objects
{

	[XmlRootNode(name="null-element-test")]
	public class NullElementTestObject
	{
		
		public static const expectedXML:XML = <null-element-test/>;
		
		private var _nullElement:String;
				
		[XmlElement(name="null-element")]
		public function get nullElement():String
		{
			return _nullElement;
		}		

		public function set nullElement(value:String):void
		{
			_nullElement = value;
		}		

	}

}