delete from isys_querys_tx where llave='3020';

-- Preprar Datos 
insert into isys_querys_tx values ('3020',10,1,1,'SELECT procesar_3020(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);
-- Consumir WS

/*
100,'INPUT','CAMPO',-1,10
101,'RESPUESTA','CAMPO',-1,10,'HEX2ASC'
--Para el Listener, con isys_tx_formatos
103,'RESPUESTA','CAMPO',-1,10
110,'SQLINPUT','CAMPO',-1,10
111,'SQLOUTPUT','CAMPO',-1,10
112,'SQLOUTPUT','CAMPO',-1,10,'ASC2HEX'
200,'RQT_XML','CAMPO',-1,10
201,'RSP_XML','CAMPO',-1,10
4000,'INPUT_CIA','CAMPO',-1,10,'HEX2ASC'
4001,'RESPUESTA_CIA','CAMPO',-1,10
*/

insert into isys_querys_tx values ('3020',20,1,2,'Ws Generico',3021,100,111,1,1,30,30);   --Llama un servicio de tabla servicios
-- Revisar Datos
insert into isys_querys_tx values ('3020',30,1,1,'SELECT proc_revisa_3020(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

CREATE OR REPLACE FUNCTION procesar_3020(varchar)
returns varchar as
$$
Declare
        xml1            alias for $1;
        xml2            varchar;
	resp		varchar;
	tipo_tx1	varchar;
	id_tr1          varchar;
	stmonitor	tx_monitor_sla%rowtype;

Begin
	xml2	:=xml1;

	xml2	:=get_parametros(xml2); 
	tipo_tx1:=get_campo('TIPO_TX',xml2);

	id_tr1 	:= get_campo('ID_TX',xml2);

	if id_tr1 = ''  then
		-- Primera Vez

		id_tr1  :=nextval('s_monitor_sla')::varchar;
        	xml2    :=put_campo(xml2,'ID_TX',id_tr1::varchar);

		-- Configurar Cada Monitor
		EXECUTE 'SELECT ' || 'monitor_'||tipo_tx1 || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
	end if;

	-- Loop
	select * 
	into stmonitor 
	from tx_monitor_sla 
	where id_tx = id_tr1::integer 
		and tipo_tx = tipo_tx1
		and fecha_in_tx is null 
	limit 1;

	xml2    :=put_campo(xml2,'__IP_CONEXION_CLIENTE__',stmonitor.ip);
	xml2    :=put_campo(xml2,'INPUT',stmonitor.msj_rqt);
	xml2    :=put_campo(xml2,'__IP_PORT_CLIENTE__',stmonitor.port);
	xml2	:=put_campo(xml2,'FINANCIADOR',stmonitor.financiador::varchar);
	xml2    :=put_campo(xml2,'NRO_INTENTO',stmonitor.nro_intento::varchar);

	update tx_monitor_sla
	set fecha_in_tx = now(),
               estado = 'EN PROCESO'
	where id_tx = stmonitor.id_tx 
		and tipo_tx = stmonitor.tipo_tx 
		and financiador = stmonitor.financiador 
		and nro_intento = stmonitor.nro_intento;

	xml2    :=put_campo(xml2,'__SECUENCIAOK__','20');

	--xml2    :=put_campo(xml2,'RESPUESTA',id_tr1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION proc_revisa_3020(varchar)
returns varchar as
$$
Declare
        xml1            alias for $1;
        xml2            varchar;
        resp            varchar;
        tipo_tx1        varchar;
        id_tr1          varchar;
        stmonitor       tx_monitor_sla%rowtype;
	financiador1	varchar;
	intento1	varchar;
	rsp		varchar;
	contador	integer;

Begin
        xml2    	:=xml1;
	tipo_tx1 	:=get_campo('TIPO_TX',xml2);
	id_tr1	 	:=get_campo('ID_TX',xml2);
	financiador1	:=get_campo('FINANCIADOR',xml2);
	intento1	:=get_campo('NRO_INTENTO',xml2);
	rsp		:=get_campo('SQLOUTPUT',xml2);

	-- Prepara Salida

 	update tx_monitor_sla
        set fecha_out_tx = now(),
               estado = 'TERMINADO',
		msj_rsp = rsp
        where id_tx = id_tr1::integer 
		and tipo_tx = tipo_tx1 
		and financiador = financiador1::integer 
		and nro_intento = intento1::integer;

	select count(*)
	into contador
	from tx_monitor_sla
	 where id_tx = id_tr1::integer
                and tipo_tx = tipo_tx1
		and fecha_in_tx is null;

	if contador > 0 then
		 xml2          :=put_campo(xml2,'__SECUENCIAOK__','10');
	else
		 xml2          :=put_campo(xml2,'__SECUENCIAOK__','0');	

	end if;	

	resp  	:= '<a>TERMINO MONITOR '||id_tr1||'</a>';

        resp    :='Status: 200 OK'||chr(10)||
                'Content-type: application/xml;charset=UTF-8;'||chr(10)||
                'Content-length: '||length(resp)||
                chr(10)||chr(10)||resp;

        xml2    :=put_campo(xml2,'RESPUESTA',resp);

        return xml2;
end;
$$
LANGUAGE plpgsql;
