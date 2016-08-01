delete from isys_querys_tx where llave='3010';

--drop function traductor_in_autentia_3010(varchar); 
--drop function traductor_out_autentia_3010(varchar); 

insert into isys_querys_tx values ('3010',10,1,1,'SELECT traductor_in_mediospagos_3010(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);
insert into isys_querys_tx values ('3010',30,1,1,'SELECT traductor_out_mediospagos_3010(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--MULTICAJA(ConsumidorWS)
insert into isys_querys_tx values ('3010',100,1,2,'Multicaja_Ws',9001,200,201,1,1,30,30);   --Llama un servicio de tabla servicios

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION traductor_in_mediospagos_3010(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	cod_motor1	varchar;
	stDefSec        bono3.define_secuencia_ws%ROWTYPE;

	input1		varchar;	--Params.Req = Sesion.Sensor,"&",cRut,"&",Sesion.NombreOper,"&",Sesion.RutOper,"&",XmlOri,"&",NroAudit,"&";
	sensor1		varchar;
	rut_clie1	varchar;
	nom_oper1	varchar;
	rut_oper1	varchar;
	xml_in1		varchar;
	nro_audit1	varchar;

	tipo_tx1	varchar;
	cod_lugar1	varchar;
	cod_resp1	varchar;
	msj_resp1	varchar;
	
	
begin
	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2:=put_campo(xml2,'CODIGO_RESP','');
	xml2:=put_campo(xml2,'MENSAJE_RESP','');
	xml2:=put_campo(xml2,'FECHA_IN_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	--xml2 := put_campo(xml2,'TX','7080'); --Tx definida en Iswitch para multicaja

	--Parsea Input. Formato 100
	input1	:=get_campo('INPUT',xml2);
	--input1  :=replace(get_campo('INPUT',xml2),chr(13),'');
	if length(input1)= 0 then
		return xml2;
	end if;

	--<INPUT=342>
	--0338{DFC1546C-39E9-C947-A724-1A399692C8B6}&0013915583-1&COSSIO CRISTIA, JAIME&0013915583-1&<?xml version="1.0"encoding="UTF-8"?><requerimiento><TX_API>ISW_VERIDERECHO</TX_API><PC_KEY>PC_KEY</PC_KEY><COD_LUGAR>1500</COD_LUGAR><RUT_TITULAR>13915583</RUT_TITULAR><MONTO>1000</MONTO><VERSION>2.0</VERSION></requerimiento>&BONO-A29K-FCHM-5GA5&
	
	--Parseo el Input
	sensor1:=split_part(input1,'&',1);
	rut_clie1:=split_part(input1,'&',2);
	nom_oper1:=split_part(input1,'&',3);
	rut_oper1:=split_part(input1,'&',4);
	xml_in1:=split_part(input1,'&',5);
	nro_audit1:=split_part(input1,'&',6);

	--Si hay Input, hay codigo motor
	cod_motor1:=nextval('correlativo_motor')::varchar;
        xml2:=put_campo(xml2,'CODIGO_MOTOR',cod_motor1);

	--Pasea el Xml del Cliente xml_in1
	xml2:=parser_xml(xml2,'<requerimiento>');
	
	--tipo_tx1:=get_tag_xml('<TX_API>',data_in_xml1);
	tipo_tx1:=get_campo('TX_API',xml2);

        select * into stDefSec from bono3.define_secuencia_ws where tipo_tx=tipo_tx1 and financiador = '2';
        if not found then
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error: Reintente Por Favor');
        end if;
	xml2:=put_campo(xml2,'FUNCION_OUTPUT',stDefSec.funcion_output);

        --Ejecuta funcion segun el Tx_Api.	
        if length(stDefSec.funcion_input)>0 then
                EXECUTE 'SELECT ' || stDefSec.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
		xml2:=put_campo(xml2,'__SECUENCIAOK__',stDefSec.secuencia::varchar);
        end if;

	--Parsea Respuesta. Si ES OK=Va a MC. Sino responde a Autentia con Error
	if length(get_campo('RQT_XML',xml2))=0 then
		xml2:=put_campo(xml2,'__SECUENCIAOK__','30');
	end if;			
	--xml2:=autentia_registra_tx(xml2);

	return xml2;	
end;
$$
LANGUAGE plpgsql;

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION traductor_out_mediospagos_3010(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
	xml2   		varchar;
	stData		bono3.respuestas_soap%ROWTYPE;
        
	tipo_tx1	varchar;
	respuesta1	varchar;
begin
	xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2	:=put_campo(xml2,'RQT_XML','CLEAR');
	--xml2	:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
	--xml2	:=put_campo(xml2,'CODIGO_RESP','');
	--xml2	:=put_campo(xml2,'MENSAJE_RESP','');
	xml2	:=put_campo(xml2,'FECHA_OUT_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));
	
	tipo_tx1:=get_campo('TX_API',xml2);

	if length(get_campo('FUNCION_OUTPUT',xml2))>0 then
                EXECUTE 'SELECT ' || get_campo('FUNCION_OUTPUT',xml2) || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
        end if;

	--Responde hacia Autentia -> Length + CodMotor + XML
	if length (get_campo('RESPUESTA',xml2))>0 then
		respuesta1:=get_campo('CODIGO_MOTOR',xml2)||'&'||get_campo('RESPUESTA',xml2);
			
		xml2:=put_campo(xml2,'RESPUESTA',lpad(length(respuesta1)::varchar,4,'0') ||'&'|| respuesta1); 
	end if;

	--xml2:=autentia_update_tx(xml2);

	return xml2;
end;
$$
LANGUAGE plpgsql;

