DROP TABLE requerimientos_cia cascade;

CREATE TABLE requerimientos_cia (
    fecha timestamp without time zone,
    nemo character varying,
    codigo character varying,
    tx character varying,
    data character varying
);

CREATE INDEX requerimientos_cia_01 ON requerimientos_cia USING btree (nemo, tx);

--
-- Data for Name: requerimientos_cia; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO requerimientos_cia VALUES ('2014-06-21 10:27:07.865714', 'metlife', '12', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:07:49.360159', 'metlife_cert', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:07:49.445453', 'bice', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'metlife', '12', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:11:06.980321', 'imed', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'metlife_cert', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:14:17.404801', 'camara', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:07:45.901634', 'inter', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:14:17.582022', 'sermecoop', '1', 'Confirmacion', '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://10.0.0.114/~imed/nusoap/Sermecoop">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:wmImed_SrvConfirmacion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <XML_INPUT xsi:type="ser:wmImed_SrvConfirmacion">
            &-&DATA&-&
         </XML_INPUT>
      </ser:wmImed_SrvConfirmacion>
   </soapenv:Body>
</soapenv:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:14.56322', 'metlife', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'bice', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'imed', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'camara', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'inter', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'sermecoop', '1', 'ConfirmacionBono3', '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://10.0.0.114/~imed/nusoap/Sermecoop">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:wmImed_SrvConfirmacion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <XML_INPUT xsi:type="ser:wmImed_SrvConfirmacion">
            &-&DATA&-&
         </XML_INPUT>
      </ser:wmImed_SrvConfirmacion>
   </soapenv:Body>
</soapenv:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'mpro', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'euroamerica', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/WsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/WsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'chicon', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'integrafar', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-23 22:31:19.823554', 'mpro', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'trasa', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'far2', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'mprobci', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'metlife_mpro', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'consorcio', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:51:49.362422', 'defecto', '999', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:11:01.706135', 'euroamerica', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/WsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/WsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:14:17.129016', 'chicon', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:15:21.417502', 'integrafar', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:15:21.569507', 'trasa', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-21 19:16:25.028286', 'far2', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-23 22:31:14.979854', 'mprobci', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-23 22:31:19.727518', 'metlife_mpro', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 12:52:23.359713', 'consorcio', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 13:08:51.476425', 'defecto', '999', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:09.170555', 'bice', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:09.499065', 'camara', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'metlife', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'metlife_cert', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'bice', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'camara', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'chicon', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:15.974013', 'imed', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'consorcio', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'euroamerica', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/WsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/WsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:16.841106', 'metlife', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:17.15714', 'metlife_cert', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'far2', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'imed', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'ing', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'integrafar', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'inter', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'metlife_mpro', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'mpro', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'mprobci', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'sermecoop', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://10.0.0.114/~imed/nusoap/Sermecoop">
 <SOAP-ENV:Body SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  <ns1:wmImed_SrvAnulacion>
   <XML_INPUT>
    <XML_INPUT>&-&DATA&-&</XML_INPUT>
   </XML_INPUT>
  </ns1:wmImed_SrvAnulacion>
 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:09.977271', 'chicon', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/CertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/CertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:10.182235', 'consorcio', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsCertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsCertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:10.478477', 'euroamerica', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/WsCertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/WsCertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'trasa', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:13:21.753124', 'sermecoop', '1', 'Certificacion', '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://10.0.0.114/~imed/nusoap/Sermecoop">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:wmImed_SrvCertificacion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <XML_INPUT xsi:type="ser:wmImed_SrvCertificacion">
            &-&DATA&-&
         </XML_INPUT>
      </ser:wmImed_SrvCertificacion>
   </soapenv:Body>
</soapenv:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:17.864569', 'metlife_cert', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-08-22 10:52:01.394545', 'defecto', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:10.698812', 'far2', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/CertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/CertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'cbvida', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://Seguros.CruzBlanca.cl/WsIntegracionLGM/">
 <SOAP-ENV:Body>
   <ns1:Confirmacion>
    &-&DATA&-&
   </ns1:Confirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:16.401051', 'integrafar', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/certificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/certificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:16.582856', 'inter', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsCertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsCertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:17.845973', 'metlife_mpro', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsCertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsCertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:18.084996', 'mpro', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsCertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsCertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:12:18.417525', 'mprobci', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsCertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsCertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:13:21.963318', 'trasa', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsCertificacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsCertificacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:16:08.705592', 'defecto', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvCertificacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvCertificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-24 15:16:08.705592', 'defecto', '1', 'BonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvInfBonPago>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvInfBonPago>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:02.07165', 'bice', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:02.203034', 'camara', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:04.170905', 'chicon', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:13.241998', 'camara', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:13.707839', 'chicon', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:13.880436', 'consorcio', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:14.005888', 'euroamerica', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/WsConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/WsConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:14.420498', 'far2', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:19.723185', 'imed', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:19.814988', 'ing', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:20.234365', 'integrafar', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:20.371087', 'inter', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:23.877038', 'metlife', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:27.286435', 'metlife_cert', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:27.907973', 'metlife_mpro', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:28.003435', 'mpro', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:03:28.099408', 'mprobci', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:04:31.389323', 'sermecoop', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://10.0.0.114/~imed/nusoap/Sermecoop">
 <SOAP-ENV:Body SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  <ns1:wmImed_SrvConciliacion>
   <XML_INPUT>
    <XML_INPUT>&-&DATA&-&</XML_INPUT>
   </XML_INPUT>
  </ns1:wmImed_SrvConciliacion>
 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:04:31.469909', 'trasa', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConciliacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConciliacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:04.273047', 'consorcio', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:04.836925', 'euroamerica', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/WsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/WsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:05.156987', 'far2', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:10.432746', 'imed', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:10.524943', 'ing', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:11.169708', 'integrafar', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:11.277105', 'inter', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:17.967418', 'metlife_mpro', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:18.057626', 'mpro', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:07:18.146083', 'mprobci', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:08:21.393197', 'sermecoop', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://10.0.0.114/~imed/nusoap/Sermecoop">
 <SOAP-ENV:Body SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  <ns1:wmImed_SrvAnulacion>
   <XML_INPUT>
    <XML_INPUT>&-&DATA&-&</XML_INPUT>
   </XML_INPUT>
  </ns1:wmImed_SrvAnulacion>
 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'metlife', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:08:21.46962', 'trasa', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:21:23.548532', 'defecto', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2014-06-30 12:21:42.249078', 'defecto', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConciliacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-30 17:24:47.476374', 'cbvida', '1', 'Certificacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://Seguros.CruzBlanca.cl/WsIntegracionLGM/">
 <SOAP-ENV:Body>
   <ns1:Certificacion>
    &-&DATA&-&
   </ns1:Certificacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-30 17:24:47.478085', 'cbvida', '1', 'Confirmacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://Seguros.CruzBlanca.cl/WsIntegracionLGM/">
 <SOAP-ENV:Body>
   <ns1:Confirmacion>
    &-&DATA&-&
   </ns1:Confirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-30 17:24:47.479258', 'cbvida', '1', 'ConfirmacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://Seguros.CruzBlanca.cl/WsIntegracionLGM/">
 <SOAP-ENV:Body>
   <ns1:Confirmacion>
    &-&DATA&-&
   </ns1:Confirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-30 17:24:47.480248', 'cbvida', '1', 'Anulacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://Seguros.CruzBlanca.cl/WsIntegracionLGM/">
 <SOAP-ENV:Body>
   <ns1:Anulacion>
    &-&DATA&-&
   </ns1:Anulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-30 17:24:47.481208', 'cbvida', '1', 'AnulacionBono3', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://Seguros.CruzBlanca.cl/WsIntegracionLGM/">
 <SOAP-ENV:Body>
   <ns1:Anulacion>
    &-&DATA&-&
   </ns1:Anulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-30 17:24:47.481799', 'cbvida', '1', 'Conciliacion', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://Seguros.CruzBlanca.cl/WsIntegracionLGM/">
 <SOAP-ENV:Body>
   <ns1:Conciliacion>
    &-&DATA&-&
   </ns1:Conciliacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'metlife', '12', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'metlife_cert', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'bice', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'imed', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'camara', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'metlife_cert', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'inter', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'sermecoop', '1', 'ConfirmacionBonoExt', '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://10.0.0.114/~imed/nusoap/Sermecoop">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:wmImed_SrvConfirmacion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <XML_INPUT xsi:type="ser:wmImed_SrvConfirmacion">
            &-&DATA&-&
         </XML_INPUT>
      </ser:wmImed_SrvConfirmacion>
   </soapenv:Body>
</soapenv:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'mpro', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'euroamerica', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/WsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/WsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'chicon', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'integrafar', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'trasa', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'far2', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/ConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/ConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'mprobci', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'metlife_mpro', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'consorcio', '1', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsConfirmacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsConfirmacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:38:02.274296', 'defecto', '999', 'ConfirmacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvConfirmacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvConfirmacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'bice', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'camara', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'chicon', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'consorcio', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'euroamerica', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/WsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/WsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'far2', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'imed', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'ing', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'integrafar', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/AnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/AnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'inter', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'metlife_mpro', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'mpro', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'mprobci', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'sermecoop', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://10.0.0.114/~imed/nusoap/Sermecoop">
 <SOAP-ENV:Body SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  <ns1:wmImed_SrvAnulacion>
   <XML_INPUT>
    <XML_INPUT>&-&DATA&-&</XML_INPUT>
   </XML_INPUT>
  </ns1:wmImed_SrvAnulacion>
 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'trasa', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"
 xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns2="http://tempuri.org/wsAnulacionSoap"
 xmlns:ns1="http://tempuri.org/"
 xmlns:ns3="http://tempuri.org/wsAnulacionSoap12">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'defecto', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://tempuri.org/">
 <SOAP-ENV:Body>
   <ns1:wmImed_SrvAnulacion>
    <ns1:XML_INPUT>&-&DATA&-&</ns1:XML_INPUT>
   </ns1:wmImed_SrvAnulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');
INSERT INTO requerimientos_cia VALUES ('2015-07-31 11:45:24.261961', 'cbvida', '1', 'AnulacionBonoExt', '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:ns1="http://Seguros.CruzBlanca.cl/WsIntegracionLGM/">
 <SOAP-ENV:Body>
   <ns1:Anulacion>
    &-&DATA&-&
   </ns1:Anulacion>

 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>');


