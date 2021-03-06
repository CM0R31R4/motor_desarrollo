/* soapClient.c
   Generated by gSOAP 2.8.7 from Anulacion_sermecoop.h

Copyright(C) 2000-2011, Robert van Engelen, Genivia Inc. All Rights Reserved.
The generated code is released under one of the following licenses:
1) GPL or 2) Genivia's license for commercial use.
This program is released under the GPL with the additional exemption that
compiling, linking, and/or using OpenSSL is allowed.
*/

#if defined(__BORLANDC__)
#pragma option push -w-8060
#pragma option push -w-8004
#endif
#include "soapH.h"
#ifdef __cplusplus
extern "C" {
#endif

SOAP_SOURCE_STAMP("@(#) soapClient.c ver 2.8.7 2014-06-30 16:08:21 GMT")


SOAP_FMAC5 int SOAP_FMAC6 soap_call_ns1__wmImed_USCORESrvAnulacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, struct ns1__wmImed_USCORESrvAnulacion *XML_USCOREINPUT, char **wmImed_USCORESrvAnulacionResult)
{	struct ns1__wmImed_USCORESrvAnulacion_ soap_tmp_ns1__wmImed_USCORESrvAnulacion_;
	struct ns1__wmImed_USCORESrvAnulacion_Response *soap_tmp_ns1__wmImed_USCORESrvAnulacion_Response;
	if (!soap_endpoint)
		soap_endpoint = "http://10.0.0.114/~imed/nusoap/Sermecoop/wsAnulacion.php";
	if (!soap_action)
		soap_action = "http://10.0.0.114/~imed/nusoap/Sermecoop/wsAnulacion.php/wmImed_SrvAnulacion";
	soap->encodingStyle = "http://schemas.xmlsoap.org/soap/encoding/";
	soap_tmp_ns1__wmImed_USCORESrvAnulacion_.XML_USCOREINPUT = XML_USCOREINPUT;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize_ns1__wmImed_USCORESrvAnulacion_(soap, &soap_tmp_ns1__wmImed_USCORESrvAnulacion_);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put_ns1__wmImed_USCORESrvAnulacion_(soap, &soap_tmp_ns1__wmImed_USCORESrvAnulacion_, "ns1:wmImed_SrvAnulacion", NULL)
		 || soap_body_end_out(soap)
		 || soap_envelope_end_out(soap))
			 return soap->error;
	}
	if (soap_end_count(soap))
		return soap->error;
	if (soap_connect(soap, soap_endpoint, soap_action)
	 || soap_envelope_begin_out(soap)
	 || soap_putheader(soap)
	 || soap_body_begin_out(soap)
	 || soap_put_ns1__wmImed_USCORESrvAnulacion_(soap, &soap_tmp_ns1__wmImed_USCORESrvAnulacion_, "ns1:wmImed_SrvAnulacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!wmImed_USCORESrvAnulacionResult)
		return soap_closesock(soap);
	*wmImed_USCORESrvAnulacionResult = NULL;
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	if (soap_recv_fault(soap, 1))
		return soap->error;
	soap_tmp_ns1__wmImed_USCORESrvAnulacion_Response = soap_get_ns1__wmImed_USCORESrvAnulacion_Response(soap, NULL, "", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	if (wmImed_USCORESrvAnulacionResult && soap_tmp_ns1__wmImed_USCORESrvAnulacion_Response->wmImed_USCORESrvAnulacionResult)
		*wmImed_USCORESrvAnulacionResult = *soap_tmp_ns1__wmImed_USCORESrvAnulacion_Response->wmImed_USCORESrvAnulacionResult;
	return soap_closesock(soap);
}

#ifdef __cplusplus
}
#endif

#if defined(__BORLANDC__)
#pragma option pop
#pragma option pop
#endif

/* End of soapClient.c */
