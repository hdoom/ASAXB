package asaxb.xml.marshalling
{
    import asaxb.objects.ByteArrayMarshalTestObject;
    import asaxb.xml.bind.ASAXBContext;
    import asaxb.xml.bind.Marshaller;

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class ByteArrayElementMarshalTest
    {
        [Test]
        public function testMarshallingByteArray():void
        {
            var result:XML = marshal(ByteArrayMarshalTestObject);
            assertThat(result.toXMLString(), equalTo(ByteArrayMarshalTestObject.expectedXml.toXMLString()));
        }

        private function marshal(klass:Class):XML
        {
            var context:ASAXBContext = ASAXBContext.newInstance(klass);
            var marshaller:Marshaller = context.createMarshaller();
            return marshaller.marshal(new klass());
        }
    }
}
