DROP TABLE servicios_fonasa;

CREATE TABLE servicios_fonasa(
tipo_tx         varchar(20),
financiador     integer,
secuencia       integer,
funcion_input   varchar(100),
funcion_output  varchar(100),
descripcion     varchar(20),
ip_generica     varchar(20),
correlativo_port_generica varchar(50),
estado		integer
);

insert into servicios_fonasa values ('bencertif', 1, 101,'traductorWL_in_bencertif_fonasa', 'traductorWL_out_bencertif_fonasa', 'FONASA', NULL, NULL, 1);
insert into servicios_fonasa values ('anulabonou', 1, 101,'traductorWL_in_anulabonou_fonasa', 'traductorWL_out_anulabonou_fonasa', 'FONASA', NULL, NULL, 1);
insert into servicios_fonasa values ('coptran', 1, 101,'traductorWL_in_coptran_fonasa', 'traductorWL_out_coptran_fonasa', 'FONASA', NULL, NULL, 1);
insert into servicios_fonasa values ('envbono', 1, 101,'traductorWL_in_envbono_fonasa', 'traductorWL_out_envbono_fonasa', 'FONASA', NULL, NULL, 1);
insert into servicios_fonasa values ('datosprest', 1, 101,'traductorWL_in_datosprest_fonasa', 'traductorWL_out_datosprest_fonasa', 'FONASA', NULL, NULL, 1);
insert into servicios_fonasa values ('enrola', 1, 101,'traductorWL_in_enrola_fonasa', 'traductorWL_out_enrola_fonasa', 'FONASA', NULL, NULL, 1);
insert into servicios_fonasa values ('solicfolios', 1, 101,'traductorWL_in_solicfolios_fonasa', 'traductorWL_out_solicfolios_fonasa', 'FONASA', NULL, NULL, 1);
insert into servicios_fonasa values ('validacat', 1, 101,'traductorWL_in_validacat_fonasa', 'traductorWL_out_validacat_fonasa', 'FONASA', NULL, NULL, 1);
insert into servicios_fonasa values ('valtrans', 1, 101,'traductorWL_in_valtrans_fonasa', 'traductorWL_out_valtrans_fonasa', 'FONASA', NULL, NULL, 1);
INSERT INTO servicios_fonasa VALUES ('envbono_real', 1, 101, 'traductorWL_in_envbono_fonasa', 'traductorWL_out_envbono_fonasa', 'FONASA', NULL, NULL, 1);

