--drop table tx_cias cascade;
create table tx_cias (
fecha_ingreso           timestamp,
dia                     integer default (to_char(now(), 'YYYYMMDD'::text))::integer,
tiempo_ini_cia          timestamp,
tiempo_fin_cia          timestamp,
tiempo_ini_sybase       timestamp,
tiempo_fin_sybase       timestamp,
codigo_cia              varchar,
codigo_motor            bigint,
extfolioauto            varchar,
extcoderror             varchar,
extmensajeerror         varchar,
msgoutput               varchar,
estado                  varchar,
reintentos              integer,
tx                      varchar,
nemo                    varchar,
ip_cliente              varchar,
fecha_ult_modificacion  timestamp,
num_operacion           varchar,
extfoliobono            varchar,
cod_lugar               varchar,
rut_prestador           varchar,
rut_beneficiario        varchar,
msginput                varchar,
fecha_emision           integer,
monto_bonif             integer
);

create index tx_cias_01 on tx_cias (fecha_ingreso);
create index tx_cias_02 on tx_cias (dia);
create index tx_cias_03 on tx_cias (codigo_motor);
create index tx_cias_04 on tx_cias (extfoliobono);
create index tx_cias_05 on tx_cias (extfolioauto);
create index tx_cias_06 on tx_cias (num_operacion);
