package com.dsk23.util.asaxb.adapter {

    import asaxb.xml.adapter.XMLAdapter;

    import com.hurlant.util.Base64;

    /**
     * <code>XMLAdapter</code> using Base64 encoding to marshal/unmarshal <code>ByteArray</code>s.
     */
    public class ByteArrayAdapter implements XMLAdapter {

        public function marshal(value:*):* {
            return Base64.encodeByteArray(value);
        }

        public function unmarshal(value:*):* {
            return Base64.decodeToByteArray(value);
        }
    }
}
