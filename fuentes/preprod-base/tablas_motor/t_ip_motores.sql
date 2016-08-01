DROP TABLE ip_motores;
CREATE TABLE ip_motores 
(
	id		integer,
	ip_motor	varchar,
	descripcion	varchar
);

CREATE index ip_motores_01 on ip_motores (ip_motor);

-- Inserts para pruebas.
insert into ip_motores values(1, '172.16.14.28', 'im-bono3qa-motor01-ng1');
insert into ip_motores values(2, '10.100.32.58', 'bono3-motor-cert-sonda');
--insert into ip_motores values(3, '10.100.32.179', 'Desarrollo - AutTuxExt5');
--insert into ip_motores values(4, '10.100.32.180', 'Desarrollo - AutTuxExt6');
