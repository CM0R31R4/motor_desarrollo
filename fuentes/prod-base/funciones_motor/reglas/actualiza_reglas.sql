CREATE OR REPLACE FUNCTION control.mc_actualiza_master_acumuladores(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        data1   alias for $1;
        xml2            varchar;
        stMaster        control.master%ROWTYPE;
        stRegla         control.reglas%ROWTYPE;
        regla1  varchar;
        llave1  varchar;
        monto1  varchar;
        llave_busqueda1 varchar;
        campo   RECORD;
        aux     varchar;
        tipo_tx1        varchar;
        emisor1         varchar;
        control_acumulacion1    varchar;
begin
        xml2 :=  data1;
        tipo_tx1:=replace(get_campo('TIPO_TRX',xml2),' ','');
        emisor1 :=replace(get_campo('EMISOR',xml2),' ','');

        --aojeda.2012.12.20:hay trx que no traen emisor, por ejemplo una anulacion h2h cencosud de un codigo_mc de ven
ta erroneo..
        if length(tipo_tx1) = 0 or length(emisor1) = 0 then
                return xml2;
        end if;

        --raise notice 'tipo_tx1=% emisor1=%',tipo_tx1,emisor1;
        --Variable de control para verificar el orden de aplicacion de las reglas
        control_acumulacion1:='';
        --Solo selecciona segun el filtro de emisor y tipotx
        for campo in select * from control.reglas where
                (tx_incluidas       @@ (tipo_tx1||' | ALL')::tsquery and not (tx_no_incluidas       @@ tipo_tx1::tsque
ry)) and
                (emisores_incluidos @@ (emisor1 ||' | ALL')::tsquery and not (emisores_no_incluidos @@ emisor1::tsquer
y)) and
                length(funcion_acumulacion)>0 and estado='ACTIVO' order by prioridad
        loop
                --raise notice 'Aplica Regla=% tipo_tx1=% emisor1=%',campo.nombre_regla,tipo_tx1,emisor1;
                control_acumulacion1:=control_acumulacion1||','||campo.nombre_regla;

                --Si la regla tiene validacion de error....
                if campo.valida_error='SI' then
                        --Ejecuto la regla dinamicamente
                        BEGIN
                                xml2:=put_campo(xml2,'NOMBRE_REGLA',campo.nombre_regla);
                                execute 'select ' || campo.funcion_acumulacion || '(' || quote_literal(xml2) || ')' in
to aux;
                        EXCEPTION WHEN OTHERS THEN
                                RAISE NOTICE 'Error de sintaxis en la regla de acumulacion=%',campo.funcion_acumulacio
n;
                        END;
                else
                        xml2:=put_campo(xml2,'NOMBRE_REGLA',campo.nombre_regla);
                        execute 'select ' || campo.funcion_acumulacion || '(' || quote_literal(xml2) || ')' into aux;
                end if;
                --JCC:17-01-2013 -> Al terminar una regla de acumulacion. Se limpian variables VALOR"n". Genera confli
cto con reglas de validacion
                xml2:= put_campo (xml2,'VALOR1','');
                xml2:= put_campo (xml2,'VALOR2','');
               xml2:= put_campo (xml2,'VALOR3','');
                xml2:= put_campo (xml2,'VALOR4','');
                xml2:= put_campo (xml2,'VALOR5','');

        end loop;
        xml2 := put_campo(xml2,'CONTROL_ACUMULACION',control_acumulacion1);
        return xml2;
end;
$function$


