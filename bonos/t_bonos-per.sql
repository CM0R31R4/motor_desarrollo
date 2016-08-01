drop table venta_nocturna cascade;
create table venta_nocturna (
codfinanciador          varchar,
foliobono               varchar,
codidventaconvenio      varchar,
numactoventa            varchar,
cedbeneficiario         varchar,
fecemision              varchar,
mtototalbono            varchar,
estadosbono             varchar,
gloatributo             varchar
);

create index unique venta_nocturna_01 on venta_nocturna (codfinanciador,foliobono);

--\copy venta_nocturna from 'bonos.txt'
