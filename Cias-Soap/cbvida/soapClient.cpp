/* soapClient.cpp
   Generated by gSOAP 2.8.14 from cruzblanca.h

Copyright(C) 2000-2013, Robert van Engelen, Genivia Inc. All Rights Reserved.
The generated code is released under ONE of the following licenses:
GPL or Genivia's license for commercial use.
This program is released under the GPL with the additional exemption that
compiling, linking, and/or using OpenSSL is allowed.
*/

#if defined(__BORLANDC__)
#pragma option push -w-8060
#pragma option push -w-8004
#endif
#include "soapH.h"

SOAP_SOURCE_STAMP("@(#) soapClient.cpp ver 2.8.14 2015-02-18 20:47:17 GMT")


SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Certificacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Certificacion *ns1__Certificacion, _ns1__CertificacionResponse *ns1__CertificacionResponse)
{	struct __ns1__Certificacion soap_tmp___ns1__Certificacion;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/IntegracionLGM.asmx";
	if (soap_action == NULL)
		soap_action = "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Certificacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__Certificacion.ns1__Certificacion = ns1__Certificacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__Certificacion(soap, &soap_tmp___ns1__Certificacion);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__Certificacion(soap, &soap_tmp___ns1__Certificacion, "-ns1:Certificacion", NULL)
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
	 || soap_put___ns1__Certificacion(soap, &soap_tmp___ns1__Certificacion, "-ns1:Certificacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__CertificacionResponse)
		return soap_closesock(soap);
	ns1__CertificacionResponse->soap_default(soap);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	ns1__CertificacionResponse->soap_get(soap, "ns1:CertificacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Confirmacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Confirmacion *ns1__Confirmacion, _ns1__ConfirmacionResponse *ns1__ConfirmacionResponse)
{	struct __ns1__Confirmacion soap_tmp___ns1__Confirmacion;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/IntegracionLGM.asmx";
	if (soap_action == NULL)
		soap_action = "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Confirmacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__Confirmacion.ns1__Confirmacion = ns1__Confirmacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__Confirmacion(soap, &soap_tmp___ns1__Confirmacion);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__Confirmacion(soap, &soap_tmp___ns1__Confirmacion, "-ns1:Confirmacion", NULL)
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
	 || soap_put___ns1__Confirmacion(soap, &soap_tmp___ns1__Confirmacion, "-ns1:Confirmacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__ConfirmacionResponse)
		return soap_closesock(soap);
	ns1__ConfirmacionResponse->soap_default(soap);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	ns1__ConfirmacionResponse->soap_get(soap, "ns1:ConfirmacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Anulacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Anulacion *ns1__Anulacion, _ns1__AnulacionResponse *ns1__AnulacionResponse)
{	struct __ns1__Anulacion soap_tmp___ns1__Anulacion;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/IntegracionLGM.asmx";
	if (soap_action == NULL)
		soap_action = "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Anulacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__Anulacion.ns1__Anulacion = ns1__Anulacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__Anulacion(soap, &soap_tmp___ns1__Anulacion);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__Anulacion(soap, &soap_tmp___ns1__Anulacion, "-ns1:Anulacion", NULL)
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
	 || soap_put___ns1__Anulacion(soap, &soap_tmp___ns1__Anulacion, "-ns1:Anulacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__AnulacionResponse)
		return soap_closesock(soap);
	ns1__AnulacionResponse->soap_default(soap);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	ns1__AnulacionResponse->soap_get(soap, "ns1:AnulacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Conciliacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Conciliacion *ns1__Conciliacion, _ns1__ConciliacionResponse *ns1__ConciliacionResponse)
{	struct __ns1__Conciliacion soap_tmp___ns1__Conciliacion;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/IntegracionLGM.asmx";
	if (soap_action == NULL)
		soap_action = "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Conciliacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__Conciliacion.ns1__Conciliacion = ns1__Conciliacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__Conciliacion(soap, &soap_tmp___ns1__Conciliacion);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__Conciliacion(soap, &soap_tmp___ns1__Conciliacion, "-ns1:Conciliacion", NULL)
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
	 || soap_put___ns1__Conciliacion(soap, &soap_tmp___ns1__Conciliacion, "-ns1:Conciliacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__ConciliacionResponse)
		return soap_closesock(soap);
	ns1__ConciliacionResponse->soap_default(soap);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	ns1__ConciliacionResponse->soap_get(soap, "ns1:ConciliacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Certificacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Certificacion *ns1__Certificacion, _ns1__CertificacionResponse *ns1__CertificacionResponse)
{	struct __ns1__Certificacion_ soap_tmp___ns1__Certificacion_;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/IntegracionLGM.asmx";
	if (soap_action == NULL)
		soap_action = "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Certificacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__Certificacion_.ns1__Certificacion = ns1__Certificacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__Certificacion_(soap, &soap_tmp___ns1__Certificacion_);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__Certificacion_(soap, &soap_tmp___ns1__Certificacion_, "-ns1:Certificacion", NULL)
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
	 || soap_put___ns1__Certificacion_(soap, &soap_tmp___ns1__Certificacion_, "-ns1:Certificacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__CertificacionResponse)
		return soap_closesock(soap);
	ns1__CertificacionResponse->soap_default(soap);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	ns1__CertificacionResponse->soap_get(soap, "ns1:CertificacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Confirmacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Confirmacion *ns1__Confirmacion, _ns1__ConfirmacionResponse *ns1__ConfirmacionResponse)
{	struct __ns1__Confirmacion_ soap_tmp___ns1__Confirmacion_;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/IntegracionLGM.asmx";
	if (soap_action == NULL)
		soap_action = "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Confirmacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__Confirmacion_.ns1__Confirmacion = ns1__Confirmacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__Confirmacion_(soap, &soap_tmp___ns1__Confirmacion_);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__Confirmacion_(soap, &soap_tmp___ns1__Confirmacion_, "-ns1:Confirmacion", NULL)
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
	 || soap_put___ns1__Confirmacion_(soap, &soap_tmp___ns1__Confirmacion_, "-ns1:Confirmacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__ConfirmacionResponse)
		return soap_closesock(soap);
	ns1__ConfirmacionResponse->soap_default(soap);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	ns1__ConfirmacionResponse->soap_get(soap, "ns1:ConfirmacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Anulacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Anulacion *ns1__Anulacion, _ns1__AnulacionResponse *ns1__AnulacionResponse)
{	struct __ns1__Anulacion_ soap_tmp___ns1__Anulacion_;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/IntegracionLGM.asmx";
	if (soap_action == NULL)
		soap_action = "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Anulacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__Anulacion_.ns1__Anulacion = ns1__Anulacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__Anulacion_(soap, &soap_tmp___ns1__Anulacion_);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__Anulacion_(soap, &soap_tmp___ns1__Anulacion_, "-ns1:Anulacion", NULL)
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
	 || soap_put___ns1__Anulacion_(soap, &soap_tmp___ns1__Anulacion_, "-ns1:Anulacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__AnulacionResponse)
		return soap_closesock(soap);
	ns1__AnulacionResponse->soap_default(soap);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	ns1__AnulacionResponse->soap_get(soap, "ns1:AnulacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Conciliacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Conciliacion *ns1__Conciliacion, _ns1__ConciliacionResponse *ns1__ConciliacionResponse)
{	struct __ns1__Conciliacion_ soap_tmp___ns1__Conciliacion_;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/IntegracionLGM.asmx";
	if (soap_action == NULL)
		soap_action = "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Conciliacion";
	soap->encodingStyle = NULL;
	soap_tmp___ns1__Conciliacion_.ns1__Conciliacion = ns1__Conciliacion;
	soap_begin(soap);
	soap_serializeheader(soap);
	soap_serialize___ns1__Conciliacion_(soap, &soap_tmp___ns1__Conciliacion_);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put___ns1__Conciliacion_(soap, &soap_tmp___ns1__Conciliacion_, "-ns1:Conciliacion", NULL)
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
	 || soap_put___ns1__Conciliacion_(soap, &soap_tmp___ns1__Conciliacion_, "-ns1:Conciliacion", NULL)
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap_closesock(soap);
	if (!ns1__ConciliacionResponse)
		return soap_closesock(soap);
	ns1__ConciliacionResponse->soap_default(soap);
	if (soap_begin_recv(soap)
	 || soap_envelope_begin_in(soap)
	 || soap_recv_header(soap)
	 || soap_body_begin_in(soap))
		return soap_closesock(soap);
	ns1__ConciliacionResponse->soap_get(soap, "ns1:ConciliacionResponse", "");
	if (soap->error)
		return soap_recv_fault(soap, 0);
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap_closesock(soap);
	return soap_closesock(soap);
}

#if defined(__BORLANDC__)
#pragma option pop
#pragma option pop
#endif

/* End of soapClient.cpp */