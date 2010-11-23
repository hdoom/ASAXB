package asaxb.objects
{
    import flash.utils.ByteArray;

    [XmlRootNode(name="byte-array-marshal-test")]
    public class ByteArrayMarshalTestObject
    {

        public static var expectedXml:XML = <byte-array-marshal-test>
            <bytes>AP8Afw==</bytes>
        </byte-array-marshal-test>;

        private var _bytes:ByteArray;

        [XmlElement(name="bytes")]
        public function set bytes(value:ByteArray):void
        {
            _bytes = value;
        }

        public function get bytes():ByteArray
        {
            var ba:ByteArray = new ByteArray();
            ba.writeByte(0x0);  // 0
            ba.writeByte(0xff); // 255
            ba.writeByte(0x0);  // 0
            ba.writeByte(0x7f); // 127
            return ba;
        }
    }
}
