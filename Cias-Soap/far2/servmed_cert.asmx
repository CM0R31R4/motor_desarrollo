<?xml version="1.0" encoding="utf-8"?>
<definitions xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:s0="http://tempuri.org/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" targetNamespace="http://tempuri.org/" xmlns="http://schemas.xmlsoap.org/wsdl/">
  <types>
    <s:schema elementFormDefault="qualified" targetNamespace="http://tempuri.org/">
      <s:element name="wmImed_SrvCertificacion">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="XML_INPUT" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="wmImed_SrvCertificacionResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="wmImed_SrvCertificacionResult" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="string" nillable="true" type="s:string" />
    </s:schema>
  </types>
  <message name="wmImed_SrvCertificacionSoapIn">
    <part name="parameters" element="s0:wmImed_SrvCertificacion" />
  </message>
  <message name="wmImed_SrvCertificacionSoapOut">
    <part name="parameters" element="s0:wmImed_SrvCertificacionResponse" />
  </message>
  <message name="wmImed_SrvCertificacionHttpGetIn">
    <part name="XML_INPUT" type="s:string" />
  </message>
  <message name="wmImed_SrvCertificacionHttpGetOut">
    <part name="Body" element="s0:string" />
  </message>
  <message name="wmImed_SrvCertificacionHttpPostIn">
    <part name="XML_INPUT" type="s:string" />
  </message>
  <message name="wmImed_SrvCertificacionHttpPostOut">
    <part name="Body" element="s0:string" />
  </message>
  <portType name="WsCertificacionSoap">
    <operation name="wmImed_SrvCertificacion">
      <input message="s0:wmImed_SrvCertificacionSoapIn" />
      <output message="s0:wmImed_SrvCertificacionSoapOut" />
    </operation>
  </portType>
  <portType name="WsCertificacionHttpGet">
    <operation name="wmImed_SrvCertificacion">
      <input message="s0:wmImed_SrvCertificacionHttpGetIn" />
      <output message="s0:wmImed_SrvCertificacionHttpGetOut" />
    </operation>
  </portType>
  <portType name="WsCertificacionHttpPost">
    <operation name="wmImed_SrvCertificacion">
      <input message="s0:wmImed_SrvCertificacionHttpPostIn" />
      <output message="s0:wmImed_SrvCertificacionHttpPostOut" />
    </operation>
  </portType>
  <binding name="WsCertificacionSoap" type="s0:WsCertificacionSoap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http" style="document" />
    <operation name="wmImed_SrvCertificacion">
      <soap:operation soapAction="http://tempuri.org/wmImed_SrvCertificacion" style="document" />
      <input>
        <soap:body use="literal" />
      </input>
      <output>
        <soap:body use="literal" />
      </output>
    </operation>
  </binding>
  <binding name="WsCertificacionHttpGet" type="s0:WsCertificacionHttpGet">
    <http:binding verb="GET" />
    <operation name="wmImed_SrvCertificacion">
      <http:operation location="/wmImed_SrvCertificacion" />
      <input>
        <http:urlEncoded />
      </input>
      <output>
        <mime:mimeXml part="Body" />
      </output>
    </operation>
  </binding>
  <binding name="WsCertificacionHttpPost" type="s0:WsCertificacionHttpPost">
    <http:binding verb="POST" />
    <operation name="wmImed_SrvCertificacion">
      <http:operation location="/wmImed_SrvCertificacion" />
      <input>
        <mime:content type="application/x-www-form-urlencoded" />
      </input>
      <output>
        <mime:mimeXml part="Body" />
      </output>
    </operation>
  </binding>
  <service name="WsCertificacion">
    <port name="WsCertificacionSoap" binding="s0:WsCertificacionSoap">
      <soap:address location="http://10.150.73.119/I-med/wsCertificacion.asmx" />
    </port>
    <port name="WsCertificacionHttpGet" binding="s0:WsCertificacionHttpGet">
      <http:address location="http://10.150.73.119/I-med/wsCertificacion.asmx" />
    </port>
    <port name="WsCertificacionHttpPost" binding="s0:WsCertificacionHttpPost">
      <http:address location="http://10.150.73.119/I-med/wsCertificacion.asmx" />
    </port>
  </service>
</definitions>