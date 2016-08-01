CREATE OR REPLACE FUNCTION control.mc_validacion_reglas_control(character varying)
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
        control_validacion1     varchar;
begin
        xml2 :=  data1;
        tipo_tx1:=replace(get_campo('TIPO_TRX',xml2),' ','');
        emisor1 :=replace(get_campo('EMISOR',xml2),' ','');

        if length(tipo_tx1)=0 or length(emisor1)=0 then
                return xml2;
        end if;

        --Variable de control para verificar el orden de aplicacion de las reglas
        control_validacion1:='';

        --Leemos solo las reglas que tengan funcion_validacion por tipo_Tx y emisor
        for campo in select * from control.reglas where
                (tx_incluidas       @@ (tipo_tx1||' | ALL')::tsquery and not (tx_no_incluidas       @@ tipo_tx1::tsque
ry)) and
                (emisores_incluidos @@ (emisor1 ||' | ALL')::tsquery and not (emisores_no_incluidos @@ emisor1::tsquer
y)) and
                length(funcion_validacion)>0 and estado='ACTIVO' order by prioridad loop

                control_validacion1:=control_validacion1||','||campo.nombre_regla;
                --Si la regla tiene validacion de error....
                if campo.valida_error='SI' then
                        --Ejecuto la regla dinamicamente
                        BEGIN
                                xml2:=put_campo(xml2,'NOMBRE_REGLA',campo.nombre_regla);
                                execute 'select ' || campo.funcion_validacion || '(' || quote_literal(xml2) || ')' int
o xml2;
                        EXCEPTION WHEN OTHERS THEN
                                RAISE NOTICE 'Error de sintaxis en la regla de acumulacion=%',campo.funcion_validacion
;
                        END;
                else
                        xml2:=put_campo(xml2,'NOMBRE_REGLA',campo.nombre_regla);
                        execute 'select ' || campo.funcion_validacion || '(' || quote_literal(xml2) || ')' into xml2;
                end if;

                --Si la regla genero una condicion de parada detengo la revision de las reglas
                if get_campo('__EXIT__',xml2)='1' then
                        xml2 := put_campo(xml2,'CONTROL_VALIDACION',control_validacion1);
                        return xml2;
                end if;
                --JCC:17-01-2013 -> Al terminar una regla de validacion. Se limpian variables VALOR"n". Genera conflic
to con reglas de acumulacion
                xml2:= put_campo (xml2,'VALOR1','');
                xml2:= put_campo (xml2,'VALOR2','');
                xml2:= put_campo (xml2,'VALOR3','');
                xml2:= put_campo (xml2,'VALOR4','');
                xml2:= put_campo (xml2,'VALOR5','');
        end loop;
        xml2 := put_campo(xml2,'CONTROL_VALIDACION',control_validacion1);
        return xml2;
end;
$function$

