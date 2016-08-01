drop table isys_querys_tx;
create table isys_querys_tx (
llave	varchar(20),
secuencia	integer,
BASE_QUERY_1	integer,
TIPO_12		integer,
QUERY_1		varchar,
SERVICIO_2	integer,
FORMATO_SALIDA_2	integer,
FORMATO_ACK_2	integer,
ESPERA_OUTPUT_1	integer,
VALIDA_OUTPUT_1	integer,
SECUENCIA_OK	integer,
SECUENCIA_ERROR	integer);

create index isys_querys_tx_01 on isys_querys_tx (llave);
