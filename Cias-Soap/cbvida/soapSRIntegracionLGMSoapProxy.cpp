/* soapSRIntegracionLGMSoapProxy.cpp
   Generated by gSOAP 2.8.14 from cbvida.h

Copyright(C) 2000-2013, Robert van Engelen, Genivia Inc. All Rights Reserved.
The generated code is released under ONE of the following licenses:
GPL or Genivia's license for commercial use.
This program is released under the GPL with the additional exemption that
compiling, linking, and/or using OpenSSL is allowed.
*/

#include "soapSRIntegracionLGMSoapProxy.h"

SRIntegracionLGMSoapProxy::SRIntegracionLGMSoapProxy()
{	this->soap = soap_new();
	this->own = true;
	SRIntegracionLGMSoapProxy_init(SOAP_IO_DEFAULT, SOAP_IO_DEFAULT);
}

SRIntegracionLGMSoapProxy::SRIntegracionLGMSoapProxy(struct soap *_soap)
{	this->soap = _soap;
	this->own = false;
	SRIntegracionLGMSoapProxy_init(_soap->imode, _soap->omode);
}

SRIntegracionLGMSoapProxy::SRIntegracionLGMSoapProxy(const char *url)
{	this->soap = soap_new();
	this->own = true;
	SRIntegracionLGMSoapProxy_init(SOAP_IO_DEFAULT, SOAP_IO_DEFAULT);
	soap_endpoint = url;
}

SRIntegracionLGMSoapProxy::SRIntegracionLGMSoapProxy(soap_mode iomode)
{	this->soap = soap_new();
	this->own = true;
	SRIntegracionLGMSoapProxy_init(iomode, iomode);
}

SRIntegracionLGMSoapProxy::SRIntegracionLGMSoapProxy(const char *url, soap_mode iomode)
{	this->soap = soap_new();
	this->own = true;
	SRIntegracionLGMSoapProxy_init(iomode, iomode);
	soap_endpoint = url;
}

SRIntegracionLGMSoapProxy::SRIntegracionLGMSoapProxy(soap_mode imode, soap_mode omode)
{	this->soap = soap_new();
	this->own = true;
	SRIntegracionLGMSoapProxy_init(imode, omode);
}

SRIntegracionLGMSoapProxy::~SRIntegracionLGMSoapProxy()
{	if (this->own)
		soap_free(this->soap);
}

void SRIntegracionLGMSoapProxy::SRIntegracionLGMSoapProxy_init(soap_mode imode, soap_mode omode)
{	soap_imode(this->soap, imode);
	soap_omode(this->soap, omode);
	soap_endpoint = NULL;
	static const struct Namespace namespaces[] =
{
	{"SOAP-ENV", "http://www.w3.org/2003/05/soap-envelope", "http://schemas.xmlsoap.org/soap/envelope/", NULL},
	{"SOAP-ENC", "http://www.w3.org/2003/05/soap-encoding", "http://schemas.xmlsoap.org/soap/encoding/", NULL},
	{"xsi", "http://www.w3.org/2001/XMLSchema-instance", "http://www.w3.org/*/XMLSchema-instance", NULL},
	{"xsd", "http://www.w3.org/2001/XMLSchema", "http://www.w3.org/*/XMLSchema", NULL},
	{"ns1", "http://Seguros.CruzBlanca.cl/WsIntegracionLGM/", NULL, NULL},
	{NULL, NULL, NULL, NULL}
};
	soap_set_namespaces(this->soap, namespaces);
}

void SRIntegracionLGMSoapProxy::destroy()
{	soap_destroy(this->soap);
	soap_end(this->soap);
}

void SRIntegracionLGMSoapProxy::reset()
{	destroy();
	soap_done(this->soap);
	soap_init(this->soap);
	SRIntegracionLGMSoapProxy_init(SOAP_IO_DEFAULT, SOAP_IO_DEFAULT);
}

void SRIntegracionLGMSoapProxy::soap_noheader()
{	this->soap->header = NULL;
}

const SOAP_ENV__Header *SRIntegracionLGMSoapProxy::soap_header()
{	return this->soap->header;
}

const SOAP_ENV__Fault *SRIntegracionLGMSoapProxy::soap_fault()
{	return this->soap->fault;
}

const char *SRIntegracionLGMSoapProxy::soap_fault_string()
{	return *soap_faultstring(this->soap);
}

const char *SRIntegracionLGMSoapProxy::soap_fault_detail()
{	return *soap_faultdetail(this->soap);
}

int SRIntegracionLGMSoapProxy::soap_close_socket()
{	return soap_closesock(this->soap);
}

int SRIntegracionLGMSoapProxy::soap_force_close_socket()
{	return soap_force_closesock(this->soap);
}

void SRIntegracionLGMSoapProxy::soap_print_fault(FILE *fd)
{	::soap_print_fault(this->soap, fd);
}

#ifndef WITH_LEAN
#ifndef WITH_COMPAT
void SRIntegracionLGMSoapProxy::soap_stream_fault(std::ostream& os)
{	::soap_stream_fault(this->soap, os);
}
#endif

char *SRIntegracionLGMSoapProxy::soap_sprint_fault(char *buf, size_t len)
{	return ::soap_sprint_fault(this->soap, buf, len);
}
#endif

int SRIntegracionLGMSoapProxy::Certificacion(const char *endpoint, const char *soap_action, _ns1__Certificacion *ns1__Certificacion, _ns1__CertificacionResponse *ns1__CertificacionResponse)
{	struct soap *soap = this->soap;
	struct __ns1__Certificacion soap_tmp___ns1__Certificacion;
	if (endpoint)
		soap_endpoint = endpoint;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx";
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

int SRIntegracionLGMSoapProxy::Confirmacion(const char *endpoint, const char *soap_action, _ns1__Confirmacion *ns1__Confirmacion, _ns1__ConfirmacionResponse *ns1__ConfirmacionResponse)
{	struct soap *soap = this->soap;
	struct __ns1__Confirmacion soap_tmp___ns1__Confirmacion;
	if (endpoint)
		soap_endpoint = endpoint;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx";
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

int SRIntegracionLGMSoapProxy::Anulacion(const char *endpoint, const char *soap_action, _ns1__Anulacion *ns1__Anulacion, _ns1__AnulacionResponse *ns1__AnulacionResponse)
{	struct soap *soap = this->soap;
	struct __ns1__Anulacion soap_tmp___ns1__Anulacion;
	if (endpoint)
		soap_endpoint = endpoint;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx";
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

int SRIntegracionLGMSoapProxy::Conciliacion(const char *endpoint, const char *soap_action, _ns1__Conciliacion *ns1__Conciliacion, _ns1__ConciliacionResponse *ns1__ConciliacionResponse)
{	struct soap *soap = this->soap;
	struct __ns1__Conciliacion soap_tmp___ns1__Conciliacion;
	if (endpoint)
		soap_endpoint = endpoint;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx";
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

int SRIntegracionLGMSoapProxy::Certificacion_(const char *endpoint, const char *soap_action, _ns1__Certificacion *ns1__Certificacion, _ns1__CertificacionResponse *ns1__CertificacionResponse)
{	struct soap *soap = this->soap;
	struct __ns1__Certificacion_ soap_tmp___ns1__Certificacion_;
	if (endpoint)
		soap_endpoint = endpoint;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx";
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

int SRIntegracionLGMSoapProxy::Confirmacion_(const char *endpoint, const char *soap_action, _ns1__Confirmacion *ns1__Confirmacion, _ns1__ConfirmacionResponse *ns1__ConfirmacionResponse)
{	struct soap *soap = this->soap;
	struct __ns1__Confirmacion_ soap_tmp___ns1__Confirmacion_;
	if (endpoint)
		soap_endpoint = endpoint;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx";
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

int SRIntegracionLGMSoapProxy::Anulacion_(const char *endpoint, const char *soap_action, _ns1__Anulacion *ns1__Anulacion, _ns1__AnulacionResponse *ns1__AnulacionResponse)
{	struct soap *soap = this->soap;
	struct __ns1__Anulacion_ soap_tmp___ns1__Anulacion_;
	if (endpoint)
		soap_endpoint = endpoint;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx";
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

int SRIntegracionLGMSoapProxy::Conciliacion_(const char *endpoint, const char *soap_action, _ns1__Conciliacion *ns1__Conciliacion, _ns1__ConciliacionResponse *ns1__ConciliacionResponse)
{	struct soap *soap = this->soap;
	struct __ns1__Conciliacion_ soap_tmp___ns1__Conciliacion_;
	if (endpoint)
		soap_endpoint = endpoint;
	if (soap_endpoint == NULL)
		soap_endpoint = "http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx";
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
/* End of client proxy code */
