/* soapClient.c
   Generated by gSOAP 2.8.7 from Confirmacion_camara.h

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

SOAP_SOURCE_STAMP("@(#) soapClient.c ver 2.8.7 2014-06-21 23:14:17 GMT")


SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__wmImed_USCORESrvConfirmacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, struct _ns1__wmImed_USCORESrvConfirmacion *ns1__wmImed_USCORESrvConfirmacion, struct _ns1__wmImed_USCORESrvConfirmacionResponse *ns1__wmImed_USCORESrvConfirmacionResponse)
{	struct __ns1__wmImed_USCORESrvConfirmacion soap_tmp___ns1__wmImed_USCORESrvConfirmacion;
	if (!soap_endpoint)
		soap_endpoint = "http://10.150.73.12/I-med/wsConfirmacion.asmx";
	if (!soap_action)
		soap_action = "http://tempuri.org/wmImed_SrvConfirmacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__wmImed_USCORESrvConfirmacion.ns1__wmImed_USCORESrvConfirmacion = ns1__wmImed_USCORESrvConfirmacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__wmImed_USCORESrvConfirmacion(soap, &soap_tmp___ns1__wmImed_USCORESrvConfirmacion);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__wmImed_USCORESrvConfirmacion(soap, &soap_tmp___ns1__wmImed_USCORESrvConfirmacion, "-ns1:wmImed_SrvConfirmacion", NULL)
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
	 || soap_put___ns1__wmImed_USCORESrvConfirmacion(soap, &soap_tmp___ns1__wmImed_USCORESrvConfirmacion, "-ns1:wmImed_SrvConfirmacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__wmImed_USCORESrvConfirmacionResponse)
		return soap_closesock(soap);
	soap_default__ns1__wmImed_USCORESrvConfirmacionResponse(soap, ns1__wmImed_USCORESrvConfirmacionResponse);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	soap_get__ns1__wmImed_USCORESrvConfirmacionResponse(soap, ns1__wmImed_USCORESrvConfirmacionResponse, "ns1:wmImed_SrvConfirmacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
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
