package asaxb.objects
{
    import flash.utils.ByteArray;

    [XmlRootNode(name="byte-array-unmarshal-test")]
    public class ByteArrayElementUnmarshalTestObject
    {

        public static var xml:XML = <byte-array-unmarshal-test>
            <bytes>AP8Afw==</bytes>
        </byte-array-unmarshal-test>;

        private var _bytes:ByteArray;

        [XmlElement(name="bytes")]
        public function set bytes(value:ByteArray):void
        {
            _bytes = value;
        }

        public function get bytes():ByteArray
        {
            return _bytes;
        }
    }
}
