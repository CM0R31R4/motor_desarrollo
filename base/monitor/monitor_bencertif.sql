DROP FUNCTION monitor_bencertif(varchar);
/*
CREATE OR REPLACE FUNCTION monitor_bencertif(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	stDefSec        define_secuencia_ws%ROWTYPE;
	id_tr1		integer;
	tipo_tx1	varchar;
	nro_intento1	integer;
	req		varchar;
	ip1		varchar;
	port1		varchar;
	head		varchar;
	msj_rqt1	varchar;
	cDefSec		cursor for select * from define_secuencia_ws where tipo_tx = tipo_tx1 and financiador='67';

Begin

	xml2		:= xml1;

	tipo_tx1	:=get_campo('TIPO_TX',xml2);
	id_tr1		:=get_campo('ID_TX',xml2);

	select coalesce(max(nro_intento),1) 
	into nro_intento1 
	from tx_monitor_sla 
	where id_tx=id_tr1
	  and tipo_tx = tipo_tx1;

	open cDefSec;
	loop
	
		fetch cDefSec into stDefSec;
		exit when not found;

		ip1             := '10.100.32.177';
		port1           := '80'||stDefSec.financiador;

		req		:= '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.imed.bono3.motor.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ws:bencertif>
         <extCodFinanciador>'||stDefSec.financiador||'</extCodFinanciador>
         <extRutBeneficiario>0011223574-4</extRutBeneficiario>
         <extFechaActual>'||to_char(now(),'YYYYMMDD')||'</extFechaActual>
      </ws:bencertif>
   </soapenv:Body>
</soapenv:Envelope>';
		
		msj_rqt1	:='POST http://'||ip1||':'||port1||'/WSIMedBono/services/BENCERTIFPort HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: text/xml;charset=UTF-8
SOAPAction: ""
User-Agent: Jakarta Commons-HttpClient/3.1
Host: '||ip1||':'||port1||'
Content-Length: '||length(req)||'

'||req;

		insert into tx_monitor_sla(id_tx,tipo_tx,financiador,nro_intento,msj_rqt,ip,port)
		values(id_tr1,tipo_tx1,stDefSec.financiador,nro_intento1,msj_rqt1,ip1,port1);

	END LOOP;

	return xml2;

end;
$$
LANGUAGE plpgsql;
*/
