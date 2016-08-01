
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:33 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE CALL_BANVALORIZI

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Procedure	     Call_Banvalorizi IS
--
    SRV_Message 		VARCHAR2(250);
	extValorPrestacion 	   		NUMBER(12);
	extAporteFinanciador		NUMBER(12);
	extCopago 	   				NUMBER(12);
    extInternoIsa 				VARCHAR2(15);
--
    respuesta  					VARCHAR2(2000);
-- IN
	extCodFinanciador  			NUMBER(4);
	extHomNumeroConvenio 		VARCHAR2(15);
	extHomLugarConvenio 		VARCHAR2(15);
	extSucVenta   				VARCHAR2(15);
	extRutConvenio 				VARCHAR2(15);
	extRutTratante 				VARCHAR2(15);
	extEspecialidad 			VARCHAR2(15);
	extRutSolicitante 			VARCHAR2(15);
	extRutBeneficiario 			VARCHAR2(15);
	extTratamiento 				VARCHAR2(15);	-- N / S
	extCodigoDiagnostico		VARCHAR2(15);
	extNivelConvenio			NUMBER(1);		-- 1,2,3
	extUrgencia					VARCHAR2(1);	-- N / S
	extLista1					VARCHAR2(255);	-- '0000101001|A(2)|B(15)|C|D(2)|'
												-- AA: H=Honorario; P=Pabellon; A=Anestesia
												-- B : Decodificar factores ?
												-- C : Recargo Hora = S o N
												-- D : Cantidad
	extLista2					VARCHAR2(255);
	extLista3					VARCHAR2(255);
	extLista4					VARCHAR2(255);
	extLista5					VARCHAR2(255);
	extLista6					VARCHAR2(255);
	extNumPrestaciones			NUMBER(3);
-- OUT
	extCodError					VARCHAR2(1);	   -- N o S
	ext_MensajeError			VARCHAR2(255);
	extPlan						VARCHAR2(20);
	extGlosa1					VARCHAR2(50);
	extGlosa2					VARCHAR2(50);
	extGlosa3					VARCHAR2(50);
	extGlosa4					VARCHAR2(50);
	extGlosa5					VARCHAR2(50);
	Col_extValorPrestacion	    Banvalorizi_Pkg.extValorPrestacion_arr;
	Col_extAporteFinanciador    Banvalorizi_Pkg.extAporteFinanciador_arr;
	Col_extCopago  			 	Banvalorizi_Pkg.extCopago_arr;
	Col_extInternoIsa 		 	Banvalorizi_Pkg.extInternoIsa_arr;
	Col_extTipoBonif1 		 	Banvalorizi_Pkg.extTipoBonif1_arr;
	Col_extCopago1 			    Banvalorizi_Pkg.extCopago1_arr;
	Col_extTipoBonif2 		 	Banvalorizi_Pkg.extTipoBonif2_arr;
	Col_extCopago2 			 	Banvalorizi_Pkg.extCopago2_arr;
	Col_extTipoBonif3 		 	Banvalorizi_Pkg.extTipoBonif3_arr;
	Col_extCopago3 			 	Banvalorizi_Pkg.extCopago3_arr;
	Col_extTipoBonif4 		 	Banvalorizi_Pkg.extTipoBonif4_arr;
	Col_extCopago4 			 	Banvalorizi_Pkg.extCopago4_arr;
	Col_extTipoBonif5 		 	Banvalorizi_Pkg.extTipoBonif5_arr;
	Col_extCopago5 			 	Banvalorizi_Pkg.extCopago5_arr;

Begin
--BANVALORIZI - ini 99 NC 81698900-0	  SC 17 	RI 0081698900-0 RT 0000000000-0 RS 0009252525-2 RB 0010201825-7
--NMPR >>1 L1 0001701009|CI|P000739	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 81698900-0	  SC 1		RI 0081698900-0 RT 0000000000-0 RS 0000000001-9 RB 0006550480-4
--NMPR >>1 L1 0000702009|  |0702009	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 50 	RI 0096617350-5 RT 0000000000-0 RS 0009252525-2 RB 0004524170-K
--NMPR >>36 L1 0000301068|  |0301068	    |N|01|0000302018|  |0302018        |N|01|0000302046|  |0302046	  |N|01|0000302076|  |0302076	     |N|01|0000303024|	|0303024	|N|01|0000305003|  |0305003	   |N|01|0000305048|  |0305048	      |N|01| L2 0000306018|  |0306018	     |N|01|0000306070|	|0306070	|N|01|0000308004|  |0308004	   |N|01|0000309007|  |0309007	      |N|01|0000301026|  |0301026	 |N|01|0000301069|  |0301069	    |N|01|0000302019|  |0302019        |N|01| L3 0000302047|  |0302047	      |N|01|0000303001|  |0303001	 |N|01|0000303025|  |0303025	    |N|01|0000305004|  |0305004        |N|01|0000305070|  |0305070	  |N|01|0000306021|  |0306021	     |N|01|0000306074|	|0306074	|N|01| L4 0000308005|  |0308005        |N|01|0000309008|  |0309008	  |N|01|0000301028|  |0301028	     |N|01|0000301024|	|0301024	|N|01|0000301067|  |0301067	   |N|01|0000302017|  |0302017	      |N|01|0000302045|  |0302045
  |N|01| L5 0000302075|  |0302075	 |N|01|0000303023|  |0303023	    |N|01|0000305001|  |0305001        |N|01|0000305041|  |0305041	  |N|01|0000306017|  |0306017	     |N|01|0000308001|	|0308001	|N|01|0000309006|  |0309006	   |N|01|

--BANVALORIZI - ini 99 NC 76398000-6	  SC 7		RI 0076398000-6 RT 0009830805-9 RS 0000000000-0 RB 0006850903-3
--NMPR >>1 L1 0000101001|  |0101001	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 92051000-6 SC 0 RI 0092051000-6 RT 0003101031-4 RS 0000000000-0 RB 0010477811-9
--NMPR >>1 L1 0000301045|  |0301045	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 61 	RI 0096617350-5 RT 0004940137-K RS 0000000000-0 RB 0010884665-8
--NMPR >>1 L1 0000101001|  |0101001	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 61 	RI 0096617350-5 RT 0005853326-2 RS 0000000000-0 RB 0014380661-8
--NMPR >>1 L1 0000101003|  |0101003	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 61 	RI 0096617350-5 RT 0005853326-2 RS 0000000000-0 RB 0014380661-8 ESP 1300
--NMPR >>1 L1 0000101001|  |0101001	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 61 	RI 0096617350-5 RT 0009292502-1 RS 0000000000-0 RB 0014380661-8 ESP 1353
--NMPR >>1 L1 0000101002|  |0101002	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 61 	RI 0096617350-5 RT 0000000000-0 RS 0006060863-6 RB 0005634529-9 ESP 4060
--NMPR >>8 L1 0000301045|  |0301045	   |N|01|0000301034|  |0301034	      |N|01|0000307011|  |0307011	 |N|01|0000401001|  |0401001	    |N|01|0000405008|  |0405008        |N|01|0000405003|  |0405003	  |N|01|0000404002|  |0404002	     |N|01|
--L2 0000403001|  |0403001	  |N|01| L3  L4  L5
--BANVALORIZI - ini 99 NC 96631140-1	  SC 0		RI 0096631140-1 RT 0000000000-0 RS 0006060863-6 RB 0010853319-6 ESP 1180
--NMPR >>3 L1 0001602206|CI|		   |N|02|0001602206|AN| 	      |N|02|0001602206|DP|		 |N|02| L2  L3	L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 51       RI 0096617350-5 RT 0011750484-0 RS 0000000000-0 RB 0011133383-1
--NMPR >>3 L1 0000101003|  |0101003	   |N|01|0000101001|  |0101001	      |N|01|0000101002|  |0101002	 |N|01| L2  L3	L4  L5
--BANVALORIZI - ini 99 NC 90753000-0	  SC 0		RI 0090753000-0 RT 0000000000-0 RS 0006060863-6 RB 0009909695-0
--NMPR >>1 L1 0000301045|  |0301045	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 55 	RI 0096617350-5 RT 0000000000-0 RS 0014710858-3 RB 0012422416-0
--NMPR >>5 L1 0000601001|  |0601001	   |N|02|0000601009|  |0601009	      |N|10|0000601011|  |0601011	 |N|10|0000601012|  |0601012	    |N|10|0000601024|  |0601024        |N|10| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 76696200-9	  SC 0		RI 0076696200-9 RT 0000000000-0 RS 0006060863-6 RB 0007017269-0 ESP 4060
--NMPR >>1 L1 0000401001|  |0401001	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 50 	RI 0096617350-5 RT 0000000000-0 RS 0006060863-6 RB 0012871635-1 ESP 4060
--NMPR >>1 L1 0000301045|  |0301045	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5 SC 55 RI 0096617350-5 RT 0000000000-0 RS 0014710858-3 RB 0012422416-0 ESP 4060
--NMPR >>5 L1 0000601001|  |0601001	   |N|02|0000601009|  |0601009	      |N|10|0000601011|  |0601011	 |N|10|0000601012|  |0601012	    |N|10|0000601024|  |0601024        |N|10| L2  L3  L4  L5
--BANVALORVARI - ini 99 NC 76398000-6 SC 7 RI 0076398000-6 RT 0013465406-6 RS 0000000000-0 RB 0004232461-2
--NMPR >>1 L1 0000901001|  |0901001	   |N|01|000000000000| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 77200240-8	  SC 0		RI 0077200240-8 RT 0077200240-8 RS 0010714277-0 RB 0017033071-4
--NMPR >>1 L1 0000401054|  |0401054	   |S|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 96617350-5	  SC 70 	RI 0096617350-5 RT 0006472875-K RS 0000000000-0 RB 0014739172-2
--NMPR >>1 L1 0000101003|  |0101003	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 76481620-K	  SC 0		RI 0076481620-K RT 0004398417-9 RS 0000000000-0 RB 0010201825-7
--NMPR >>1 L1 0000101003|  |1520-1	   |N|01| L2  L3  L4  L5
--BANVALORIZI - ini 99 NC 81698900-0	  SC 35 	RI 0081698900-0 RT 0000000000-0 RS 0009252525-2 RB 0004281564-0 URG N
--NMPR >>1 L1 0000301045|  |0301045	   |N|01| L2  L3  L4  L5
--BANVALORVARI - ini 99 NC 5633436-K	   SC 0 	 RI 0005633436-K RT 0000000000-0 RS 0005633436-K RB 0016303678-9 URG N ESP
--NMPR >>3 L1 0001602205|CI|1602205	   |N|01|0001602205|AN|1602205	      |N|01|0001602205|DP|1602205	 |N|01|
   SRV_Message := '';
   extHomNumeroConvenio := '5633436-K'; --10001-3';
   extHomLugarConvenio 	:= '0';--'53';
   extRutConvenio 		:= '0005633436-K';
   extSucVenta	 		:= '333';
   extRutTratante 		:= '0000000000-0'; --'0011750484-0';
   extEspecialidad 		:= '4060';
   extRutSolicitante 	:= '0005633436-K';
   extRutBeneficiario 	:= '0016303678-9';--'0009977999-3'; --'0011133383-1'; --'0011953227-2'; --'0005634529-9';
   extTratamiento 		:= 'N';
   extCodigoDiagnostico	:= 'R68.8';
   extNivelConvenio		:= 1;		-- 1,2,3
   extUrgencia			:= 'N'; 	-- N / S
   extLista1 := '0001602205|CI|1602205	      |N|01|0001602205|AN|1602205	 |N|01|0001602205|DP|1602205	    |N|01|';
   extLista2 := '';
   extLista3 := '';
   extLista4 := '';
   extLista5 := '';
   extLista6 := '';
   extCodFinanciador  	:=  99;
   extNumPrestaciones := 3;
dbms_output.put_line('[paso 1] '||TO_CHAR(SYSDATE,'dd-mm-yyyy hh24:mi:ss'));
 	Banvalorizi_Pkg.BanValorizi
	     ( SRV_Message,
		  	 extCodFinanciador,
		  	 extHomNumeroConvenio,
		  	 extHomLugarConvenio,
		  	 extSucVenta,
		  	 extRutConvenio,
		  	 extRutTratante,
		  	 extEspecialidad,
		 	 extRutSolicitante,
		  	 extRutBeneficiario,
		  	 extTratamiento,
		  	 extCodigoDiagnostico,
		  	 extNivelConvenio,
		  	 extUrgencia,
		  	 extLista1,
		  	 extLista2,
		  	 extLista3,
		  	 extLista4,
		  	 extLista5,
		  	 extLista6,
		  	 extNumPrestaciones,
		  	 extCodError,
		  	 ext_MensajeError,
		  	 extPlan,
		  	 extGlosa1,
		  	 extGlosa2,
		  	 extGlosa3,
		  	 extGlosa4,
		  	 extGlosa5
		  	,Col_extValorPrestacion
  		  	,Col_extAporteFinanciador
  		  	,Col_extCopago
  		  	,Col_extInternoIsa
  		  	,Col_extTipoBonif1
  		  	,Col_extCopago1
  		  	,Col_extTipoBonif2
  		  	,Col_extCopago2
  		  	,Col_extTipoBonif3
  		  	,Col_extCopago3
  		  	,Col_extTipoBonif4
  		  	,Col_extCopago4
  		  	,Col_extTipoBonif5
  		  	,Col_extCopago5
	     );
Commit;
	respuesta := extCodError||'#'||
			  	 ext_MensajeError||'#'||
				 extPlan  ||'#'||
				 extGlosa1||'#'||
				 extGlosa2||'#'||
				 extGlosa3||'#'||
				 extGlosa4||'#'||
				 extGlosa5;

 	dbms_output.put_line('> < ' || respuesta);
	If extCodError = 'N' THEN
	    dbms_output.put_line('Folio: ' || extInternoIsa);
	End If;
	dbms_output.put_line('[paso 2] '||TO_CHAR(SYSDATE,'dd-mm-yyyy hh24:mi:ss'));
End;

189 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
