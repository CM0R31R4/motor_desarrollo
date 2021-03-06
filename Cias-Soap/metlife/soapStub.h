/* soapStub.h
   Generated by gSOAP 2.8.14 from metlife_cert.h

Copyright(C) 2000-2013, Robert van Engelen, Genivia Inc. All Rights Reserved.
The generated code is released under ONE of the following licenses:
GPL or Genivia's license for commercial use.
This program is released under the GPL with the additional exemption that
compiling, linking, and/or using OpenSSL is allowed.
*/

#ifndef soapStub_H
#define soapStub_H
#include <vector>
#define SOAP_NAMESPACE_OF_ns1	"http://tempuri.org/"
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

#ifndef SOAP_TYPE__ns1__wmImed_USCORESrvCertificacion
#define SOAP_TYPE__ns1__wmImed_USCORESrvCertificacion (8)
/* ns1:wmImed_SrvCertificacion */
class SOAP_CMAC _ns1__wmImed_USCORESrvCertificacion
{
public:
	std::string *XML_USCOREINPUT;	/* optional element of type xsd:string */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 8; } /* = unique id SOAP_TYPE__ns1__wmImed_USCORESrvCertificacion */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__wmImed_USCORESrvCertificacion() { _ns1__wmImed_USCORESrvCertificacion::soap_default(NULL); }
	virtual ~_ns1__wmImed_USCORESrvCertificacion() { }
};
#endif

#ifndef SOAP_TYPE__ns1__wmImed_USCORESrvCertificacionResponse
#define SOAP_TYPE__ns1__wmImed_USCORESrvCertificacionResponse (9)
/* ns1:wmImed_SrvCertificacionResponse */
class SOAP_CMAC _ns1__wmImed_USCORESrvCertificacionResponse
{
public:
	std::string *wmImed_USCORESrvCertificacionResult;	/* SOAP 1.2 RPC return element (when namespace qualified) */	/* optional element of type xsd:string */
	struct soap *soap;	/* transient */
public:
	virtual int soap_type() const { return 9; } /* = unique id SOAP_TYPE__ns1__wmImed_USCORESrvCertificacionResponse */
	virtual void soap_default(struct soap*);
	virtual void soap_serialize(struct soap*) const;
	virtual int soap_put(struct soap*, const char*, const char*) const;
	virtual int soap_out(struct soap*, const char*, int, const char*) const;
	virtual void *soap_get(struct soap*, const char*, const char*);
	virtual void *soap_in(struct soap*, const char*, const char*);
	         _ns1__wmImed_USCORESrvCertificacionResponse() { _ns1__wmImed_USCORESrvCertificacionResponse::soap_default(NULL); }
	virtual ~_ns1__wmImed_USCORESrvCertificacionResponse() { }
};
#endif

#ifndef SOAP_TYPE___ns1__wmImed_USCORESrvCertificacion
#define SOAP_TYPE___ns1__wmImed_USCORESrvCertificacion (16)
/* Operation wrapper: */
struct __ns1__wmImed_USCORESrvCertificacion
{
public:
	_ns1__wmImed_USCORESrvCertificacion *ns1__wmImed_USCORESrvCertificacion;	/* optional element of type ns1:wmImed_SrvCertificacion */
public:
	int soap_type() const { return 16; } /* = unique id SOAP_TYPE___ns1__wmImed_USCORESrvCertificacion */
};
#endif

#ifndef SOAP_TYPE___ns1__wmImed_USCORESrvCertificacion_
#define SOAP_TYPE___ns1__wmImed_USCORESrvCertificacion_ (18)
/* Operation wrapper: */
struct __ns1__wmImed_USCORESrvCertificacion_
{
public:
	_ns1__wmImed_USCORESrvCertificacion *ns1__wmImed_USCORESrvCertificacion;	/* optional element of type ns1:wmImed_SrvCertificacion */
public:
	int soap_type() const { return 18; } /* = unique id SOAP_TYPE___ns1__wmImed_USCORESrvCertificacion_ */
};
#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Header
#define SOAP_TYPE_SOAP_ENV__Header (19)
/* SOAP Header: */
struct SOAP_ENV__Header
{
public:
	int soap_type() const { return 19; } /* = unique id SOAP_TYPE_SOAP_ENV__Header */
#ifdef WITH_NOEMPTYSTRUCT
private:
	char dummy;	/* dummy member to enable compilation */
#endif
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Code
#define SOAP_TYPE_SOAP_ENV__Code (20)
/* SOAP Fault Code: */
struct SOAP_ENV__Code
{
public:
	char *SOAP_ENV__Value;	/* optional element of type xsd:QName */
	struct SOAP_ENV__Code *SOAP_ENV__Subcode;	/* optional element of type SOAP-ENV:Code */
public:
	int soap_type() const { return 20; } /* = unique id SOAP_TYPE_SOAP_ENV__Code */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Detail
#define SOAP_TYPE_SOAP_ENV__Detail (22)
/* SOAP-ENV:Detail */
struct SOAP_ENV__Detail
{
public:
	char *__any;
	int __type;	/* any type of element <fault> (defined below) */
	void *fault;	/* transient */
public:
	int soap_type() const { return 22; } /* = unique id SOAP_TYPE_SOAP_ENV__Detail */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Reason
#define SOAP_TYPE_SOAP_ENV__Reason (25)
/* SOAP-ENV:Reason */
struct SOAP_ENV__Reason
{
public:
	char *SOAP_ENV__Text;	/* optional element of type xsd:string */
public:
	int soap_type() const { return 25; } /* = unique id SOAP_TYPE_SOAP_ENV__Reason */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Fault
#define SOAP_TYPE_SOAP_ENV__Fault (26)
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
	int soap_type() const { return 26; } /* = unique id SOAP_TYPE_SOAP_ENV__Fault */
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


SOAP_FMAC5 int SOAP_FMAC6 __ns1__wmImed_USCORESrvCertificacion(struct soap*, _ns1__wmImed_USCORESrvCertificacion *ns1__wmImed_USCORESrvCertificacion, _ns1__wmImed_USCORESrvCertificacionResponse *ns1__wmImed_USCORESrvCertificacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns1__wmImed_USCORESrvCertificacion_(struct soap*, _ns1__wmImed_USCORESrvCertificacion *ns1__wmImed_USCORESrvCertificacion, _ns1__wmImed_USCORESrvCertificacionResponse *ns1__wmImed_USCORESrvCertificacionResponse);

/******************************************************************************\
 *                                                                            *
 * Server-Side Skeletons to Invoke Service Operations                         *
 *                                                                            *
\******************************************************************************/

extern "C" SOAP_FMAC5 int SOAP_FMAC6 soap_serve(struct soap*);

extern "C" SOAP_FMAC5 int SOAP_FMAC6 soap_serve_request(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__wmImed_USCORESrvCertificacion(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns1__wmImed_USCORESrvCertificacion_(struct soap*);

/******************************************************************************\
 *                                                                            *
 * Client-Side Call Stubs                                                     *
 *                                                                            *
\******************************************************************************/


SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__wmImed_USCORESrvCertificacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__wmImed_USCORESrvCertificacion *ns1__wmImed_USCORESrvCertificacion, _ns1__wmImed_USCORESrvCertificacionResponse *ns1__wmImed_USCORESrvCertificacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns1__wmImed_USCORESrvCertificacion_(struct soap *soap, const char *soap_endpoint, const char *soap_action, _ns1__wmImed_USCORESrvCertificacion *ns1__wmImed_USCORESrvCertificacion, _ns1__wmImed_USCORESrvCertificacionResponse *ns1__wmImed_USCORESrvCertificacionResponse);

#endif

/* End of soapStub.h */
