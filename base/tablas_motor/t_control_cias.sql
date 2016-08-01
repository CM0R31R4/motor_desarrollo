drop table control_cias;
create table control_cias (
	codigo_cia	varchar,
	tx		varchar,
	fecha_ini	timestamp,
	fecha_fin	timestamp,
	total_ok_5_min	integer,
	total_rechazo_5_min	integer,
	total_timeout_5_min	integer,
	total_en_cola	integer);
	
