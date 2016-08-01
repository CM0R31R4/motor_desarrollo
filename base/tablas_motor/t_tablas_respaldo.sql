drop table tablas_respaldo;
create table tablas_respaldo(
	tab_origen	varchar(50),	-- Nombre de la tabla a respaldar.
	tab_destino	varchar(50),	-- Nombre de tabla de destino del respaldo.
	estado_resp	integer		-- 0 = Inactivo | 1 = Activo
);

create index tablas_respaldo_01 on tablas_respaldo (tab_origen);	

-- Inserta nombres de tablas a respaldar y su estado.
--insert into tablas_respaldo values('tx_bono3', 'historico_tx_bono3', 0);
--insert into tablas_respaldo values('tx_cias', 'historico_tx_cias', 0);
--insert into tablas_respaldo values('respaldo_envbonis', 'historico_envbonis', 0);
--insert into tablas_respaldo values('respaldo_cia', 'historico_cia', 0);
insert into tablas_respaldo values('tx_bono3_test', 'historico_tx_bono3', 1);
insert into tablas_respaldo values('tx_cias_test', 'historico_tx_cias',1);
insert into tablas_respaldo values('respaldo_envbonis_test', 'historico_envbonis', 1);
insert into tablas_respaldo values('respaldo_cia_test', 'historico_cia', 1);


