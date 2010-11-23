package asaxb.objects
{
    [XmlRootNode(name="empty-element-list-test")]
    public class EmptyElementListTestObject
    {

        public static var xml:XML = <empty-element-list-test>
            <empty-item-list/>
        </empty-element-list-test>;

        private var _elementList:Array = new Array();

        [XmlElementWrapper(name="empty-item-list")]
        [XmlElements(name="item", type="asaxb.test.Item")]
        public function set elementList(value:Array):void
        {
            _elementList = value;
        }

        public function get elementList():Array
        {
            return _elementList;
        }
    }
}
