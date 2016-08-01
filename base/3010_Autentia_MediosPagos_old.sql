delete from isys_querys_tx where llave='3010';

insert into isys_querys_tx values ('3010',10,1,1,'SELECT traductor_in_mediospagos_3010(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);
insert into isys_querys_tx values ('3010',30,1,1,'SELECT traductor_out_mediospagos_3010(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--MULTICAJA(ConsumidorWS)
insert into isys_querys_tx values ('3010',100,1,2,'Multicaja_Ws',9001,100,201,1,1,30,30);   --Llama un servicio de tabla servicios

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION traductor_in_mediospagos_3010(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	stDefSec        define_secuencia_ws%ROWTYPE;
	cod_motor1	varchar;

	input1		varchar;	--Params.Req = Sesion.Sensor,"&",cRut,"&",Sesion.NombreOper,"&",Sesion.RutOper,"&",XmlOri,"&",NroAudit,"&";
	pc_key1		varchar;
	rut_clie1	varchar;
	nom_oper1	varchar;
	rut_oper1	varchar;
	xml_in1		varchar;
	nro_audit1	varchar;

	tipo_tx1	varchar;
	cod_lugar1	varchar;
	cod_resp1	varchar;
	msj_resp1	varchar;
	rqt_xml1	varchar;	
	header1		varchar;
	url1		varchar;
	host1		varchar;
	largo1		varchar;

	
begin
	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2:=put_campo(xml2,'CODIGO_RESP','');
	xml2:=put_campo(xml2,'MENSAJE_RESP','');
	xml2:=put_campo(xml2,'FECHA_IN_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	--Parsea Input. Formato 100
	input1	:=get_campo('INPUT',xml2);
	if length(input1)= 0 then
		return xml2;
	end if;
	
	--Parseo el Input
	pc_key1:=split_part(input1,'&',2);
	rut_clie1:=split_part(input1,'&',3);
	nom_oper1:=split_part(input1,'&',4);
	rut_oper1:=split_part(input1,'&',5);
	cod_lugar1:=split_part(input1,'&',6);
	xml_in1:=split_part(input1,'&',7);
	nro_audit1:=split_part(input1,'&',8);


	--Si hay Input, hay codigo motor
	-- Se modifica obtencion de codigo motor. | 06-10-2015 | Cambio realizado por C.M.
	--cod_motor1:=nextval('correlativo_motor')::varchar;
	cod_motor1:=genera_codmotor();
        xml2:=put_campo(xml2,'CODIGO_MOTOR',cod_motor1);	
        xml2:=put_campo(xml2,'COD_LUGAR',cod_lugar1);
        xml2:=put_campo(xml2,'PC_KEY',pc_key1);

	--xml2:=put_campo(xml2,'COD_LUGAR','13001');
        --xml2:=put_campo(xml2,'PC_KEY','{7173C2A9-65BC-0B49-AE39-4236F387EACF}');

        xml2:=put_campo(xml2,'NRO_AUDITORIA',nro_audit1);
	xml2:=put_campo(xml2,'RUT_CLIENTE',rut_clie1);
	xml2:=put_campo(xml2,'RUT_OPERADOR',rut_oper1);
        
	--Pasea el Xml del Cliente xml_in1
	xml2:=parser_xml(xml2,'<requerimiento>');
	
	tipo_tx1:=get_campo('TX_API',xml2);

        select * into stDefSec from define_secuencia_ws where tipo_tx=tipo_tx1 and financiador = '2';
        if not found then
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error: Tx_Api no definida en Tabla define_secuencia_ws');
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


	rqt_xml1 := get_campo('RQT_XML',xml2);

	url1 	:= 'https://200.111.44.187:8080/imed/ImedWebService';
	host1	:= '200.111.44.187:8080';

	header1	:='POST '||url1||' HTTP/1.1'||chr(10)||
		'Accept-Encoding: gzip,deflate'||chr(10)||
		'Content-Type: text/xml;charset=UTF-8'||chr(10)||
		'SOAPAction: ""'||chr(10)||
		'User-Agent: MotorIMed1.1'||chr(10)||
		'Content-Length: '||length(rqt_xml1)||chr(10)||
		'Authorization: Basic '|| encode('ImedWebRole:ImedWebRole','base64')||chr(10)||
		'Host: '||host1||chr(10)||
		chr(10);

	xml2:=put_campo(xml2,'INPUT',header1||rqt_xml1);
	xml2:=logapp(xml2,'XML2');

	xml2:=mediospagos_registra_tx(xml2);

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
	stData		respuestas_soap%ROWTYPE;        
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
		-- respuesta1:=get_campo('CODIGO_MOTOR',xml2)||'&'||get_campo('RESPUESTA',xml2);
		respuesta1:=get_campo('RESPUESTA',xml2);
			
		xml2:=put_campo(xml2,'RESPUESTA',lpad(length(respuesta1)::varchar,4,'0') || respuesta1); 
		-- xml2:=put_campo(xml2,'RESPUESTA',respuesta1); 
	end if;

	xml2:=mediospagos_update_tx(xml2);

	return xml2;
end;
$$
LANGUAGE plpgsql;

