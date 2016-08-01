/* soapH.h
   Generated by gSOAP 2.8.7 from Conciliacion_mpro.h

Copyright(C) 2000-2011, Robert van Engelen, Genivia Inc. All Rights Reserved.
The generated code is released under one of the following licenses:
1) GPL or 2) Genivia's license for commercial use.
This program is released under the GPL with the additional exemption that
compiling, linking, and/or using OpenSSL is allowed.
*/

#ifndef soapH_H
#define soapH_H
#include "soapStub.h"
#ifdef __cplusplus
extern "C" {
#endif
#ifndef WITH_NOIDREF
SOAP_FMAC3 void SOAP_FMAC4 soap_markelement(struct soap*, const void*, int);
SOAP_FMAC3 int SOAP_FMAC4 soap_putelement(struct soap*, const void*, const char*, int, int);
SOAP_FMAC3 void *SOAP_FMAC4 soap_getelement(struct soap*, int*);
SOAP_FMAC3 int SOAP_FMAC4 soap_putindependent(struct soap*);
SOAP_FMAC3 int SOAP_FMAC4 soap_getindependent(struct soap*);
#endif
SOAP_FMAC3 int SOAP_FMAC4 soap_ignore_element(struct soap*);

#ifndef SOAP_TYPE_byte
#define SOAP_TYPE_byte (3)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_byte(struct soap*, char *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_byte(struct soap*, const char*, int, const char *, const char*);
SOAP_FMAC3 char * SOAP_FMAC4 soap_in_byte(struct soap*, const char*, char *, const char*);

#ifndef soap_write_byte
#define soap_write_byte(soap, data) ( soap_begin_send(soap) || soap_put_byte(soap, data, "byte", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_byte(struct soap*, const char *, const char*, const char*);

#ifndef soap_read_byte
#define soap_read_byte(soap, data) ( soap_begin_recv(soap) || !soap_get_byte(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 char * SOAP_FMAC4 soap_get_byte(struct soap*, char *, const char*, const char*);

#ifndef SOAP_TYPE_int
#define SOAP_TYPE_int (1)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_int(struct soap*, int *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_int(struct soap*, const char*, int, const int *, const char*);
SOAP_FMAC3 int * SOAP_FMAC4 soap_in_int(struct soap*, const char*, int *, const char*);

#ifndef soap_write_int
#define soap_write_int(soap, data) ( soap_begin_send(soap) || soap_put_int(soap, data, "int", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_int(struct soap*, const int *, const char*, const char*);

#ifndef soap_read_int
#define soap_read_int(soap, data) ( soap_begin_recv(soap) || !soap_get_int(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 int * SOAP_FMAC4 soap_get_int(struct soap*, int *, const char*, const char*);

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Fault
#define SOAP_TYPE_SOAP_ENV__Fault (24)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_SOAP_ENV__Fault(struct soap*, struct SOAP_ENV__Fault *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_SOAP_ENV__Fault(struct soap*, const struct SOAP_ENV__Fault *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_SOAP_ENV__Fault(struct soap*, const char*, int, const struct SOAP_ENV__Fault *, const char*);
SOAP_FMAC3 struct SOAP_ENV__Fault * SOAP_FMAC4 soap_in_SOAP_ENV__Fault(struct soap*, const char*, struct SOAP_ENV__Fault *, const char*);

#ifndef soap_write_SOAP_ENV__Fault
#define soap_write_SOAP_ENV__Fault(soap, data) ( soap_begin_send(soap) || (soap_serialize_SOAP_ENV__Fault(soap, data), 0) || soap_put_SOAP_ENV__Fault(soap, data, "SOAP-ENV:Fault", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_SOAP_ENV__Fault(struct soap*, const struct SOAP_ENV__Fault *, const char*, const char*);

#ifndef soap_read_SOAP_ENV__Fault
#define soap_read_SOAP_ENV__Fault(soap, data) ( soap_begin_recv(soap) || !soap_get_SOAP_ENV__Fault(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct SOAP_ENV__Fault * SOAP_FMAC4 soap_get_SOAP_ENV__Fault(struct soap*, struct SOAP_ENV__Fault *, const char*, const char*);

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Reason
#define SOAP_TYPE_SOAP_ENV__Reason (23)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_SOAP_ENV__Reason(struct soap*, struct SOAP_ENV__Reason *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_SOAP_ENV__Reason(struct soap*, const struct SOAP_ENV__Reason *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_SOAP_ENV__Reason(struct soap*, const char*, int, const struct SOAP_ENV__Reason *, const char*);
SOAP_FMAC3 struct SOAP_ENV__Reason * SOAP_FMAC4 soap_in_SOAP_ENV__Reason(struct soap*, const char*, struct SOAP_ENV__Reason *, const char*);

#ifndef soap_write_SOAP_ENV__Reason
#define soap_write_SOAP_ENV__Reason(soap, data) ( soap_begin_send(soap) || (soap_serialize_SOAP_ENV__Reason(soap, data), 0) || soap_put_SOAP_ENV__Reason(soap, data, "SOAP-ENV:Reason", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_SOAP_ENV__Reason(struct soap*, const struct SOAP_ENV__Reason *, const char*, const char*);

#ifndef soap_read_SOAP_ENV__Reason
#define soap_read_SOAP_ENV__Reason(soap, data) ( soap_begin_recv(soap) || !soap_get_SOAP_ENV__Reason(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct SOAP_ENV__Reason * SOAP_FMAC4 soap_get_SOAP_ENV__Reason(struct soap*, struct SOAP_ENV__Reason *, const char*, const char*);

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Detail
#define SOAP_TYPE_SOAP_ENV__Detail (20)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_SOAP_ENV__Detail(struct soap*, struct SOAP_ENV__Detail *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_SOAP_ENV__Detail(struct soap*, const struct SOAP_ENV__Detail *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_SOAP_ENV__Detail(struct soap*, const char*, int, const struct SOAP_ENV__Detail *, const char*);
SOAP_FMAC3 struct SOAP_ENV__Detail * SOAP_FMAC4 soap_in_SOAP_ENV__Detail(struct soap*, const char*, struct SOAP_ENV__Detail *, const char*);

#ifndef soap_write_SOAP_ENV__Detail
#define soap_write_SOAP_ENV__Detail(soap, data) ( soap_begin_send(soap) || (soap_serialize_SOAP_ENV__Detail(soap, data), 0) || soap_put_SOAP_ENV__Detail(soap, data, "SOAP-ENV:Detail", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_SOAP_ENV__Detail(struct soap*, const struct SOAP_ENV__Detail *, const char*, const char*);

#ifndef soap_read_SOAP_ENV__Detail
#define soap_read_SOAP_ENV__Detail(soap, data) ( soap_begin_recv(soap) || !soap_get_SOAP_ENV__Detail(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct SOAP_ENV__Detail * SOAP_FMAC4 soap_get_SOAP_ENV__Detail(struct soap*, struct SOAP_ENV__Detail *, const char*, const char*);

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Code
#define SOAP_TYPE_SOAP_ENV__Code (18)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_SOAP_ENV__Code(struct soap*, struct SOAP_ENV__Code *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_SOAP_ENV__Code(struct soap*, const struct SOAP_ENV__Code *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_SOAP_ENV__Code(struct soap*, const char*, int, const struct SOAP_ENV__Code *, const char*);
SOAP_FMAC3 struct SOAP_ENV__Code * SOAP_FMAC4 soap_in_SOAP_ENV__Code(struct soap*, const char*, struct SOAP_ENV__Code *, const char*);

#ifndef soap_write_SOAP_ENV__Code
#define soap_write_SOAP_ENV__Code(soap, data) ( soap_begin_send(soap) || (soap_serialize_SOAP_ENV__Code(soap, data), 0) || soap_put_SOAP_ENV__Code(soap, data, "SOAP-ENV:Code", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_SOAP_ENV__Code(struct soap*, const struct SOAP_ENV__Code *, const char*, const char*);

#ifndef soap_read_SOAP_ENV__Code
#define soap_read_SOAP_ENV__Code(soap, data) ( soap_begin_recv(soap) || !soap_get_SOAP_ENV__Code(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct SOAP_ENV__Code * SOAP_FMAC4 soap_get_SOAP_ENV__Code(struct soap*, struct SOAP_ENV__Code *, const char*, const char*);

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_SOAP_ENV__Header
#define SOAP_TYPE_SOAP_ENV__Header (17)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_SOAP_ENV__Header(struct soap*, struct SOAP_ENV__Header *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_SOAP_ENV__Header(struct soap*, const struct SOAP_ENV__Header *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_SOAP_ENV__Header(struct soap*, const char*, int, const struct SOAP_ENV__Header *, const char*);
SOAP_FMAC3 struct SOAP_ENV__Header * SOAP_FMAC4 soap_in_SOAP_ENV__Header(struct soap*, const char*, struct SOAP_ENV__Header *, const char*);

#ifndef soap_write_SOAP_ENV__Header
#define soap_write_SOAP_ENV__Header(soap, data) ( soap_begin_send(soap) || (soap_serialize_SOAP_ENV__Header(soap, data), 0) || soap_put_SOAP_ENV__Header(soap, data, "SOAP-ENV:Header", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_SOAP_ENV__Header(struct soap*, const struct SOAP_ENV__Header *, const char*, const char*);

#ifndef soap_read_SOAP_ENV__Header
#define soap_read_SOAP_ENV__Header(soap, data) ( soap_begin_recv(soap) || !soap_get_SOAP_ENV__Header(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct SOAP_ENV__Header * SOAP_FMAC4 soap_get_SOAP_ENV__Header(struct soap*, struct SOAP_ENV__Header *, const char*, const char*);

#endif

#ifndef SOAP_TYPE___ns3__wmImed_USCORESrvConciliacion
#define SOAP_TYPE___ns3__wmImed_USCORESrvConciliacion (16)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default___ns3__wmImed_USCORESrvConciliacion(struct soap*, struct __ns3__wmImed_USCORESrvConciliacion *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize___ns3__wmImed_USCORESrvConciliacion(struct soap*, const struct __ns3__wmImed_USCORESrvConciliacion *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out___ns3__wmImed_USCORESrvConciliacion(struct soap*, const char*, int, const struct __ns3__wmImed_USCORESrvConciliacion *, const char*);
SOAP_FMAC3 struct __ns3__wmImed_USCORESrvConciliacion * SOAP_FMAC4 soap_in___ns3__wmImed_USCORESrvConciliacion(struct soap*, const char*, struct __ns3__wmImed_USCORESrvConciliacion *, const char*);

#ifndef soap_write___ns3__wmImed_USCORESrvConciliacion
#define soap_write___ns3__wmImed_USCORESrvConciliacion(soap, data) ( soap_begin_send(soap) || (soap_serialize___ns3__wmImed_USCORESrvConciliacion(soap, data), 0) || soap_put___ns3__wmImed_USCORESrvConciliacion(soap, data, "-ns3:wmImed_SrvConciliacion", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put___ns3__wmImed_USCORESrvConciliacion(struct soap*, const struct __ns3__wmImed_USCORESrvConciliacion *, const char*, const char*);

#ifndef soap_read___ns3__wmImed_USCORESrvConciliacion
#define soap_read___ns3__wmImed_USCORESrvConciliacion(soap, data) ( soap_begin_recv(soap) || !soap_get___ns3__wmImed_USCORESrvConciliacion(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct __ns3__wmImed_USCORESrvConciliacion * SOAP_FMAC4 soap_get___ns3__wmImed_USCORESrvConciliacion(struct soap*, struct __ns3__wmImed_USCORESrvConciliacion *, const char*, const char*);

#ifndef SOAP_TYPE___ns2__wmImed_USCORESrvConciliacion
#define SOAP_TYPE___ns2__wmImed_USCORESrvConciliacion (14)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default___ns2__wmImed_USCORESrvConciliacion(struct soap*, struct __ns2__wmImed_USCORESrvConciliacion *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize___ns2__wmImed_USCORESrvConciliacion(struct soap*, const struct __ns2__wmImed_USCORESrvConciliacion *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out___ns2__wmImed_USCORESrvConciliacion(struct soap*, const char*, int, const struct __ns2__wmImed_USCORESrvConciliacion *, const char*);
SOAP_FMAC3 struct __ns2__wmImed_USCORESrvConciliacion * SOAP_FMAC4 soap_in___ns2__wmImed_USCORESrvConciliacion(struct soap*, const char*, struct __ns2__wmImed_USCORESrvConciliacion *, const char*);

#ifndef soap_write___ns2__wmImed_USCORESrvConciliacion
#define soap_write___ns2__wmImed_USCORESrvConciliacion(soap, data) ( soap_begin_send(soap) || (soap_serialize___ns2__wmImed_USCORESrvConciliacion(soap, data), 0) || soap_put___ns2__wmImed_USCORESrvConciliacion(soap, data, "-ns2:wmImed_SrvConciliacion", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put___ns2__wmImed_USCORESrvConciliacion(struct soap*, const struct __ns2__wmImed_USCORESrvConciliacion *, const char*, const char*);

#ifndef soap_read___ns2__wmImed_USCORESrvConciliacion
#define soap_read___ns2__wmImed_USCORESrvConciliacion(soap, data) ( soap_begin_recv(soap) || !soap_get___ns2__wmImed_USCORESrvConciliacion(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct __ns2__wmImed_USCORESrvConciliacion * SOAP_FMAC4 soap_get___ns2__wmImed_USCORESrvConciliacion(struct soap*, struct __ns2__wmImed_USCORESrvConciliacion *, const char*, const char*);

#ifndef SOAP_TYPE__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult
#define SOAP_TYPE__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult (9)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, const struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, const char*, int, const struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *, const char*);
SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult * SOAP_FMAC4 soap_in__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, const char*, struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *, const char*);

#ifndef soap_write__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult
#define soap_write__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data) ( soap_begin_send(soap) || (soap_serialize__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data), 0) || soap_put__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data, "ns1:wmImed_SrvConciliacionResponse-wmImed_SrvConciliacionResult", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, const struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *, const char*, const char*);

#ifndef soap_read__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult
#define soap_read__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data) ( soap_begin_recv(soap) || !soap_get__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult * SOAP_FMAC4 soap_get__ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *, const char*, const char*);

#ifndef SOAP_TYPE__ns1__wmImed_USCORESrvConciliacionResponse
#define SOAP_TYPE__ns1__wmImed_USCORESrvConciliacionResponse (8)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default__ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize__ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, const struct _ns1__wmImed_USCORESrvConciliacionResponse *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out__ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, const char*, int, const struct _ns1__wmImed_USCORESrvConciliacionResponse *, const char*);
SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacionResponse * SOAP_FMAC4 soap_in__ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, const char*, struct _ns1__wmImed_USCORESrvConciliacionResponse *, const char*);

#ifndef soap_write__ns1__wmImed_USCORESrvConciliacionResponse
#define soap_write__ns1__wmImed_USCORESrvConciliacionResponse(soap, data) ( soap_begin_send(soap) || (soap_serialize__ns1__wmImed_USCORESrvConciliacionResponse(soap, data), 0) || soap_put__ns1__wmImed_USCORESrvConciliacionResponse(soap, data, "ns1:wmImed_SrvConciliacionResponse", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put__ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, const struct _ns1__wmImed_USCORESrvConciliacionResponse *, const char*, const char*);

#ifndef soap_read__ns1__wmImed_USCORESrvConciliacionResponse
#define soap_read__ns1__wmImed_USCORESrvConciliacionResponse(soap, data) ( soap_begin_recv(soap) || !soap_get__ns1__wmImed_USCORESrvConciliacionResponse(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacionResponse * SOAP_FMAC4 soap_get__ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse *, const char*, const char*);

#ifndef SOAP_TYPE__ns1__wmImed_USCORESrvConciliacion
#define SOAP_TYPE__ns1__wmImed_USCORESrvConciliacion (7)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default__ns1__wmImed_USCORESrvConciliacion(struct soap*, struct _ns1__wmImed_USCORESrvConciliacion *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize__ns1__wmImed_USCORESrvConciliacion(struct soap*, const struct _ns1__wmImed_USCORESrvConciliacion *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out__ns1__wmImed_USCORESrvConciliacion(struct soap*, const char*, int, const struct _ns1__wmImed_USCORESrvConciliacion *, const char*);
SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacion * SOAP_FMAC4 soap_in__ns1__wmImed_USCORESrvConciliacion(struct soap*, const char*, struct _ns1__wmImed_USCORESrvConciliacion *, const char*);

#ifndef soap_write__ns1__wmImed_USCORESrvConciliacion
#define soap_write__ns1__wmImed_USCORESrvConciliacion(soap, data) ( soap_begin_send(soap) || (soap_serialize__ns1__wmImed_USCORESrvConciliacion(soap, data), 0) || soap_put__ns1__wmImed_USCORESrvConciliacion(soap, data, "ns1:wmImed_SrvConciliacion", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put__ns1__wmImed_USCORESrvConciliacion(struct soap*, const struct _ns1__wmImed_USCORESrvConciliacion *, const char*, const char*);

#ifndef soap_read__ns1__wmImed_USCORESrvConciliacion
#define soap_read__ns1__wmImed_USCORESrvConciliacion(soap, data) ( soap_begin_recv(soap) || !soap_get__ns1__wmImed_USCORESrvConciliacion(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacion * SOAP_FMAC4 soap_get__ns1__wmImed_USCORESrvConciliacion(struct soap*, struct _ns1__wmImed_USCORESrvConciliacion *, const char*, const char*);

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_PointerToSOAP_ENV__Reason
#define SOAP_TYPE_PointerToSOAP_ENV__Reason (26)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_PointerToSOAP_ENV__Reason(struct soap*, struct SOAP_ENV__Reason *const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_PointerToSOAP_ENV__Reason(struct soap*, const char *, int, struct SOAP_ENV__Reason *const*, const char *);
SOAP_FMAC3 struct SOAP_ENV__Reason ** SOAP_FMAC4 soap_in_PointerToSOAP_ENV__Reason(struct soap*, const char*, struct SOAP_ENV__Reason **, const char*);

#ifndef soap_write_PointerToSOAP_ENV__Reason
#define soap_write_PointerToSOAP_ENV__Reason(soap, data) ( soap_begin_send(soap) || (soap_serialize_PointerToSOAP_ENV__Reason(soap, data), 0) || soap_put_PointerToSOAP_ENV__Reason(soap, data, "SOAP-ENV:Reason", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_PointerToSOAP_ENV__Reason(struct soap*, struct SOAP_ENV__Reason *const*, const char*, const char*);

#ifndef soap_read_PointerToSOAP_ENV__Reason
#define soap_read_PointerToSOAP_ENV__Reason(soap, data) ( soap_begin_recv(soap) || !soap_get_PointerToSOAP_ENV__Reason(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct SOAP_ENV__Reason ** SOAP_FMAC4 soap_get_PointerToSOAP_ENV__Reason(struct soap*, struct SOAP_ENV__Reason **, const char*, const char*);

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_PointerToSOAP_ENV__Detail
#define SOAP_TYPE_PointerToSOAP_ENV__Detail (25)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_PointerToSOAP_ENV__Detail(struct soap*, struct SOAP_ENV__Detail *const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_PointerToSOAP_ENV__Detail(struct soap*, const char *, int, struct SOAP_ENV__Detail *const*, const char *);
SOAP_FMAC3 struct SOAP_ENV__Detail ** SOAP_FMAC4 soap_in_PointerToSOAP_ENV__Detail(struct soap*, const char*, struct SOAP_ENV__Detail **, const char*);

#ifndef soap_write_PointerToSOAP_ENV__Detail
#define soap_write_PointerToSOAP_ENV__Detail(soap, data) ( soap_begin_send(soap) || (soap_serialize_PointerToSOAP_ENV__Detail(soap, data), 0) || soap_put_PointerToSOAP_ENV__Detail(soap, data, "SOAP-ENV:Detail", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_PointerToSOAP_ENV__Detail(struct soap*, struct SOAP_ENV__Detail *const*, const char*, const char*);

#ifndef soap_read_PointerToSOAP_ENV__Detail
#define soap_read_PointerToSOAP_ENV__Detail(soap, data) ( soap_begin_recv(soap) || !soap_get_PointerToSOAP_ENV__Detail(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct SOAP_ENV__Detail ** SOAP_FMAC4 soap_get_PointerToSOAP_ENV__Detail(struct soap*, struct SOAP_ENV__Detail **, const char*, const char*);

#endif

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_PointerToSOAP_ENV__Code
#define SOAP_TYPE_PointerToSOAP_ENV__Code (19)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_PointerToSOAP_ENV__Code(struct soap*, struct SOAP_ENV__Code *const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_PointerToSOAP_ENV__Code(struct soap*, const char *, int, struct SOAP_ENV__Code *const*, const char *);
SOAP_FMAC3 struct SOAP_ENV__Code ** SOAP_FMAC4 soap_in_PointerToSOAP_ENV__Code(struct soap*, const char*, struct SOAP_ENV__Code **, const char*);

#ifndef soap_write_PointerToSOAP_ENV__Code
#define soap_write_PointerToSOAP_ENV__Code(soap, data) ( soap_begin_send(soap) || (soap_serialize_PointerToSOAP_ENV__Code(soap, data), 0) || soap_put_PointerToSOAP_ENV__Code(soap, data, "SOAP-ENV:Code", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_PointerToSOAP_ENV__Code(struct soap*, struct SOAP_ENV__Code *const*, const char*, const char*);

#ifndef soap_read_PointerToSOAP_ENV__Code
#define soap_read_PointerToSOAP_ENV__Code(soap, data) ( soap_begin_recv(soap) || !soap_get_PointerToSOAP_ENV__Code(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct SOAP_ENV__Code ** SOAP_FMAC4 soap_get_PointerToSOAP_ENV__Code(struct soap*, struct SOAP_ENV__Code **, const char*, const char*);

#endif

#ifndef SOAP_TYPE_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse
#define SOAP_TYPE_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse (12)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse *const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, const char *, int, struct _ns1__wmImed_USCORESrvConciliacionResponse *const*, const char *);
SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacionResponse ** SOAP_FMAC4 soap_in_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, const char*, struct _ns1__wmImed_USCORESrvConciliacionResponse **, const char*);

#ifndef soap_write_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse
#define soap_write_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(soap, data) ( soap_begin_send(soap) || (soap_serialize_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(soap, data), 0) || soap_put_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(soap, data, "ns1:wmImed_SrvConciliacionResponse", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse *const*, const char*, const char*);

#ifndef soap_read_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse
#define soap_read_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(soap, data) ( soap_begin_recv(soap) || !soap_get_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacionResponse ** SOAP_FMAC4 soap_get_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse **, const char*, const char*);

#ifndef SOAP_TYPE_PointerTo_ns1__wmImed_USCORESrvConciliacion
#define SOAP_TYPE_PointerTo_ns1__wmImed_USCORESrvConciliacion (11)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_PointerTo_ns1__wmImed_USCORESrvConciliacion(struct soap*, struct _ns1__wmImed_USCORESrvConciliacion *const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_PointerTo_ns1__wmImed_USCORESrvConciliacion(struct soap*, const char *, int, struct _ns1__wmImed_USCORESrvConciliacion *const*, const char *);
SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacion ** SOAP_FMAC4 soap_in_PointerTo_ns1__wmImed_USCORESrvConciliacion(struct soap*, const char*, struct _ns1__wmImed_USCORESrvConciliacion **, const char*);

#ifndef soap_write_PointerTo_ns1__wmImed_USCORESrvConciliacion
#define soap_write_PointerTo_ns1__wmImed_USCORESrvConciliacion(soap, data) ( soap_begin_send(soap) || (soap_serialize_PointerTo_ns1__wmImed_USCORESrvConciliacion(soap, data), 0) || soap_put_PointerTo_ns1__wmImed_USCORESrvConciliacion(soap, data, "ns1:wmImed_SrvConciliacion", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_PointerTo_ns1__wmImed_USCORESrvConciliacion(struct soap*, struct _ns1__wmImed_USCORESrvConciliacion *const*, const char*, const char*);

#ifndef soap_read_PointerTo_ns1__wmImed_USCORESrvConciliacion
#define soap_read_PointerTo_ns1__wmImed_USCORESrvConciliacion(soap, data) ( soap_begin_recv(soap) || !soap_get_PointerTo_ns1__wmImed_USCORESrvConciliacion(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacion ** SOAP_FMAC4 soap_get_PointerTo_ns1__wmImed_USCORESrvConciliacion(struct soap*, struct _ns1__wmImed_USCORESrvConciliacion **, const char*, const char*);

#ifndef SOAP_TYPE_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult
#define SOAP_TYPE_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult (10)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, const char *, int, struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *const*, const char *);
SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult ** SOAP_FMAC4 soap_in_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, const char*, struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult **, const char*);

#ifndef soap_write_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult
#define soap_write_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data) ( soap_begin_send(soap) || (soap_serialize_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data), 0) || soap_put_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data, "ns1:wmImed_SrvConciliacionResponse-wmImed_SrvConciliacionResult", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult *const*, const char*, const char*);

#ifndef soap_read_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult
#define soap_read_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data) ( soap_begin_recv(soap) || !soap_get_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult ** SOAP_FMAC4 soap_get_PointerTo_ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult(struct soap*, struct _ns1__wmImed_USCORESrvConciliacionResponse_wmImed_USCORESrvConciliacionResult **, const char*, const char*);

#ifndef SOAP_TYPE__QName
#define SOAP_TYPE__QName (5)
#endif

#define soap_default__QName(soap, a) soap_default_string(soap, a)


#define soap_serialize__QName(soap, a) soap_serialize_string(soap, a)

SOAP_FMAC3 int SOAP_FMAC4 soap_out__QName(struct soap*, const char*, int, char*const*, const char*);
SOAP_FMAC3 char * * SOAP_FMAC4 soap_in__QName(struct soap*, const char*, char **, const char*);

#ifndef soap_write__QName
#define soap_write__QName(soap, data) ( soap_begin_send(soap) || (soap_serialize__QName(soap, data), 0) || soap_put__QName(soap, data, "byte", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put__QName(struct soap*, char *const*, const char*, const char*);

#ifndef soap_read__QName
#define soap_read__QName(soap, data) ( soap_begin_recv(soap) || !soap_get__QName(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 char ** SOAP_FMAC4 soap_get__QName(struct soap*, char **, const char*, const char*);

#ifndef SOAP_TYPE_string
#define SOAP_TYPE_string (4)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_string(struct soap*, char **);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_string(struct soap*, char *const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_string(struct soap*, const char*, int, char*const*, const char*);
SOAP_FMAC3 char * * SOAP_FMAC4 soap_in_string(struct soap*, const char*, char **, const char*);

#ifndef soap_write_string
#define soap_write_string(soap, data) ( soap_begin_send(soap) || (soap_serialize_string(soap, data), 0) || soap_put_string(soap, data, "byte", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_string(struct soap*, char *const*, const char*, const char*);

#ifndef soap_read_string
#define soap_read_string(soap, data) ( soap_begin_recv(soap) || !soap_get_string(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 char ** SOAP_FMAC4 soap_get_string(struct soap*, char **, const char*, const char*);

#ifdef __cplusplus
}
#endif

#endif

/* End of soapH.h */
