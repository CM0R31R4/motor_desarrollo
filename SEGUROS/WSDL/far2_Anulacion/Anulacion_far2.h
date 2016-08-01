/* Anulacion_far2.h
   Generated by wsdl2h 2.8.7 from http://10.27.11.60/Anulacion/Anulacion.asmx?wsdl and typemap.dat
   2014-06-30 16:07:05 GMT

   DO NOT INCLUDE THIS FILE DIRECTLY INTO YOUR PROJECT BUILDS
   USE THE soapcpp2-GENERATED SOURCE CODE FILES FOR YOUR PROJECT BUILDS

   gSOAP XML Web services tools.
   Copyright (C) 2001-2012 Robert van Engelen, Genivia Inc. All Rights Reserved.
   Part of this software is released under one of the following licenses:
   GPL or Genivia's license for commercial use.
*/

/** @page page_notes Usage Notes

NOTE:

 - Run soapcpp2 on Anulacion_far2.h to generate the SOAP/XML processing logic.
   Use soapcpp2 option -I to specify paths for #import
   To build with STL, 'stlvector.h' is imported from 'import' dir in package.
   Use soapcpp2 option -i to generate improved proxy and server classes.
 - Use wsdl2h options -c and -s to generate pure C code or C++ code without STL.
 - Use 'typemap.dat' to control namespace bindings and type mappings.
   It is strongly recommended to customize the names of the namespace prefixes
   generated by wsdl2h. To do so, modify the prefix bindings in the Namespaces
   section below and add the modified lines to 'typemap.dat' to rerun wsdl2h.
 - Use Doxygen (www.doxygen.org) on this file to generate documentation.
 - Use wsdl2h options -nname and -Nname to globally rename the prefix 'ns'.
 - Use wsdl2h option -d to enable DOM support for xsd:anyType.
 - Use wsdl2h option -g to auto-generate readers and writers for root elements.
 - Struct/class members serialized as XML attributes are annotated with a '@'.
 - Struct/class members that have a special role are annotated with a '$'.

WARNING:

   DO NOT INCLUDE THIS FILE DIRECTLY INTO YOUR PROJECT BUILDS.
   USE THE SOURCE CODE FILES GENERATED BY soapcpp2 FOR YOUR PROJECT BUILDS:
   THE soapStub.h FILE CONTAINS THIS CONTENT WITHOUT ANNOTATIONS.

LICENSE:

@verbatim
--------------------------------------------------------------------------------
gSOAP XML Web services tools
Copyright (C) 2000-2011, Robert van Engelen, Genivia Inc. All Rights Reserved.

This software is released under one of the following two licenses:
1) GPL or 2) Genivia's license for commercial use.
--------------------------------------------------------------------------------
1) GPL license.

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place, Suite 330, Boston, MA 02111-1307 USA

Author contact information:
engelen@genivia.com / engelen@acm.org

This program is released under the GPL with the additional exemption that
compiling, linking, and/or using OpenSSL is allowed.
--------------------------------------------------------------------------------
2) A commercial-use license is available from Genivia, Inc., contact@genivia.com
--------------------------------------------------------------------------------
@endverbatim

*/


//gsoapopt cw

/******************************************************************************\
 *                                                                            *
 * Definitions                                                                *
 *   http://tempuri.org/                                                      *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Import                                                                     *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Schema Namespaces                                                          *
 *                                                                            *
\******************************************************************************/

// This service uses SOAP 1.2 namespaces:
//gsoap SOAP-ENV schema namespace:	http://www.w3.org/2003/05/soap-envelope
//gsoap SOAP-ENC schema namespace:	http://www.w3.org/2003/05/soap-encoding

/* NOTE:

It is strongly recommended to customize the names of the namespace prefixes
generated by wsdl2h. To do so, modify the prefix bindings below and add the
modified lines to typemap.dat to rerun wsdl2h:

ns1 = "http://tempuri.org/"

*/

#define SOAP_NAMESPACE_OF_ns1	"http://tempuri.org/"
//gsoap ns1   schema namespace:	http://tempuri.org/
//gsoap ns1   schema elementForm:	qualified
//gsoap ns1   schema attributeForm:	unqualified

/******************************************************************************\
 *                                                                            *
 * Built-in Schema Types and Top-Level Elements and Attributes                *
 *                                                                            *
\******************************************************************************/



/******************************************************************************\
 *                                                                            *
 * Schema Types and Top-Level Elements and Attributes                         *
 *   http://tempuri.org/                                                      *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Schema Complex Types and Top-Level Elements                                *
 *   http://tempuri.org/                                                      *
 *                                                                            *
\******************************************************************************/



/// Top-level root element "http://tempuri.org/":wmImed_SrvAnulacion

/// "http://tempuri.org/":wmImed_SrvAnulacion is a complexType.
struct _ns1__wmImed_USCORESrvAnulacion
{
/// Element XML_INPUT of type xs:string.
    char*                                XML_USCOREINPUT                0;	///< Optional element.
};


/// Top-level root element "http://tempuri.org/":wmImed_SrvAnulacionResponse

/// "http://tempuri.org/":wmImed_SrvAnulacionResponse is a complexType.
struct _ns1__wmImed_USCORESrvAnulacionResponse
{
/// Element wmImed_SrvAnulacionResult of type xs:string.
    char*                                wmImed_USCORESrvAnulacionResult 0;	///< Optional element.
};

/******************************************************************************\
 *                                                                            *
 * Additional Top-Level Elements                                              *
 *   http://tempuri.org/                                                      *
 *                                                                            *
\******************************************************************************/


/// Top-level root element "http://tempuri.org/":string of type xs:string.
/// Note: use wsdl2h option -g to auto-generate a top-level root element declaration and processing code.

/******************************************************************************\
 *                                                                            *
 * Additional Top-Level Attributes                                            *
 *   http://tempuri.org/                                                      *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Services                                                                   *
 *                                                                            *
\******************************************************************************/


//gsoap ns2  service name:	AnulacionSoap 
//gsoap ns2  service type:	AnulacionSoap 
//gsoap ns2  service port:	http://10.27.11.60/Anulacion/Anulacion.asmx 
//gsoap ns2  service namespace:	http://tempuri.org/AnulacionSoap 
//gsoap ns2  service transport:	http://schemas.xmlsoap.org/soap/http 

//gsoap ns3  service name:	AnulacionSoap12 
//gsoap ns3  service type:	AnulacionSoap 
//gsoap ns3  service port:	http://10.27.11.60/Anulacion/Anulacion.asmx 
//gsoap ns3  service namespace:	http://tempuri.org/AnulacionSoap12 
//gsoap ns3  service transport:	http://schemas.xmlsoap.org/soap/http 

/** @mainpage Service Definitions

@section Service_bindings Service Bindings

  - @ref AnulacionSoap

  - @ref AnulacionSoap12

@section Service_more More Information

  - @ref page_notes "Usage Notes"

  - @ref page_XMLDataBinding "XML Data Binding"

  - @ref SOAP_ENV__Header "SOAP Header Content" (when applicable)

  - @ref SOAP_ENV__Detail "SOAP Fault Detail Content" (when applicable)


*/

/**

@page AnulacionSoap Binding "AnulacionSoap"

@section AnulacionSoap_operations Operations of Binding  "AnulacionSoap"

  - @ref __ns2__wmImed_USCORESrvAnulacion

@section AnulacionSoap_ports Endpoints of Binding  "AnulacionSoap"

  - http://10.27.11.60/Anulacion/Anulacion.asmx

Note: use wsdl2h option -N to change the service binding prefix name

*/

/**

@page AnulacionSoap12 Binding "AnulacionSoap12"

@section AnulacionSoap12_operations Operations of Binding  "AnulacionSoap12"

  - @ref __ns3__wmImed_USCORESrvAnulacion

@section AnulacionSoap12_ports Endpoints of Binding  "AnulacionSoap12"

  - http://10.27.11.60/Anulacion/Anulacion.asmx

Note: use wsdl2h option -N to change the service binding prefix name

*/

/******************************************************************************\
 *                                                                            *
 * Service Binding                                                            *
 *   AnulacionSoap                                                            *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Service Operation                                                          *
 *   __ns2__wmImed_USCORESrvAnulacion                                         *
 *                                                                            *
\******************************************************************************/


/// Operation "__ns2__wmImed_USCORESrvAnulacion" of service binding "AnulacionSoap"

/**

Operation details:


  - SOAP document/literal style messaging

  - SOAP action: "http://tempuri.org/wmImed_SrvAnulacion"

  - Addressing action: "http://tempuri.org//AnulacionSoap/wmImed_USCORESrvAnulacion"

  - Addressing response action: "http://tempuri.org//AnulacionSoap/wmImed_USCORESrvAnulacionResponse"

C stub function (defined in soapClient.c[pp] generated by soapcpp2):
@code
  int soap_call___ns2__wmImed_USCORESrvAnulacion(
    struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    struct _ns1__wmImed_USCORESrvAnulacion* ns1__wmImed_USCORESrvAnulacion,
    // response parameters:
    struct _ns1__wmImed_USCORESrvAnulacionResponse* ns1__wmImed_USCORESrvAnulacionResponse
  );
@endcode

C server function (called from the service dispatcher defined in soapServer.c[pp]):
@code
  int __ns2__wmImed_USCORESrvAnulacion(
    struct soap *soap,
    // request parameters:
    struct _ns1__wmImed_USCORESrvAnulacion* ns1__wmImed_USCORESrvAnulacion,
    // response parameters:
    struct _ns1__wmImed_USCORESrvAnulacionResponse* ns1__wmImed_USCORESrvAnulacionResponse
  );
@endcode

*/

//gsoap ns2  service method-style:	wmImed_USCORESrvAnulacion document
//gsoap ns2  service method-encoding:	wmImed_USCORESrvAnulacion literal
//gsoap ns2  service method-action:	wmImed_USCORESrvAnulacion http://tempuri.org/wmImed_SrvAnulacion
//gsoap ns2  service method-output-action:	wmImed_USCORESrvAnulacion http://tempuri.org//AnulacionSoap/wmImed_USCORESrvAnulacionResponse
int __ns2__wmImed_USCORESrvAnulacion(
    struct _ns1__wmImed_USCORESrvAnulacion* ns1__wmImed_USCORESrvAnulacion,	///< Request parameter
    struct _ns1__wmImed_USCORESrvAnulacionResponse* ns1__wmImed_USCORESrvAnulacionResponse	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * Service Binding                                                            *
 *   AnulacionSoap12                                                          *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Service Operation                                                          *
 *   __ns3__wmImed_USCORESrvAnulacion                                         *
 *                                                                            *
\******************************************************************************/


/// Operation "__ns3__wmImed_USCORESrvAnulacion" of service binding "AnulacionSoap12"

/**

Operation details:


  - SOAP document/literal style messaging

  - SOAP action: "http://tempuri.org/wmImed_SrvAnulacion"

  - Addressing action: "http://tempuri.org//AnulacionSoap/wmImed_USCORESrvAnulacion"

  - Addressing response action: "http://tempuri.org//AnulacionSoap/wmImed_USCORESrvAnulacionResponse"

C stub function (defined in soapClient.c[pp] generated by soapcpp2):
@code
  int soap_call___ns3__wmImed_USCORESrvAnulacion(
    struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    struct _ns1__wmImed_USCORESrvAnulacion* ns1__wmImed_USCORESrvAnulacion,
    // response parameters:
    struct _ns1__wmImed_USCORESrvAnulacionResponse* ns1__wmImed_USCORESrvAnulacionResponse
  );
@endcode

C server function (called from the service dispatcher defined in soapServer.c[pp]):
@code
  int __ns3__wmImed_USCORESrvAnulacion(
    struct soap *soap,
    // request parameters:
    struct _ns1__wmImed_USCORESrvAnulacion* ns1__wmImed_USCORESrvAnulacion,
    // response parameters:
    struct _ns1__wmImed_USCORESrvAnulacionResponse* ns1__wmImed_USCORESrvAnulacionResponse
  );
@endcode

*/

//gsoap ns3  service method-style:	wmImed_USCORESrvAnulacion document
//gsoap ns3  service method-encoding:	wmImed_USCORESrvAnulacion literal
//gsoap ns3  service method-action:	wmImed_USCORESrvAnulacion http://tempuri.org/wmImed_SrvAnulacion
//gsoap ns3  service method-output-action:	wmImed_USCORESrvAnulacion http://tempuri.org//AnulacionSoap/wmImed_USCORESrvAnulacionResponse
int __ns3__wmImed_USCORESrvAnulacion(
    struct _ns1__wmImed_USCORESrvAnulacion* ns1__wmImed_USCORESrvAnulacion,	///< Request parameter
    struct _ns1__wmImed_USCORESrvAnulacionResponse* ns1__wmImed_USCORESrvAnulacionResponse	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * XML Data Binding                                                           *
 *                                                                            *
\******************************************************************************/


/**

@page page_XMLDataBinding XML Data Binding

SOAP/XML services use data bindings contractually bound by WSDL and auto-
generated by wsdl2h and soapcpp2 (see Service Bindings). Plain data bindings
are adopted from XML schemas as part of the WSDL types section or when running
wsdl2h on a set of schemas to produce non-SOAP-based XML data bindings.

The following readers and writers are C/C++ data type (de)serializers auto-
generated by wsdl2h and soapcpp2. Run soapcpp2 on this file to generate the
(de)serialization code, which is stored in soapC.c[pp]. Include "soapH.h" in
your code to import these data type and function declarations. Only use the
soapcpp2-generated files in your project build. Do not include the wsdl2h-
generated .h file in your code.

XML content can be retrieved from:
  - a file descriptor, using soap->recvfd = fd
  - a socket, using soap->socket = ...
  - a C++ stream, using soap->is = ...
  - a buffer, using the soap->frecv() callback

XML content can be stored to:
  - a file descriptor, using soap->sendfd = fd
  - a socket, using soap->socket = ...
  - a C++ stream, using soap->os = ...
  - a buffer, using the soap->fsend() callback


@section ns1 Top-level root elements of schema "http://tempuri.org/"

  - <ns1:wmImed_SrvAnulacion> @ref _ns1__wmImed_USCORESrvAnulacion
    @code
    // Reader (returns SOAP_OK on success):
    soap_read__ns1__wmImed_USCORESrvAnulacion(struct soap*, struct _ns1__wmImed_USCORESrvAnulacion*);
    // Writer (returns SOAP_OK on success):
    soap_write__ns1__wmImed_USCORESrvAnulacion(struct soap*, struct _ns1__wmImed_USCORESrvAnulacion*);
    @endcode

  - <ns1:wmImed_SrvAnulacionResponse> @ref _ns1__wmImed_USCORESrvAnulacionResponse
    @code
    // Reader (returns SOAP_OK on success):
    soap_read__ns1__wmImed_USCORESrvAnulacionResponse(struct soap*, struct _ns1__wmImed_USCORESrvAnulacionResponse*);
    // Writer (returns SOAP_OK on success):
    soap_write__ns1__wmImed_USCORESrvAnulacionResponse(struct soap*, struct _ns1__wmImed_USCORESrvAnulacionResponse*);
    @endcode

  - <ns1:string> (use wsdl2h option -g to auto-generate)

*/

/* End of Anulacion_far2.h */
