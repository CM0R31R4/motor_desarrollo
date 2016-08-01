/* soapStub.h
   Generated by gSOAP 2.8.14 from cruzblanca.h

Copyright(C) 2000-2013, Robert van Engelen, Genivia Inc. All Rights Reserved.
The generated code is released under ONE of the following licenses:
GPL or Genivia's license for commercial use.
This program is released under the GPL with the additional exemption that
compiling, linking, and/or using OpenSSL is allowed.
*/

#ifndef soapStub_H
#define soapStub_H
#include <vector>
#define SOAP_NAMESPACE_OF_ns1	"http://Seguros.CruzBlanca.cl/WsIntegracionLGM/"
#include "stdsoap2.h"
#if GSOAP_VERSION != 20814
# error "GSOAP VERSION MISMATCH IN GENERATED CODE: PLEASE REINSTALL PACKAGE"
#endif


/******************************************************************************\
 *                                                                            *
 * Enumerations                                                               *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Types with Custom Serializers                                              *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Classes and Structs                                                        *
 *                                                                            *
\******************************************************************************/


#if 0 /* volatile type: do not declare here, declared elsewhere */

#endif

#if 0 /* volatile type: do not declare here, declared elsewhere */

#endif

#ifndef SOAP_TYPE__ns1__Certificacion
#define SOAP_TYPE__ns1__Certificacion (8)
/* ns1:Certificacion */
class SOAP_CMAC _ns1__Certificacion
{
public:
	int extCodSeguro;	/* required element of type xsd:int */
	std::string *extRutBeneficiario;	/* optional element of type xsd:string */
	std::string *extRutPrestador;	/* optional element of type xsd:string */
	int extCodFinanciador;	/* required element of type xsd:int */
	int extCodLugar;	/* required element of type xsd:int */
	int extNumOperacion;	/* required element of type xsd:int */
	std::string *ExtLisPrest1;	/* optional element of type xsd:string */
	std::string *ExtLisPrest2;	/* optional element of type xsd:string */
	std::string *ExtLisPrest3;	/* optional element of type xsd:string */
	std::string *ExtLisPrest4;	/* optional element of type xsd:string */
	std::string *ExtLisPrest5;	/* optional element of type xsd:string */
	std::string *ExtLisPrest6;	/* optional element of type xsd:string */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 8; } /* = unique id SOAP_TYPE__ns1__Certificacion */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__Certificacion() { _ns1__Certificacion::soap_default(NULL); }
	virtual ~_ns1__Certificacion() { }
};
#endif

#ifndef SOAP_TYPE__ns1__CertificacionResponse_CertificacionResult
#define SOAP_TYPE__ns1__CertificacionResponse_CertificacionResult (19)
/* ns1:CertificacionResponse-CertificacionResult */
class SOAP_CMAC _ns1__CertificacionResponse_CertificacionResult
{
public:
	char *__any;
	char *__mixed;
public:
	virtual int soap_type() const { return 19; } /* = unique id SOAP_TYPE__ns1__CertificacionResponse_CertificacionResult */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__CertificacionResponse_CertificacionResult() { _ns1__CertificacionResponse_CertificacionResult::soap_default(NULL); }
	virtual ~_ns1__CertificacionResponse_CertificacionResult() { }
};
#endif

#ifndef SOAP_TYPE__ns1__CertificacionResponse
#define SOAP_TYPE__ns1__CertificacionResponse (9)
/* ns1:CertificacionResponse */
class SOAP_CMAC _ns1__CertificacionResponse
{
public:
	_ns1__CertificacionResponse_CertificacionResult *CertificacionResult;	/* SOAP 1.2 RPC return element (when namespace qualified) */	/* optional element of type ns1:CertificacionResponse-CertificacionResult */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 9; } /* = unique id SOAP_TYPE__ns1__CertificacionResponse */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__CertificacionResponse() { _ns1__CertificacionResponse::soap_default(NULL); }
	virtual ~_ns1__CertificacionResponse() { }
};
#endif

#ifndef SOAP_TYPE__ns1__Confirmacion
#define SOAP_TYPE__ns1__Confirmacion (10)
/* ns1:Confirmacion */
class SOAP_CMAC _ns1__Confirmacion
{
public:
	int extCodSeguro;	/* required element of type xsd:int */
	int extNumOperacion;	/* required element of type xsd:int */
	std::string *extRutBeneficiario;	/* optional element of type xsd:string */
	std::string *extRutPrestador;	/* optional element of type xsd:string */
	std::string *extFechaEmision;	/* optional element of type xsd:string */
	std::string *extRutEmisor;	/* optional element of type xsd:string */
	std::string *extRutCajero;	/* optional element of type xsd:string */
	int extFolioBono;	/* required element of type xsd:int */
	int extCodFinanciador;	/* required element of type xsd:int */
	int extCodLugar;	/* required element of type xsd:int */
	int extMtoTot;	/* required element of type xsd:int */
	int extMtoCopago;	/* required element of type xsd:int */
	int extMtoBonif;	/* required element of type xsd:int */
	std::string *ExtLisPrest1;	/* optional element of type xsd:string */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 10; } /* = unique id SOAP_TYPE__ns1__Confirmacion */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__Confirmacion() { _ns1__Confirmacion::soap_default(NULL); }
	virtual ~_ns1__Confirmacion() { }
};
#endif

#ifndef SOAP_TYPE__ns1__ConfirmacionResponse_ConfirmacionResult
#define SOAP_TYPE__ns1__ConfirmacionResponse_ConfirmacionResult (21)
/* ns1:ConfirmacionResponse-ConfirmacionResult */
class SOAP_CMAC _ns1__ConfirmacionResponse_ConfirmacionResult
{
public:
	char *__any;
	char *__mixed;
public:
	virtual int soap_type() const { return 21; } /* = unique id SOAP_TYPE__ns1__ConfirmacionResponse_ConfirmacionResult */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__ConfirmacionResponse_ConfirmacionResult() { _ns1__ConfirmacionResponse_ConfirmacionResult::soap_default(NULL); }
	virtual ~_ns1__ConfirmacionResponse_ConfirmacionResult() { }
};
#endif

#ifndef SOAP_TYPE__ns1__ConfirmacionResponse
#define SOAP_TYPE__ns1__ConfirmacionResponse (11)
/* ns1:ConfirmacionResponse */
class SOAP_CMAC _ns1__ConfirmacionResponse
{
public:
	_ns1__ConfirmacionResponse_ConfirmacionResult *ConfirmacionResult;	/* SOAP 1.2 RPC return element (when namespace qualified) */	/* optional element of type ns1:ConfirmacionResponse-ConfirmacionResult */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 11; } /* = unique id SOAP_TYPE__ns1__ConfirmacionResponse */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__ConfirmacionResponse() { _ns1__ConfirmacionResponse::soap_default(NULL); }
	virtual ~_ns1__ConfirmacionResponse() { }
};
#endif

#ifndef SOAP_TYPE__ns1__Anulacion
#define SOAP_TYPE__ns1__Anulacion (12)
/* ns1:Anulacion */
class SOAP_CMAC _ns1__Anulacion
{
public:
	int extCodSeguro;	/* required element of type xsd:int */
	std::string *extRutBeneficiario;	/* optional element of type xsd:string */
	int extFolioAuto;	/* required element of type xsd:int */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 12; } /* = unique id SOAP_TYPE__ns1__Anulacion */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__Anulacion() { _ns1__Anulacion::soap_default(NULL); }
	virtual ~_ns1__Anulacion() { }
};
#endif

#ifndef SOAP_TYPE__ns1__AnulacionResponse_AnulacionResult
#define SOAP_TYPE__ns1__AnulacionResponse_AnulacionResult (23)
/* ns1:AnulacionResponse-AnulacionResult */
class SOAP_CMAC _ns1__AnulacionResponse_AnulacionResult
{
public:
	char *__any;
	char *__mixed;
public:
	virtual int soap_type() const { return 23; } /* = unique id SOAP_TYPE__ns1__AnulacionResponse_AnulacionResult */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__AnulacionResponse_AnulacionResult() { _ns1__AnulacionResponse_AnulacionResult::soap_default(NULL); }
	virtual ~_ns1__AnulacionResponse_AnulacionResult() { }
};
#endif

#ifndef SOAP_TYPE__ns1__AnulacionResponse
#define SOAP_TYPE__ns1__AnulacionResponse (13)
/* ns1:AnulacionResponse */
class SOAP_CMAC _ns1__AnulacionResponse
{
public:
	_ns1__AnulacionResponse_AnulacionResult *AnulacionResult;	/* SOAP 1.2 RPC return element (when namespace qualified) */	/* optional element of type ns1:AnulacionResponse-AnulacionResult */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 13; } /* = unique id SOAP_TYPE__ns1__AnulacionResponse */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__AnulacionResponse() { _ns1__AnulacionResponse::soap_default(NULL); }
	virtual ~_ns1__AnulacionResponse() { }
};
#endif

#ifndef SOAP_TYPE__ns1__Conciliacion
#define SOAP_TYPE__ns1__Conciliacion (14)
/* ns1:Conciliacion */
class SOAP_CMAC _ns1__Conciliacion
{
public:
	int extCodSeguro;	/* required element of type xsd:int */
	int extFolioAuto;	/* required element of type xsd:int */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 14; } /* = unique id SOAP_TYPE__ns1__Conciliacion */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__Conciliacion() { _ns1__Conciliacion::soap_default(NULL); }
	virtual ~_ns1__Conciliacion() { }
};
#endif

#ifndef SOAP_TYPE__ns1__ConciliacionResponse_ConciliacionResult
#define SOAP_TYPE__ns1__ConciliacionResponse_ConciliacionResult (25)
/* ns1:ConciliacionResponse-ConciliacionResult */
class SOAP_CMAC _ns1__ConciliacionResponse_ConciliacionResult
{
public:
	char *__any;
	char *__mixed;
public:
	virtual int soap_type() const { return 25; } /* = unique id SOAP_TYPE__ns1__ConciliacionResponse_ConciliacionResult */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__ConciliacionResponse_ConciliacionResult() { _ns1__ConciliacionResponse_ConciliacionResult::soap_default(NULL); }
	virtual ~_ns1__ConciliacionResponse_ConciliacionResult() { }
};
#endif

#ifndef SOAP_TYPE__ns1__ConciliacionResponse
#define SOAP_TYPE__ns1__ConciliacionResponse (15)
/* ns1:ConciliacionResponse */
class SOAP_CMAC _ns1__ConciliacionResponse
{
public:
	_ns1__ConciliacionResponse_ConciliacionResult *ConciliacionResult;	/* SOAP 1.2 RPC return element (when namespace qualified) */	/* optional element of type ns1:ConciliacionResponse-ConciliacionResult */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 15; } /* = unique id SOAP_TYPE__ns1__ConciliacionResponse */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__ConciliacionResponse() { _ns1__ConciliacionResponse::soap_default(NULL); }
	virtual ~_ns1__ConciliacionResponse() { }
};
#endif

#ifndef SOAP_TYPE___ns1__Certificacion
#define SOAP_TYPE___ns1__Certificacion (30)
/* Operation wrapper: */
struct __ns1__Certificacion
{
public:
	_ns1__Certificacion *ns1__Certificacion;	/* optional element of type ns1:Certificacion */
public:
	int soap_type() const { return 30; } /* = unique id SOAP_TYPE___ns1__Certificacion */
};
#endif

#ifndef SOAP_TYPE___ns1__Confirmacion
#define SOAP_TYPE___ns1__Confirmacion (34)
/* Operation wrapper: */
struct __ns1__Confirmacion
{
public:
	_ns1__Confirmacion *ns1__Confirmacion;	/* optional element of type ns1:Confirmacion */
public:
	int soap_type() const { return 34; } /* = unique id SOAP_TYPE___ns1__Confirmacion */
};
#endif

#ifndef SOAP_TYPE___ns1__Anulacion
#define SOAP_TYPE___ns1__Anulacion (38)
/* Operation wrapper: */
struct __ns1__Anulacion
{
public:
	_ns1__Anulacion *ns1__Anulacion;	/* optional element of type ns1:Anulacion */
public:
	int soap_type() const { return 38; } /* = unique id SOAP_TYPE___ns1__Anulacion */
};
#endif

#ifndef SOAP_TYPE___ns1__Conciliacion
#define SOAP_TYPE___ns1__Conciliacion (42)
/* Operation wrapper: */
struct __ns1__Conciliacion
{
public:
	_ns1__Conciliacion *ns1__Conciliacion;	/* optional element of type ns1:Conciliacion */
public:
	int soap_type() const { return 42; } /* = unique id SOAP_TYPE___ns1__Conciliacion */
};
#endif

#ifndef SOAP_TYPE___ns1__Certificacion_
#define SOAP_TYPE___ns1__Certificacion_ (44)
/* Operation wrapper: */
struct __ns1__Certificacion_
{
public:
	_ns1__Certificacion *ns1__Certificacion;	/* optional element of type ns1:Certificacion */
public:
	int soap_type() const { return 44; } /* = unique id SOAP_TYPE___ns1__Certificacion_ */
};
#endif

#ifndef SOAP_TYPE___ns1__Confirmacion_
#define SOAP_TYPE___ns1__Confirmacion_ (46)
/* Operation wrapper: */
struct __ns1__Confirmacion_
{
public:
	_ns1__Confirmacion *ns1__Confirmacion;	/* optional element of type ns1:Confirmacion */
public:
	int soap_type() const { return 46; } /* = unique id SOAP_TYPE___ns1__Confirmacion_ */
};
#endif

#ifndef SOAP_TYPE___ns1__Anulacion_
#define SOAP_TYPE___ns1__Anulacion_ (48)
/* Operation wrapper: */
struct __ns1__Anulacion_
{
public:
	_ns1__Anulacion *ns1__Anulacion;	/* optional element of type ns1:Anulacion */
public:
	int soap_type() const { return 48; } /* = unique id SOAP_TYPE___ns1__Anulacion_ */
};
#endif

#ifndef SOAP_TYPE___ns1__Conciliacion_
#define SOAP_TYPE___ns1__Conciliacion_ (50)
/* Operation wrapper: */
struct __ns1__Conciliacion_
{
public:
	_ns1__Conciliacion *ns1__Conciliacion;	/* optional element of type ns1:Conciliacion */
public:
	int soap_type() const { return 50; } /* = unique id SOAP_TYPE___ns1__Conciliacion_ */
};
#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Header
#define SOAP_TYPE_SOAP_ENV__Header (51)
/* SOAP Header: */
struct SOAP_ENV__Header
{
public:
	int soap_type() const { return 51; } /* = unique id SOAP_TYPE_SOAP_ENV__Header */
#ifdef WITH_NOEMPTYSTRUCT
private:
	char dummy;	/* dummy member to enable compilation */
#endif
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Code
#define SOAP_TYPE_SOAP_ENV__Code (52)
/* SOAP Fault Code: */
struct SOAP_ENV__Code
{
public:
	char *SOAP_ENV__Value;	/* optional element of type xsd:QName */
	struct SOAP_ENV__Code *SOAP_ENV__Subcode;	/* optional element of type SOAP-ENV:Code */
public:
	int soap_type() const { return 52; } /* = unique id SOAP_TYPE_SOAP_ENV__Code */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Detail
#define SOAP_TYPE_SOAP_ENV__Detail (54)
/* SOAP-ENV:Detail */
struct SOAP_ENV__Detail
{
public:
	char *__any;
	int __type;	/* any type of element <fault> (defined below) */
	void *fault;	/* transient */
public:
	int soap_type() const { return 54; } /* = unique id SOAP_TYPE_SOAP_ENV__Detail */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Reason
#define SOAP_TYPE_SOAP_ENV__Reason (57)
/* SOAP-ENV:Reason */
struct SOAP_ENV__Reason
{
public:
	char *SOAP_ENV__Text;	/* optional element of type xsd:string */
public:
	int soap_type() const { return 57; } /* = unique id SOAP_TYPE_SOAP_ENV__Reason */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Fault
#define SOAP_TYPE_SOAP_ENV__Fault (58)
/* SOAP Fault: */
struct SOAP_ENV__Fault
{
public:
	char *faultcode;	/* optional element of type xsd:QName */
	char *faultstring;	/* optional element of type xsd:string */
	char *faultactor;	/* optional element of type xsd:string */
	struct SOAP_ENV__Detail *detail;	/* optional element of type SOAP-ENV:Detail */
	struct SOAP_ENV__Code *SOAP_ENV__Code;	/* optional element of type SOAP-ENV:Code */
	struct SOAP_ENV__Reason *SOAP_ENV__Reason;	/* optional element of type SOAP-ENV:Reason */
	char *SOAP_ENV__Node;	/* optional element of type xsd:string */
	char *SOAP_ENV__Role;	/* optional element of type xsd:string */
	struct SOAP_ENV__Detail *SOAP_ENV__Detail;	/* optional element of type SOAP-ENV:Detail */
public:
	int soap_type() const { return 58; } /* = unique id SOAP_TYPE_SOAP_ENV__Fault */
};
#endif

#endif

/******************************************************************************\
 *                                                                            *
 * Typedefs                                                                   *
 *                                                                            *
\******************************************************************************/

#ifndef SOAP_TYPE__QName
#define SOAP_TYPE__QName (5)
typedef char *_QName;
#endif

#ifndef SOAP_TYPE__XML
#define SOAP_TYPE__XML (6)
typedef char *_XML;
#endif


/******************************************************************************\
 *                                                                            *
 * Externals                                                                  *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Server-Side Operations                                                     *
 *                                                                            *
\******************************************************************************/


SOAP_FMAC5 int SOAP_FMAC6 __ns1__Certificacion(struct soap*, _ns1__Certificacion *ns1__Certificacion, _ns1__CertificacionResponse *ns1__CertificacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns1__Confirmacion(struct soap*, _ns1__Confirmacion *ns1__Confirmacion, _ns1__ConfirmacionResponse *ns1__ConfirmacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns1__Anulacion(struct soap*, _ns1__Anulacion *ns1__Anulacion, _ns1__AnulacionResponse *ns1__AnulacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns1__Conciliacion(struct soap*, _ns1__Conciliacion *ns1__Conciliacion, _ns1__ConciliacionResponse *ns1__ConciliacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns1__Certificacion_(struct soap*, _ns1__Certificacion *ns1__Certificacion, _ns1__CertificacionResponse *ns1__CertificacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns1__Confirmacion_(struct soap*, _ns1__Confirmacion *ns1__Confirmacion, _ns1__ConfirmacionResponse *ns1__ConfirmacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns1__Anulacion_(struct soap*, _ns1__Anulacion *ns1__Anulacion, _ns1__AnulacionResponse *ns1__AnulacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns1__Conciliacion_(struct soap*, _ns1__Conciliacion *ns1__Conciliacion, _ns1__ConciliacionResponse *ns1__ConciliacionResponse);

/******************************************************************************\
 *                                                                            *
 * Server-Side Skeletons to Invoke Service Operations                         *
 *                                                                            *
\******************************************************************************/

extern "C" SOAP_FMAC5 int SOAP_FMAC6 soap_serve(struct soap*);

extern "C" SOAP_FMAC5 int SOAP_FMAC6 soap_serve_request(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__Certificacion(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__Confirmacion(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__Anulacion(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__Conciliacion(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__Certificacion_(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__Confirmacion_(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__Anulacion_(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__Conciliacion_(struct soap*);

/******************************************************************************\
 *                                                                            *
 * Client-Side Call Stubs                                                     *
 *                                                                            *
\******************************************************************************/


SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Certificacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Certificacion *ns1__Certificacion, _ns1__CertificacionResponse *ns1__CertificacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Confirmacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Confirmacion *ns1__Confirmacion, _ns1__ConfirmacionResponse *ns1__ConfirmacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Anulacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Anulacion *ns1__Anulacion, _ns1__AnulacionResponse *ns1__AnulacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Conciliacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Conciliacion *ns1__Conciliacion, _ns1__ConciliacionResponse *ns1__ConciliacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Certificacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Certificacion *ns1__Certificacion, _ns1__CertificacionResponse *ns1__CertificacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Confirmacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Confirmacion *ns1__Confirmacion, _ns1__ConfirmacionResponse *ns1__ConfirmacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Anulacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Anulacion *ns1__Anulacion, _ns1__AnulacionResponse *ns1__AnulacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__Conciliacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__Conciliacion *ns1__Conciliacion, _ns1__ConciliacionResponse *ns1__ConciliacionResponse);

#endif

/* End of soapStub.h */