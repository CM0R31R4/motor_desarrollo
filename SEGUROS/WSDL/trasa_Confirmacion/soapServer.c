/* soapServer.c
   Generated by gSOAP 2.8.7 from Confirmacion_trasa.h

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

SOAP_SOURCE_STAMP("@(#) soapServer.c ver 2.8.7 2014-06-21 23:15:21 GMT")


SOAP_FMAC5 int SOAP_FMAC6 soap_serve(struct soap *soap)
{
#ifndef WITH_FASTCGI
	unsigned int k = soap->max_keep_alive;
#endif
	do
	{
#ifndef WITH_FASTCGI
		if (soap->max_keep_alive > 0 && !--k)
			soap->keep_alive = 0;
#endif
		if (soap_begin_serve(soap))
		{	if (soap->error >= SOAP_STOP)
				continue;
			return soap->error;
		}
		if (soap_serve_request(soap) || (soap->fserveloop && soap->fserveloop(soap)))
		{
#ifdef WITH_FASTCGI
			soap_send_fault(soap);
#else
			return soap_send_fault(soap);
#endif
		}

#ifdef WITH_FASTCGI
		soap_destroy(soap);
		soap_end(soap);
	} while (1);
#else
	} while (soap->keep_alive);
#endif
	return SOAP_OK;
}

#ifndef WITH_NOSERVEREQUEST
SOAP_FMAC5 int SOAP_FMAC6 soap_serve_request(struct soap *soap)
{
	soap_peek_element(soap);
	if ((!soap->action && !soap_match_tag(soap, soap->tag, "ns1:wmImed_SrvConfirmacion")) || (soap->action && !strcmp(soap->action, "http://tempuri.org/wmImed_SrvConfirmacion")))
		return soap_serve___ns2__wmImed_USCORESrvConfirmacion(soap);
	if ((!soap->action && !soap_match_tag(soap, soap->tag, "ns1:wmImed_SrvConfirmacion")) || (soap->action && !strcmp(soap->action, "http://tempuri.org/wmImed_SrvConfirmacion")))
		return soap_serve___ns3__wmImed_USCORESrvConfirmacion(soap);
	return soap->error = SOAP_NO_METHOD;
}
#endif

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns2__wmImed_USCORESrvConfirmacion(struct soap *soap)
{	struct __ns2__wmImed_USCORESrvConfirmacion soap_tmp___ns2__wmImed_USCORESrvConfirmacion;
	struct _ns1__wmImed_USCORESrvConfirmacionResponse ns1__wmImed_USCORESrvConfirmacionResponse;
	soap_default__ns1__wmImed_USCORESrvConfirmacionResponse(soap, &ns1__wmImed_USCORESrvConfirmacionResponse);
	soap_default___ns2__wmImed_USCORESrvConfirmacion(soap, &soap_tmp___ns2__wmImed_USCORESrvConfirmacion);
	soap->encodingStyle = NULL;
	if (!soap_get___ns2__wmImed_USCORESrvConfirmacion(soap, &soap_tmp___ns2__wmImed_USCORESrvConfirmacion, "-ns2:wmImed_SrvConfirmacion", NULL))
		return soap->error;
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap->error;
	soap->error = __ns2__wmImed_USCORESrvConfirmacion(soap, soap_tmp___ns2__wmImed_USCORESrvConfirmacion.ns1__wmImed_USCORESrvConfirmacion, &ns1__wmImed_USCORESrvConfirmacionResponse);
	if (soap->error)
		return soap->error;
	soap_serializeheader(soap);
	soap_serialize__ns1__wmImed_USCORESrvConfirmacionResponse(soap, &ns1__wmImed_USCORESrvConfirmacionResponse);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put__ns1__wmImed_USCORESrvConfirmacionResponse(soap, &ns1__wmImed_USCORESrvConfirmacionResponse, "ns1:wmImed_SrvConfirmacionResponse", NULL)
		 || soap_body_end_out(soap)
		 || soap_envelope_end_out(soap))
			 return soap->error;
	};
	if (soap_end_count(soap)
	 || soap_response(soap, SOAP_OK)
	 || soap_envelope_begin_out(soap)
	 || soap_putheader(soap)
	 || soap_body_begin_out(soap)
	 || soap_put__ns1__wmImed_USCORESrvConfirmacionResponse(soap, &ns1__wmImed_USCORESrvConfirmacionResponse, "ns1:wmImed_SrvConfirmacionResponse", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap->error;
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns3__wmImed_USCORESrvConfirmacion(struct soap *soap)
{	struct __ns3__wmImed_USCORESrvConfirmacion soap_tmp___ns3__wmImed_USCORESrvConfirmacion;
	struct _ns1__wmImed_USCORESrvConfirmacionResponse ns1__wmImed_USCORESrvConfirmacionResponse;
	soap_default__ns1__wmImed_USCORESrvConfirmacionResponse(soap, &ns1__wmImed_USCORESrvConfirmacionResponse);
	soap_default___ns3__wmImed_USCORESrvConfirmacion(soap, &soap_tmp___ns3__wmImed_USCORESrvConfirmacion);
	soap->encodingStyle = NULL;
	if (!soap_get___ns3__wmImed_USCORESrvConfirmacion(soap, &soap_tmp___ns3__wmImed_USCORESrvConfirmacion, "-ns3:wmImed_SrvConfirmacion", NULL))
		return soap->error;
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap->error;
	soap->error = __ns3__wmImed_USCORESrvConfirmacion(soap, soap_tmp___ns3__wmImed_USCORESrvConfirmacion.ns1__wmImed_USCORESrvConfirmacion, &ns1__wmImed_USCORESrvConfirmacionResponse);
	if (soap->error)
		return soap->error;
	soap_serializeheader(soap);
	soap_serialize__ns1__wmImed_USCORESrvConfirmacionResponse(soap, &ns1__wmImed_USCORESrvConfirmacionResponse);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put__ns1__wmImed_USCORESrvConfirmacionResponse(soap, &ns1__wmImed_USCORESrvConfirmacionResponse, "ns1:wmImed_SrvConfirmacionResponse", NULL)
		 || soap_body_end_out(soap)
		 || soap_envelope_end_out(soap))
			 return soap->error;
	};
	if (soap_end_count(soap)
	 || soap_response(soap, SOAP_OK)
	 || soap_envelope_begin_out(soap)
	 || soap_putheader(soap)
	 || soap_body_begin_out(soap)
	 || soap_put__ns1__wmImed_USCORESrvConfirmacionResponse(soap, &ns1__wmImed_USCORESrvConfirmacionResponse, "ns1:wmImed_SrvConfirmacionResponse", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap->error;
	return soap_closesock(soap);
}

#ifdef __cplusplus
}
#endif

#if defined(__BORLANDC__)
#pragma option pop
#pragma option pop
#endif

/* End of soapServer.c */