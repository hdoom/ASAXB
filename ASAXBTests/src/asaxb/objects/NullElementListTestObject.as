package asaxb.objects
{
    [XmlRootNode(name="null-element-list-test")]
    public class NullElementListTestObject
    {

        public static var xml:XML = <null-element-list-test>
            <item-list-wrapper/>
        </null-element-list-test>;

        private var _listElements:Array;

        [XmlElementWrapper(name="item-list-wrapper")]
        [XmlElements(name="item",type="asaxb.test.Item")]
        public function set listElements(value:Array):void
        {
            _listElements = value;
        }

        public function get listElements():Array
        {
            return _listElements;
        }

    }
}
