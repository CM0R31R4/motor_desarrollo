--DROP table tx_cias cascade;
create table tx_cias (
fecha_ingreso		timestamp,
dia			integer default (to_char(now(), 'YYYYMMDD'::text))::integer,
tiempo_ini_cia		timestamp,
tiempo_fin_cia		timestamp,
tiempo_ini_sybase	timestamp,
tiempo_fin_sybase	timestamp,
codigo_cia		varchar,
codigo_motor		bigint,
extfolioauto		varchar,
extcoderror		varchar,
extmensajeerror		varchar,
msgoutput		varchar,
estado                 	varchar,
reintentos             	integer,
tx                     	varchar,
nemo                   	varchar,
ip_cliente             	varchar,
fecha_ult_modificacion 	timestamp,
num_operacion          	varchar,
extfoliobono           	varchar,
cod_lugar           	varchar,
rut_prestador          	varchar,
rut_beneficiario        varchar,
msginput		varchar,
fecha_emision		integer,
monto_bonif		integer
);

create index tx_cias_01 on tx_cias (fecha_ingreso);
create index tx_cias_02 on tx_cias (dia);
create index tx_cias_03 on tx_cias (codigo_motor);
create index tx_cias_04 on tx_cias (extfoliobono);
create index tx_cias_05 on tx_cias (extfolioauto);
create index tx_cias_06 on tx_cias (num_operacion);

/*
fecha_ingreso          | timestamp without time zone |
 dia                    | integer                     | default (to_char(now(), 'YYYYMMDD'::text))::integer
 tiempo_ini_cia         | timestamp without time zone |
 tiempo_fin_cia         | timestamp without time zone |
 tiempo_ini_sybase      | timestamp without time zone |
 tiempo_fin_sybase      | timestamp without time zone |
 codigo_cia             | character varying           |
 codigo_motor           | bigint                      |
 extfolioauto           | character varying           |
 extcoderror            | character varying           |
 extmensajeerror        | character varying           |
 msgoutput              | character varying           |
 estado                 | character varying           |
 reintentos             | integer                     |
 tx                     | character varying           |
 nemo                   | character varying           |
 ip_cliente             | character varying           |
 fecha_ult_modificacion | timestamp without time zone |
 num_operacion          | character varying           |
 extfoliobono           | character varying           |
 cod_lugar              | character varying           |
 rut_prestador          | character varying           |

Indexes:
    "tx_cias_01" btree (fecha_ingreso)
    "tx_cias_02" btree (dia)
    "tx_cias_03" btree (codigo_motor)
    "tx_cias_04" btree (extfoliobono)
    "tx_cias_05" btree (extfolioauto)
*/
