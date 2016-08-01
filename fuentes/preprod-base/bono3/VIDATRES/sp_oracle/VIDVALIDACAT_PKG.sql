
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 18:07:07 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   Vidvalidacat_Pkg IS
/**********************************************************************************************
 DAM, 15/12/2003.
 Servicio para validar restricciones asociadas a cada codigo de prestacion ingresado
 al acto de ventas.Esta instancia de validacion esta orientada a la validacion de pertinencia
 de la prestacion (Ej. Prestacion valida para sexo del beneficiario).
**********************************************************************************************/
PROCEDURE VIDValidaCat(
  SRV_Message		    OUT VARCHAR2,
  extCodFinanciador  		IN NUMBER,
  extRutConvenio 			IN VARCHAR2,
  extRutTratante 			IN VARCHAR2,
  extRutSolicitante			IN VARCHAR2,
  extRutBeneficiario 		IN VARCHAR2,
  extRutCotizante 			IN VARCHAR2,
  extCodigoHomologo			IN VARCHAR2,
  extItem   			    IN VARCHAR2,
  extCodigoDiagnostico		IN VARCHAR2,
  extCodModalidad 		    IN VARCHAR2,   --codigo modalidad 01:Libre Eleccion, 02:???
  extCodTipAtencion 		IN VARCHAR2,   --codigo del tipo de atencion 01, 02.
  extFechaNacimiento		IN DATE,
  extCodSexo		    IN VARCHAR2,   --codigo del sexo 'F','M'
  extFechaInicio  		    IN DATE,
  extFechaTermino 		    IN DATE,
  extFrecPrestDia		    IN NUMBER,
  extListaPrestacA			IN VARCHAR2,	-- 7 substrings de 33 carac. c/u. donde :
					    -- 10 para el codigo homologo,1 para el pipe,
											--  2 para el item, 1 para el pipe,
											--  2 para la cantidad, 1 para el pipe,
											-- 15 para el codigo adicional, 1 para le pipe
											-- '0000101001|00|01|000000000054780|'
  extListaPrestacB			IN VARCHAR2,
  extListaPrestacC			IN VARCHAR2,
  extListaPrestacD			IN VARCHAR2,
  extListaPrestacE			IN VARCHAR2,
  extListaPrestacF			IN VARCHAR2,
  extIndVideo		    IN VARCHAR2,    --indicador de videolaparascopia : '0'
  extIndBilateral	    IN VARCHAR2,    --indicador de bilateralidad : '0'
  extRecargoFueraHora	    IN VARCHAR2,    --recargo fuera de horario : 'N','S'
  extIndReembolso	    IN VARCHAR2,    --Indicador de reembolso : 'N','S'
  extIndPrograma	    IN VARCHAR2,    --indicador si se genero desde un PAM : 'N','S'
  extCodAplicacion	    IN VARCHAR2,    --01:Venta directa,02:Pago Prestador,03:Facturacion,04:Venta innovadora
  extCodRegion		    IN VARCHAR2,
  extCodSucur		    IN VARCHAR2,
  extTipoPrestador	    IN VARCHAR2,    --Tipo prestador : 1:Institucion, 2:Persona Natural
  extCodEspecialidades	    IN VARCHAR2,
  extCodProfesiones	    IN VARCHAR2,
  extAnosAntiguedad	    IN VARCHAR2,
  Out_extRespuestaCAT		OUT VARCHAR2,
  Out_extMensajeCAT			OUT VARCHAR2
);
/******************************************************************************************
El parametro Out_extRespuestaCAT entrega 'S' o 'N' como resultado; y en el caso de ser 'N',
en el campo Out_extMensajeCAT viene un mensaje de texto con la explicacion a desplegar.
*******************************************************************************************/
-- Fin ValidaCat

END Vidvalidacat_Pkg;

58 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
