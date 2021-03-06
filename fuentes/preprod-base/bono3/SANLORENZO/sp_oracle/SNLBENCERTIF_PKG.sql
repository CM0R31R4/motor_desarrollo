
SQL*Plus: Release 11.2.0.3.0 Production on Tue Jun 25 17:32:44 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> PROCEDURE FUSBENCERTIF
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTFECHAACTUAL		VARCHAR2		IN
 OUT_EXTAPELLIDOPAT		VARCHAR2		OUT
 OUT_EXTAPELLIDOMAT		VARCHAR2		OUT
 OUT_EXTNOMBRES 		VARCHAR2		OUT
 OUT_EXTSEXO			VARCHAR2		OUT
 OUT_EXTFECHANACIMI		VARCHAR2		OUT
 OUT_EXTCODESTBEN		VARCHAR2		OUT
 OUT_EXTDESCESTADO		VARCHAR2		OUT
 OUT_EXTRUTCOTIZANTE		VARCHAR2		OUT
 OUT_EXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_EXTDIRPACIENTE		VARCHAR2		OUT
 OUT_EXTGLOSACOMUNA		VARCHAR2		OUT
 OUT_EXTGLOSACIUDAD		VARCHAR2		OUT
 OUT_EXTPREVISION		VARCHAR2		OUT
 OUT_EXTGLOSA			VARCHAR2		OUT
 OUT_EXTPLAN			VARCHAR2		OUT
 OUT_EXTDESCUENTOXPLANILLA	VARCHAR2		OUT
 OUT_EXTMONTOEXCEDENTE		NUMBER			OUT
 COL_EXTRUTACOMPANANTE		TABLE OF VARCHAR2(12)	OUT
 COL_EXTNOMBREACOMPANANTE	TABLE OF VARCHAR2(40)	OUT
PROCEDURE RBLBENCERTIF
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTFECHAACTUAL		VARCHAR2		IN
 OUT_EXTAPELLIDOPAT		VARCHAR2		OUT
 OUT_EXTAPELLIDOMAT		VARCHAR2		OUT
 OUT_EXTNOMBRES 		VARCHAR2		OUT
 OUT_EXTSEXO			VARCHAR2		OUT
 OUT_EXTFECHANACIMI		VARCHAR2		OUT
 OUT_EXTCODESTBEN		VARCHAR2		OUT
 OUT_EXTDESCESTADO		VARCHAR2		OUT
 OUT_EXTRUTCOTIZANTE		VARCHAR2		OUT
 OUT_EXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_EXTDIRPACIENTE		VARCHAR2		OUT
 OUT_EXTGLOSACOMUNA		VARCHAR2		OUT
 OUT_EXTGLOSACIUDAD		VARCHAR2		OUT
 OUT_EXTPREVISION		VARCHAR2		OUT
 OUT_EXTGLOSA			VARCHAR2		OUT
 OUT_EXTPLAN			VARCHAR2		OUT
 OUT_EXTDESCUENTOXPLANILLA	VARCHAR2		OUT
 OUT_EXTMONTOEXCEDENTE		NUMBER			OUT
 COL_EXTRUTACOMPANANTE		TABLE OF VARCHAR2(12)	OUT
 COL_EXTNOMBREACOMPANANTE	TABLE OF VARCHAR2(40)	OUT
PROCEDURE SNLBENCERTIF
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTFECHAACTUAL		VARCHAR2		IN
 OUT_EXTAPELLIDOPAT		VARCHAR2		OUT
 OUT_EXTAPELLIDOMAT		VARCHAR2		OUT
 OUT_EXTNOMBRES 		VARCHAR2		OUT
 OUT_EXTSEXO			VARCHAR2		OUT
 OUT_EXTFECHANACIMI		VARCHAR2		OUT
 OUT_EXTCODESTBEN		VARCHAR2		OUT
 OUT_EXTDESCESTADO		VARCHAR2		OUT
 OUT_EXTRUTCOTIZANTE		VARCHAR2		OUT
 OUT_EXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_EXTDIRPACIENTE		VARCHAR2		OUT
 OUT_EXTGLOSACOMUNA		VARCHAR2		OUT
 OUT_EXTGLOSACIUDAD		VARCHAR2		OUT
 OUT_EXTPREVISION		VARCHAR2		OUT
 OUT_EXTGLOSA			VARCHAR2		OUT
 OUT_EXTPLAN			VARCHAR2		OUT
 OUT_EXTDESCUENTOXPLANILLA	VARCHAR2		OUT
 OUT_EXTMONTOEXCEDENTE		NUMBER			OUT
 COL_EXTRUTACOMPANANTE		TABLE OF VARCHAR2(12)	OUT
 COL_EXTNOMBREACOMPANANTE	TABLE OF VARCHAR2(40)	OUT

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
