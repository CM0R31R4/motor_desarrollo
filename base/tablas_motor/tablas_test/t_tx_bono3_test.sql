--DROP table tx_bono3 cascade;
CREATE table tx_bono3_test (
        cod_fin         integer,        --78,88,99
        financiador     varchar(50),    --BANMEDICA,CRUZBLANCA,MASVIDA
        tipo_tx         varchar(20),
        codigo_motor    bigint,
        rut_benef       varchar(12),

        fecha_in_tx     timestamp,      --Fecha In del Core_8081
        fecha_out_tx    timestamp,      --Fecha Out del Core_8081
        fecha_in_fin    timestamp,      --Fecha In Financiador (Va en los sp de c/financiador)
        fecha_out_fin   timestamp,      --Fecha Out Financiador (Va en los sp de c/financiador)

        estado          varchar(20),    --EN_PROCESO,TERMINADO_OK, RECHAZADO, FALLA_TX
        codigo_resp     varchar(1),     --1=Aprobada - 2=Rechazada
        mensaje_resp    varchar(50),    --Trasaccion OK
        mensaje_fin     varchar(50),
        xml_input       varchar,        --Xml entrante al Listener
        xml_output      varchar,        --Xml saliente del Listener
        sp_exec         varchar,        --SP a ejecutar en base datos del financiador
        sp_return       varchar,        --Respuesta del SP ejecutado
        host            varchar(100),   --Respuesta del SP ejecutado
        folio           varchar,
        procesador_xml  varchar,
        conexiones_activas varchar

);
CREATE index tx_bono3_test_01 on tx_bono3_test (codigo_motor);
CREATE index tx_bono3_test_02 on tx_bono3_test (fecha_in_tx);
CREATE index tx_bono3_test_03 on tx_bono3_test (folio);
