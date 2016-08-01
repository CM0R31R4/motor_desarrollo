
SQL*Plus: Release 11.2.0.3.0 Production on Tue Jun 18 15:00:20 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   Banenvbonis_Pkg IS

PROCEDURE BANEnvBonis
(  SRV_Message		   IN OUT VARCHAR2,
	In_extCodFinanciador  			IN NUMBER,
	In_extHomNumeroConvenio 	IN VARCHAR2,
	In_extHomLugarConvenio 		IN VARCHAR2,
	In_extSucVenta	 		IN VARCHAR2,
	InextRutConvenio 		IN VARCHAR2,
	InextRutAsociado 		IN VARCHAR2,
	In_extNomPrestador 		IN VARCHAR2,
	InextRutTratante 		IN VARCHAR2,
	In_extEspecialidad 		IN VARCHAR2,
	InextRutBeneficiario 		IN VARCHAR2,
	InextRutCotizante 		IN VARCHAR2,
	InextRutAcompanante 		IN VARCHAR2,
	InextRutEmisor 			IN VARCHAR2,
	InextRutCajero 			IN VARCHAR2,
	In_extCodigoDiagnostico		IN VARCHAR2,
	In_extDescuentoxPlanilla	IN VARCHAR2,
	In_extMontoExcedente			IN NUMBER,
	In_extFechaEmision		IN DATE
	In_extNivelConvenio			IN NUMBER,
	In_extFolioFinanciador			IN NUMBER,
	In_extMontoValorTotal			IN NUMBER,
	In_extMontoAporteTotal			IN NUMBER,
	In_extMontoCopagoTotal			IN NUMBER,
	In_extNumOperacion			IN NUMBER,
	In_extCorrPrestacion			IN NUMBER,
	In_extTipoSolicitud			IN NUMBER,
	In_extFechaInicio		IN DATE,
	In_extUrgencia			IN VARCHAR2,
	In_extPlan			IN VARCHAR2,
	In_extLista1			IN VARCHAR2,
	In_extLista2			IN VARCHAR2,
	In_extLista3			IN VARCHAR2,
	Out_extCodError			OUT VARCHAR2,
	Out_extMensajeError		OUT VARCHAR2
);
-- Fin EnvBono

END Banenvbonis_Pkg;

42 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
