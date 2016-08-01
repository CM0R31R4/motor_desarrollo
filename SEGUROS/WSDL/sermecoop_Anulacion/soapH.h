/* soapH.h
   Generated by gSOAP 2.8.7 from Anulacion_sermecoop.h

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
#define SOAP_TYPE_SOAP_ENV__Fault (21)
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
#define SOAP_TYPE_SOAP_ENV__Reason (20)
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
#define SOAP_TYPE_SOAP_ENV__Detail (17)
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
#define SOAP_TYPE_SOAP_ENV__Code (15)
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
#define SOAP_TYPE_SOAP_ENV__Header (14)
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

#ifndef SOAP_TYPE_ns1__wmImed_USCORESrvAnulacion_
#define SOAP_TYPE_ns1__wmImed_USCORESrvAnulacion_ (13)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_ns1__wmImed_USCORESrvAnulacion_(struct soap*, struct ns1__wmImed_USCORESrvAnulacion_ *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_ns1__wmImed_USCORESrvAnulacion_(struct soap*, const struct ns1__wmImed_USCORESrvAnulacion_ *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_ns1__wmImed_USCORESrvAnulacion_(struct soap*, const char*, int, const struct ns1__wmImed_USCORESrvAnulacion_ *, const char*);
SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacion_ * SOAP_FMAC4 soap_in_ns1__wmImed_USCORESrvAnulacion_(struct soap*, const char*, struct ns1__wmImed_USCORESrvAnulacion_ *, const char*);

#ifndef soap_write_ns1__wmImed_USCORESrvAnulacion_
#define soap_write_ns1__wmImed_USCORESrvAnulacion_(soap, data) ( soap_begin_send(soap) || (soap_serialize_ns1__wmImed_USCORESrvAnulacion_(soap, data), 0) || soap_put_ns1__wmImed_USCORESrvAnulacion_(soap, data, "ns1:wmImed_SrvAnulacion", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_ns1__wmImed_USCORESrvAnulacion_(struct soap*, const struct ns1__wmImed_USCORESrvAnulacion_ *, const char*, const char*);

#ifndef soap_read_ns1__wmImed_USCORESrvAnulacion_
#define soap_read_ns1__wmImed_USCORESrvAnulacion_(soap, data) ( soap_begin_recv(soap) || !soap_get_ns1__wmImed_USCORESrvAnulacion_(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacion_ * SOAP_FMAC4 soap_get_ns1__wmImed_USCORESrvAnulacion_(struct soap*, struct ns1__wmImed_USCORESrvAnulacion_ *, const char*, const char*);

#ifndef SOAP_TYPE_ns1__wmImed_USCORESrvAnulacion_Response
#define SOAP_TYPE_ns1__wmImed_USCORESrvAnulacion_Response (12)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_ns1__wmImed_USCORESrvAnulacion_Response(struct soap*, struct ns1__wmImed_USCORESrvAnulacion_Response *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_ns1__wmImed_USCORESrvAnulacion_Response(struct soap*, const struct ns1__wmImed_USCORESrvAnulacion_Response *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_ns1__wmImed_USCORESrvAnulacion_Response(struct soap*, const char*, int, const struct ns1__wmImed_USCORESrvAnulacion_Response *, const char*);
SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacion_Response * SOAP_FMAC4 soap_in_ns1__wmImed_USCORESrvAnulacion_Response(struct soap*, const char*, struct ns1__wmImed_USCORESrvAnulacion_Response *, const char*);

#ifndef soap_write_ns1__wmImed_USCORESrvAnulacion_Response
#define soap_write_ns1__wmImed_USCORESrvAnulacion_Response(soap, data) ( soap_begin_send(soap) || (soap_serialize_ns1__wmImed_USCORESrvAnulacion_Response(soap, data), 0) || soap_put_ns1__wmImed_USCORESrvAnulacion_Response(soap, data, "ns1:wmImed_SrvAnulacion-Response", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_ns1__wmImed_USCORESrvAnulacion_Response(struct soap*, const struct ns1__wmImed_USCORESrvAnulacion_Response *, const char*, const char*);

#ifndef soap_read_ns1__wmImed_USCORESrvAnulacion_Response
#define soap_read_ns1__wmImed_USCORESrvAnulacion_Response(soap, data) ( soap_begin_recv(soap) || !soap_get_ns1__wmImed_USCORESrvAnulacion_Response(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacion_Response * SOAP_FMAC4 soap_get_ns1__wmImed_USCORESrvAnulacion_Response(struct soap*, struct ns1__wmImed_USCORESrvAnulacion_Response *, const char*, const char*);

#ifndef SOAP_TYPE_ns1__wmImed_USCORESrvAnulacionResponse
#define SOAP_TYPE_ns1__wmImed_USCORESrvAnulacionResponse (8)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_ns1__wmImed_USCORESrvAnulacionResponse(struct soap*, struct ns1__wmImed_USCORESrvAnulacionResponse *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_ns1__wmImed_USCORESrvAnulacionResponse(struct soap*, const struct ns1__wmImed_USCORESrvAnulacionResponse *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_ns1__wmImed_USCORESrvAnulacionResponse(struct soap*, const char*, int, const struct ns1__wmImed_USCORESrvAnulacionResponse *, const char*);
SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacionResponse * SOAP_FMAC4 soap_in_ns1__wmImed_USCORESrvAnulacionResponse(struct soap*, const char*, struct ns1__wmImed_USCORESrvAnulacionResponse *, const char*);

#ifndef soap_write_ns1__wmImed_USCORESrvAnulacionResponse
#define soap_write_ns1__wmImed_USCORESrvAnulacionResponse(soap, data) ( soap_begin_send(soap) || (soap_serialize_ns1__wmImed_USCORESrvAnulacionResponse(soap, data), 0) || soap_put_ns1__wmImed_USCORESrvAnulacionResponse(soap, data, "ns1:wmImed_SrvAnulacionResponse", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_ns1__wmImed_USCORESrvAnulacionResponse(struct soap*, const struct ns1__wmImed_USCORESrvAnulacionResponse *, const char*, const char*);

#ifndef soap_read_ns1__wmImed_USCORESrvAnulacionResponse
#define soap_read_ns1__wmImed_USCORESrvAnulacionResponse(soap, data) ( soap_begin_recv(soap) || !soap_get_ns1__wmImed_USCORESrvAnulacionResponse(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacionResponse * SOAP_FMAC4 soap_get_ns1__wmImed_USCORESrvAnulacionResponse(struct soap*, struct ns1__wmImed_USCORESrvAnulacionResponse *, const char*, const char*);

#ifndef SOAP_TYPE_ns1__wmImed_USCORESrvAnulacion
#define SOAP_TYPE_ns1__wmImed_USCORESrvAnulacion (7)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_default_ns1__wmImed_USCORESrvAnulacion(struct soap*, struct ns1__wmImed_USCORESrvAnulacion *);
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_ns1__wmImed_USCORESrvAnulacion(struct soap*, const struct ns1__wmImed_USCORESrvAnulacion *);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_ns1__wmImed_USCORESrvAnulacion(struct soap*, const char*, int, const struct ns1__wmImed_USCORESrvAnulacion *, const char*);
SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacion * SOAP_FMAC4 soap_in_ns1__wmImed_USCORESrvAnulacion(struct soap*, const char*, struct ns1__wmImed_USCORESrvAnulacion *, const char*);

#ifndef soap_write_ns1__wmImed_USCORESrvAnulacion
#define soap_write_ns1__wmImed_USCORESrvAnulacion(soap, data) ( soap_begin_send(soap) || (soap_serialize_ns1__wmImed_USCORESrvAnulacion(soap, data), 0) || soap_put_ns1__wmImed_USCORESrvAnulacion(soap, data, "ns1:wmImed_SrvAnulacion", NULL) || soap_end_send(soap) )
#endif


SOAP_FMAC3 int SOAP_FMAC4 soap_put_ns1__wmImed_USCORESrvAnulacion(struct soap*, const struct ns1__wmImed_USCORESrvAnulacion *, const char*, const char*);

#ifndef soap_read_ns1__wmImed_USCORESrvAnulacion
#define soap_read_ns1__wmImed_USCORESrvAnulacion(soap, data) ( soap_begin_recv(soap) || !soap_get_ns1__wmImed_USCORESrvAnulacion(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacion * SOAP_FMAC4 soap_get_ns1__wmImed_USCORESrvAnulacion(struct soap*, struct ns1__wmImed_USCORESrvAnulacion *, const char*, const char*);

#ifndef WITH_NOGLOBAL

#ifndef SOAP_TYPE_PointerToSOAP_ENV__Reason
#define SOAP_TYPE_PointerToSOAP_ENV__Reason (23)
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
#define SOAP_TYPE_PointerToSOAP_ENV__Detail (22)
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
#define SOAP_TYPE_PointerToSOAP_ENV__Code (16)
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

#ifndef SOAP_TYPE_PointerTostring
#define SOAP_TYPE_PointerTostring (10)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_PointerTostring(struct soap*, char **const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_PointerTostring(struct soap*, const char *, int, char **const*, const char *);
SOAP_FMAC3 char *** SOAP_FMAC4 soap_in_PointerTostring(struct soap*, const char*, char ***, const char*);

#ifndef soap_write_PointerTostring
#define soap_write_PointerTostring(soap, data) ( soap_begin_send(soap) || (soap_serialize_PointerTostring(soap, data), 0) || soap_put_PointerTostring(soap, data, "byte", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_PointerTostring(struct soap*, char **const*, const char*, const char*);

#ifndef soap_read_PointerTostring
#define soap_read_PointerTostring(soap, data) ( soap_begin_recv(soap) || !soap_get_PointerTostring(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 char *** SOAP_FMAC4 soap_get_PointerTostring(struct soap*, char ***, const char*, const char*);

#ifndef SOAP_TYPE_PointerTons1__wmImed_USCORESrvAnulacion
#define SOAP_TYPE_PointerTons1__wmImed_USCORESrvAnulacion (9)
#endif
SOAP_FMAC3 void SOAP_FMAC4 soap_serialize_PointerTons1__wmImed_USCORESrvAnulacion(struct soap*, struct ns1__wmImed_USCORESrvAnulacion *const*);
SOAP_FMAC3 int SOAP_FMAC4 soap_out_PointerTons1__wmImed_USCORESrvAnulacion(struct soap*, const char *, int, struct ns1__wmImed_USCORESrvAnulacion *const*, const char *);
SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacion ** SOAP_FMAC4 soap_in_PointerTons1__wmImed_USCORESrvAnulacion(struct soap*, const char*, struct ns1__wmImed_USCORESrvAnulacion **, const char*);

#ifndef soap_write_PointerTons1__wmImed_USCORESrvAnulacion
#define soap_write_PointerTons1__wmImed_USCORESrvAnulacion(soap, data) ( soap_begin_send(soap) || (soap_serialize_PointerTons1__wmImed_USCORESrvAnulacion(soap, data), 0) || soap_put_PointerTons1__wmImed_USCORESrvAnulacion(soap, data, "ns1:wmImed_SrvAnulacion", NULL) || soap_end_send(soap) )
#endif

SOAP_FMAC3 int SOAP_FMAC4 soap_put_PointerTons1__wmImed_USCORESrvAnulacion(struct soap*, struct ns1__wmImed_USCORESrvAnulacion *const*, const char*, const char*);

#ifndef soap_read_PointerTons1__wmImed_USCORESrvAnulacion
#define soap_read_PointerTons1__wmImed_USCORESrvAnulacion(soap, data) ( soap_begin_recv(soap) || !soap_get_PointerTons1__wmImed_USCORESrvAnulacion(soap, data, NULL, NULL) || soap_end_recv(soap) )
#endif

SOAP_FMAC3 struct ns1__wmImed_USCORESrvAnulacion ** SOAP_FMAC4 soap_get_PointerTons1__wmImed_USCORESrvAnulacion(struct soap*, struct ns1__wmImed_USCORESrvAnulacion **, const char*, const char*);

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
