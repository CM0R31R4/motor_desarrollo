DROP TABLE tx_dec;

CREATE TABLE tx_dec (
	codigo_motor	bigint,
        num_actoventa   bigint,        
	fecha_tx	timestamp  DEFAULT now(),
        fecha_emision   varchar,
        xml_actoventa   varchar,
	cod_fin         integer,
--	dia		int4 DEFAULT (to_char(now(), 'YYYYMMDD'::text))::integer,
	estado		varchar,
	codigo_resp	varchar(1),
   	codigo_dec      varchar,
	mensaje_resp	varchar(50)
);

CREATE INDEX tx_dec_01 ON tx_dec USING btree (codigo_motor);
CREATE INDEX tx_dec_02 ON tx_dec USING btree (fecha_tx);
-- CREATE INDEX tx_dec_03 ON tx_dec USING btree (dia);
