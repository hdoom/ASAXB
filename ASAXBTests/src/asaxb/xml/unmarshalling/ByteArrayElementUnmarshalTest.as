package asaxb.xml.unmarshalling
{
    import asaxb.objects.ByteArrayElementUnmarshalTestObject;
    import asaxb.xml.bind.ASAXBContext;
    import asaxb.xml.bind.Unmarshaller;

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.notNullValue;

    public class ByteArrayElementUnmarshalTest
    {

        [Test]
        public function testUnmarshallingByteArray():void
        {
            var object:ByteArrayElementUnmarshalTestObject = unmarshal(ByteArrayElementUnmarshalTestObject.xml);
            assertThat(object.bytes, notNullValue());
            assertThat(object.bytes[0], equalTo(0x0));
            assertThat(object.bytes[1], equalTo(0xff));
            assertThat(object.bytes[2], equalTo(0x0));
            assertThat(object.bytes[3], equalTo(0x7f));
        }

        private function unmarshal(xml:XML):ByteArrayElementUnmarshalTestObject
        {
            var context:ASAXBContext = ASAXBContext.newInstance(ByteArrayElementUnmarshalTestObject);
            var unmarshaller:Unmarshaller = context.createUnmarshaller();
            return unmarshaller.unmarshal(xml);
        }
    }
}
