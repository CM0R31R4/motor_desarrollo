DROP TABLE tx_ActoVentaXml;

CREATE TABLE tx_ActoVentaXml(
	id		BIGINT,
	acto_venta	BIGINT,
	cod_fin		INTEGER,
	xml		VARCHAR,
	fecha_in	TIMESTAMP,
	id_cola		INTEGER,
	api		VARCHAR,
	reintentos	INTEGER,
	estado		VARCHAR,
	mensaje		VARCHAR,
	xml_input	VARCHAR
);
