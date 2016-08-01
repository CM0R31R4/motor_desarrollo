create table tx_cias_test (
fecha_ingreso		timestamp,
dia			integer,
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
msginput		varchar
);

create index tx_cias_test_01 on tx_cias_test (fecha_ingreso);
create index tx_cias_test_02 on tx_cias_test (dia);
create index tx_cias_test_03 on tx_cias_test (codigo_motor);
create index tx_cias_test_04 on tx_cias_test (extfoliobono);
create index tx_cias_test_05 on tx_cias_test (extfolioauto);
create index tx_cias_test_06 on tx_cias_test (num_operacion);

