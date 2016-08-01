/* soapStub.h
   Generated by gSOAP 2.8.7 from Anulacion_mpro.h

Copyright(C) 2000-2011, Robert van Engelen, Genivia Inc. All Rights Reserved.
The generated code is released under one of the following licenses:
1) GPL or 2) Genivia's license for commercial use.
This program is released under the GPL with the additional exemption that
compiling, linking, and/or using OpenSSL is allowed.
*/

#ifndef soapStub_H
#define soapStub_H
#define SOAP_NAMESPACE_OF_ns1	"http://tempuri.org/"
#include "stdsoap2.h"
#if GSOAP_H_VERSION != 20807
# error "GSOAP VERSION MISMATCH IN GENERATED CODE: PLEASE REINSTALL PACKAGE"
#endif

#ifdef __cplusplus
extern "C" {
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

#ifndef SOAP_TYPE__ns1__wmImed_USCORESrvAnulacion
#define SOAP_TYPE__ns1__wmImed_USCORESrvAnulacion (7)
/* ns1:wmImed_SrvAnulacion */
struct _ns1__wmImed_USCORESrvAnulacion
{
	char *XML_USCOREINPUT;	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE__ns1__wmImed_USCORESrvAnulacionResponse_wmImed_USCORESrvAnulacionResult
#define SOAP_TYPE__ns1__wmImed_USCORESrvAnulacionResponse_wmImed_USCORESrvAnulacionResult (9)
/* ns1:wmImed_SrvAnulacionResponse-wmImed_SrvAnulacionResult */
struct _ns1__wmImed_USCORESrvAnulacionResponse_wmImed_USCORESrvAnulacionResult
{
	char *__any;
	char *__mixed;
};
#endif

#ifndef SOAP_TYPE__ns1__wmImed_USCORESrvAnulacionResponse
#define SOAP_TYPE__ns1__wmImed_USCORESrvAnulacionResponse (8)
/* ns1:wmImed_SrvAnulacionResponse */
struct _ns1__wmImed_USCORESrvAnulacionResponse
{
	struct _ns1__wmImed_USCORESrvAnulacionResponse_wmImed_USCORESrvAnulacionResult *wmImed_USCORESrvAnulacionResult;	/* SOAP 1.2 RPC return element (when namespace qualified) */	/* optional element of type ns1:wmImed_SrvAnulacionResponse-wmImed_SrvAnulacionResult */
};
#endif

#ifndef SOAP_TYPE___ns2__wmImed_USCORESrvAnulacion
#define SOAP_TYPE___ns2__wmImed_USCORESrvAnulacion (14)
/* Operation wrapper: */
struct __ns2__wmImed_USCORESrvAnulacion
{
	struct _ns1__wmImed_USCORESrvAnulacion *ns1__wmImed_USCORESrvAnulacion;	/* optional element of type ns1:wmImed_SrvAnulacion */
};
#endif

#ifndef SOAP_TYPE___ns3__wmImed_USCORESrvAnulacion
#define SOAP_TYPE___ns3__wmImed_USCORESrvAnulacion (16)
/* Operation wrapper: */
struct __ns3__wmImed_USCORESrvAnulacion
{
	struct _ns1__wmImed_USCORESrvAnulacion *ns1__wmImed_USCORESrvAnulacion;	/* optional element of type ns1:wmImed_SrvAnulacion */
};
#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Header
#define SOAP_TYPE_SOAP_ENV__Header (17)
/* SOAP Header: */
struct SOAP_ENV__Header
{
#ifdef WITH_NOEMPTYSTRUCT
	char dummy;	/* dummy member to enable compilation */
#endif
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Code
#define SOAP_TYPE_SOAP_ENV__Code (18)
/* SOAP Fault Code: */
struct SOAP_ENV__Code
{
	char *SOAP_ENV__Value;	/* optional element of type xsd:QName */
	struct SOAP_ENV__Code *SOAP_ENV__Subcode;	/* optional element of type SOAP-ENV:Code */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Detail
#define SOAP_TYPE_SOAP_ENV__Detail (20)
/* SOAP-ENV:Detail */
struct SOAP_ENV__Detail
{
	char *__any;
	int __type;	/* any type of element <fault> (defined below) */
	void *fault;	/* transient */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Reason
#define SOAP_TYPE_SOAP_ENV__Reason (23)
/* SOAP-ENV:Reason */
struct SOAP_ENV__Reason
{
	char *SOAP_ENV__Text;	/* optional element of type xsd:string */
};
#endif

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Fault
#define SOAP_TYPE_SOAP_ENV__Fault (24)
/* SOAP Fault: */
struct SOAP_ENV__Fault
{
	char *faultcode;	/* optional element of type xsd:QName */
	char *faultstring;	/* optional element of type xsd:string */
	char *faultactor;	/* optional element of type xsd:string */
	struct SOAP_ENV__Detail *detail;	/* optional element of type SOAP-ENV:Detail */
	struct SOAP_ENV__Code *SOAP_ENV__Code;	/* optional element of type SOAP-ENV:Code */
	struct SOAP_ENV__Reason *SOAP_ENV__Reason;	/* optional element of type SOAP-ENV:Reason */
	char *SOAP_ENV__Node;	/* optional element of type xsd:string */
	char *SOAP_ENV__Role;	/* optional element of type xsd:string */
	struct SOAP_ENV__Detail *SOAP_ENV__Detail;	/* optional element of type SOAP-ENV:Detail */
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


SOAP_FMAC5 int SOAP_FMAC6 __ns2__wmImed_USCORESrvAnulacion(struct soap*, struct _ns1__wmImed_USCORESrvAnulacion *ns1__wmImed_USCORESrvAnulacion, struct _ns1__wmImed_USCORESrvAnulacionResponse *ns1__wmImed_USCORESrvAnulacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 __ns3__wmImed_USCORESrvAnulacion(struct soap*, struct _ns1__wmImed_USCORESrvAnulacion *ns1__wmImed_USCORESrvAnulacion, struct _ns1__wmImed_USCORESrvAnulacionResponse *ns1__wmImed_USCORESrvAnulacionResponse);

/******************************************************************************\
 *                                                                            *
 * Server-Side Skeletons to Invoke Service Operations                         *
 *                                                                            *
\******************************************************************************/

SOAP_FMAC5 int SOAP_FMAC6 soap_serve(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_request(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns2__wmImed_USCORESrvAnulacion(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve___ns3__wmImed_USCORESrvAnulacion(struct soap*);

/******************************************************************************\
 *                                                                            *
 * Client-Side Call Stubs                                                     *
 *                                                                            *
\******************************************************************************/


SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns2__wmImed_USCORESrvAnulacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, struct _ns1__wmImed_USCORESrvAnulacion *ns1__wmImed_USCORESrvAnulacion, struct _ns1__wmImed_USCORESrvAnulacionResponse *ns1__wmImed_USCORESrvAnulacionResponse);

SOAP_FMAC5 int SOAP_FMAC6 soap_call___ns3__wmImed_USCORESrvAnulacion(struct soap *soap, const char *soap_endpoint, const char *soap_action, struct _ns1__wmImed_USCORESrvAnulacion *ns1__wmImed_USCORESrvAnulacion, struct _ns1__wmImed_USCORESrvAnulacionResponse *ns1__wmImed_USCORESrvAnulacionResponse);

#ifdef __cplusplus
}
#endif

#endif

/* End of soapStub.h */
