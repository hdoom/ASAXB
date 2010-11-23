package asaxb.xml.marshalling
{
    import asaxb.objects.EmptyElementListTestObject;
    import asaxb.xml.bind.ASAXBContext;
    import asaxb.xml.bind.Marshaller;

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class EmptyElementListTest
    {

        [Test]
        public function testMarshallNullElementList():void
        {
            var result:XML = marshal(EmptyElementListTestObject);
            assertThat(result, equalTo(EmptyElementListTestObject.xml));
        }

        private function marshal(klass:Class):XML
        {
            var context:ASAXBContext = ASAXBContext.newInstance(klass);
            var marshaller:Marshaller = context.createMarshaller();
            return marshaller.marshal(new klass());
        }
    }
}
