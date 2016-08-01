drop table define_secuencia_ws;

create table define_secuencia_ws(
tipo_tx varchar(20),
financiador integer,
secuencia integer,
funcion_input varchar(100),
funcion_output varchar(100),
descripcion varchar(20),
ip_generica varchar(20),
correlativo_port_generica varchar(50)
);
create index define_secuencia_ws_01 on define_secuencia_ws(tipo_tx,financiador);

/********** AUTENTIA MEDIOS_PAGOS - FIN=2(MC) **********/
insert into define_secuencia_ws values ('TRX_VERIDERECHO',2,100,'proc_parser_in_verder_mp','proc_parser_out_verder_mp','AUT_MC');
insert into define_secuencia_ws values ('TRX_VENTA',2,100,'proc_parser_in_venta_mp','proc_parser_out_venta_mp','AUT_MC');
insert into define_secuencia_ws values ('TRX_CONFIRMA_BONO',2,100,'proc_parser_in_confirma_mp','proc_parser_out_confirma_mp','AUT_MC');
insert into define_secuencia_ws values ('TRX_ANULA',2,100,'proc_parser_in_anula_mp','proc_parser_out_anula_mp','AUT_MC');
insert into define_secuencia_ws values ('TRX_REIMPRESION',2,100,'proc_parser_in_reimpresion_mp','proc_parser_out_reimpresion_mp','AUT_MC');

/********** CUENTAS MEDICAS **********/
/*Flujo 3005*/
insert into define_secuencia_ws values ('iniciotx',88,30,'iniciotx_ctamed','','CTAMED');
insert into define_secuencia_ws values ('fintx',88,30,'fintx_ctamed','','CTAMED');
insert into define_secuencia_ws values ('anulatx',88,30,'anulatx_ctamed','','CTAMED');

--CUENTA MEDICA
insert into define_secuencia_ws values ('cerenvcta',88,30,'traductor_in_cerenvcta_masvida','traductor_out_cerenvcta_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerenvdetequipo',88,30,'traductor_in_cerenvdetequipo_masvida','traductor_out_cerenvcta_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerenvdetinsumo',88,30,'traductor_in_cerenvdetinsumo_masvida','traductor_out_cerenvcta_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerenvdethotele',88,30,'traductor_in_cerenvdethotele_masvida','traductor_out_cerenvcta_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerenvinfpac',88,30,'traductor_in_cerenvinfpac_masvida','traductor_out_cerenvcta_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerenvpaquete',88,30,'traductor_in_cerenvpaquete_masvida','traductor_out_cerenvcta_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerenvtipant',88,30,'traductor_in_cerenvtipant_masvida','traductor_out_cerenvcta_masvida','MAS_VIDA');

/*Servicios Inactivos
insert into define_secuencia_ws values ('ceremibonopam',88,188,'traductor_in_ceremibonopam_masvida','traductor_out_ceremibonopam_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerobtbonequipo',88,188,'traductor_in_cerobtbonequipo_masvida','traductor_out_cerobtbonequipo_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerobtbonhotele',88,188,'traductor_in_cerobtbonhotele_masvida','traductor_out_cerobtbonhotele_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerobtboninsumo',88,188,'traductor_in_cerobtboninsumo_masvida','traductor_out_cerobtboninsumo_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerobtbonospam',88,188,'traductor_in_cerobtbonospam_masvida','traductor_out_cerobtbonospam_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerobtfecpag',88,188,'traductor_in_cerobtfecpag_masvida','traductor_out_cerobtfecpag_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerobtpaquete',88,188,'traductor_in_cerobtpaquete_masvida','traductor_out_cerobtpaquete_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerobtsaldospag',88,188,'traductor_in_cerobtsaldospag_masvida','traductor_out_cerobtsaldospag_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerrelhmqprot',88,188,'traductor_in_cerrelhmqprot_masvida','traductor_out_cerrelhmqprot_masvida','MAS_VIDA');
*/
--PROTOCOLO OPERATORIO
insert into define_secuencia_ws values ('cerencprot',88,30,'traductor_in_cerencprot_masvida',	'traductor_out_cerencprot_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerdetprot',88,30,'traductor_in_cerdetprot_masvida',	'traductor_out_cerencprot_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerotrcir',88,30,'traductor_in_cerotrcir_masvida',	'traductor_out_cerencprot_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerdiagpreop',88,30,'traductor_in_cerdiagpreop_masvida',	'traductor_out_cerencprot_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerdiagposop',88,30,'traductor_in_cerdiagposop_masvida',	'traductor_out_cerencprot_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerequmed',88,30,'traductor_in_cerequmed_masvida',	'traductor_out_cerencprot_masvida','MAS_VIDA');

--ANAMNESIS
insert into define_secuencia_ws values ('cerencanam',88,30,'traductor_in_cerencanam_masvida','traductor_out_cerencanam_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerdetanam',88,30,'traductor_in_cerdetanam_masvida','traductor_out_cerencanam_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerantmor',88,30,'traductor_in_cerantmor_masvida','traductor_out_cerencanam_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerantqui',88,30,'traductor_in_cerantqui_masvida','traductor_out_cerencanam_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('ceranthab',88,30,'traductor_in_ceranthab_masvida','traductor_out_cerencanam_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerexafis',88,30,'traductor_in_cerexafis_masvida','traductor_out_cerencanam_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cergrpfam',88,30,'traductor_in_cergrpfam_masvida','traductor_out_cerencanam_masvida','MAS_VIDA');

--EPICRISIS
insert into define_secuencia_ws values ('cerencepi',88,30,'traductor_in_cerencepi_masvida','traductor_out_cerencepi_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerdetevo',88,30,'traductor_in_cerdetevo_masvida','traductor_out_cerencepi_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('certrapro',88,30,'traductor_in_certrapro_masvida','traductor_out_cerencepi_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerdiaegr',88,30,'traductor_in_cerdiaegr_masvida','traductor_out_cerencepi_masvida','MAS_VIDA');
insert into define_secuencia_ws values ('cerepiind',88,30,'traductor_in_cerepiind_masvida','traductor_out_cerencepi_masvida','MAS_VIDA');

/********** BONO 3 **********/
--, 'seq_puerto_banmedica' -> VidaTres
--, 'seq_puerto_banmedica' -> Banmedica

--BENCERTIF
insert into define_secuencia_ws values ('bencertif', 11, 11,'traductor_in_bencertif_cchc', 'traductor_out_bencertif_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('bencertif', 44, 44,'traductor_in_bencertif_vidacamara', 'traductor_out_bencertif_vidacamara', 'VIDA_CAMARA');
insert into define_secuencia_ws values ('bencertif', 62, 900,'traductor_in_bencertif_sanlorenzo', 'traductor_out_bencertif_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('bencertif', 63, 900,'traductor_in_bencertif_fusat', 'traductor_out_bencertif_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('bencertif', 65, 900,'traductor_in_bencertif_chuqui', 'traductor_out_bencertif_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('bencertif', 67, 67,'traductor_in_bencertif_colmena', 'traductor_out_bencertif_colmena', 'COLMENA');
insert into define_secuencia_ws values ('bencertif', 68, 900,'traductor_in_bencertif_rioblanco', 'traductor_out_bencertif_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('bencertif', 71, 900,'traductor_in_bencertif_consalud', 'traductor_out_bencertif_consalud', 'CONSALUD', '127.0.0.1', '8560');
insert into define_secuencia_ws values ('bencertif', 71, 900,'traductor_in_bencertif_consalud', 'traductor_out_bencertif_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
insert into define_secuencia_ws values ('bencertif', 76, 900,'traductor_in_bencertif_fundacion', 'traductor_out_bencertif_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('bencertif', 78, 78,'traductor_in_bencertif_cruzblanca', 'traductor_out_bencertif_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('bencertif', 80, 900,'traductor_in_bencertif_vidatres', 'traductor_out_bencertif_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('bencertif', 81, 81,'traductor_in_bencertif_ferrosalud', 'traductor_out_bencertif_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('bencertif', 88, 88,'traductor_in_bencertif_masvida', 'traductor_out_bencertif_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('bencertif', 94, 900,'traductor_in_bencertif_cruzdelnorte', 'traductor_out_bencertif_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('bencertif', 99, 900,'traductor_in_bencertif_banmedica', 'traductor_out_bencertif_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('bencertif', 99, 900,'traductor_in_bencertif_banmedica', 'traductor_out_bencertif_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('bencertif', 1, 100,'traductor_in_bencertif_fonasa', 'traductor_out_bencertif_fonasa', 'FONASA');

--ANULABONOU
insert into define_secuencia_ws values ('anulabonou', 11, 11,'traductor_in_anulabonou_cchc', 'traductor_out_anulabonou_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('anulabonou', 44, 44,'traductor_in_anulabonou_vidacamara', 'traductor_out_anulabonou_vidacamara', 'VIDA_CAMARA');
insert into define_secuencia_ws values ('anulabonou', 62, 900,'traductor_in_anulabonou_sanlorenzo', 'traductor_out_anulabonou_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('anulabonou', 63, 900,'traductor_in_anulabonou_fusat', 'traductor_out_anulabonou_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('anulabonou', 65, 900,'traductor_in_anulabonou_chuqui', 'traductor_out_anulabonou_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('anulabonou', 67, 67,'traductor_in_anulabonou_colmena', 'traductor_out_anulabonou_colmena', 'COLMENA');
insert into define_secuencia_ws values ('anulabonou', 68, 900,'traductor_in_anulabonou_rioblanco', 'traductor_out_anulabonou_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('anulabonou', 71, 900,'traductor_in_anulabonou_consalud', 'traductor_out_anulabonou_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
insert into define_secuencia_ws values ('anulabonou', 76, 900,'traductor_in_anulabonou_fundacion', 'traductor_out_anulabonou_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('anulabonou', 78, 78,'traductor_in_anulabonou_cruzblanca', 'traductor_out_anulabonou_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('anulabonou', 80, 900,'traductor_in_anulabonou_vidatres', 'traductor_out_anulabonou_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('anulabonou', 81, 81,'traductor_in_anulabonou_ferrosalud', 'traductor_out_anulabonou_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('anulabonou', 88, 88,'traductor_in_anulabonou_masvida', 'traductor_out_anulabonou_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('anulabonou', 94, 900,'traductor_in_anulabonou_cruzdelnorte', 'traductor_out_anulabonou_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('anulabonou', 99, 900,'traductor_in_anulabonou_banmedica', 'traductor_out_anulabonou_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('anulabonou', 1, 100,'traductor_in_anulabonou_fonasa', 'traductor_out_anulabonou_fonasa', 'FONASA');

--BENREC
insert into define_secuencia_ws values ('benrec', 11, 11,'traductor_in_benrec_cchc', 'traductor_out_benrec_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('benrec', 44, 44,'traductor_in_benrec_vidacamara', 'traductor_out_benrec_vidacamara', 'VIDA_CAMARA');
--insert into define_secuencia_ws values ('benrec', 62, 900,'traductor_in_benrec_sanlorenzo', 'traductor_out_benrec_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('benrec', 63, 900,'traductor_in_benrec_fusat', 'traductor_out_benrec_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('benrec', 65, 900,'traductor_in_benrec_chuqui', 'traductor_out_benrec_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('benrec', 67, 67,'traductor_in_benrec_colmena', 'traductor_out_benrec_colmena', 'COLMENA');
--insert into define_secuencia_ws values ('benrec', 68, 900,'traductor_in_benrec_rioblanco', 'traductor_out_benrec_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('benrec', 71, 900,'traductor_in_benrec_consalud', 'traductor_out_benrec_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
--insert into define_secuencia_ws values ('benrec', 76, 900,'traductor_in_benrec_fundacion', 'traductor_out_benrec_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('benrec', 78, 78,'traductor_in_benrec_cruzblanca', 'traductor_out_benrec_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('benrec', 80, 900,'traductor_in_benrec_vidatres', 'traductor_out_benrec_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('benrec', 81, 81,'traductor_in_benrec_ferrosalud', 'traductor_out_benrec_ferrosalud', 'FERROSALUD');
--insert into define_secuencia_ws values ('benrec', 88, 88,'traductor_in_benrec_masvida', 'traductor_out_benrec_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('benrec', 94, 900,'traductor_in_benrec_cruzdelnorte', 'traductor_out_benrec_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('benrec', 99, 900,'traductor_in_benrec_banmedica', 'traductor_out_benrec_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');

--COPTRAN
insert into define_secuencia_ws values ('coptran', 1, 100,'traductor_in_coptran_fonasa', 'traductor_out_coptran_fonasa', 'FONASA');
insert into define_secuencia_ws values ('envbono', 1, 100,'traductor_in_envbono_fonasa', 'traductor_out_envbono_fonasa', 'FONASA');

--DATOSPREST
--insert into define_secuencia_ws values ('datosprest', 11, 11,'traductor_in_datosprest_cchc', 'traductor_out_datosprest_cchc', 'SM_CCHC');
--insert into define_secuencia_ws values ('datosprest', 44, 44,'traductor_in_datosprest_vidacamara', 'traductor_out_datosprest_vidacamara', 'VIDA_CAMARA');
--insert into define_secuencia_ws values ('datosprest', 62, 900,'traductor_in_datosprest_sanlorenzo', 'traductor_out_datosprest_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('datosprest', 63, 900,'traductor_in_datosprest_fusat', 'traductor_out_datosprest_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('datosprest', 65, 900,'traductor_in_datosprest_chuqui', 'traductor_out_datosprest_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('datosprest', 67, 67,'traductor_in_datosprest_colmena', 'traductor_out_datosprest_colmena', 'COLMENA');
--insert into define_secuencia_ws values ('datosprest', 68, 900,'traductor_in_datosprest_rioblanco', 'traductor_out_datosprest_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('datosprest', 71, 900,'traductor_in_datosprest_consalud', 'traductor_out_datosprest_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
--insert into define_secuencia_ws values ('datosprest', 76, 900,'traductor_in_datosprest_fundacion', 'traductor_out_datosprest_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
--insert into define_secuencia_ws values ('datosprest', 78, 78,'traductor_in_datosprest_cruzblanca', 'traductor_out_datosprest_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('datosprest', 80, 900,'traductor_in_datosprest_vidatres', 'traductor_out_datosprest_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
--insert into define_secuencia_ws values ('datosprest', 81, 81,'traductor_in_datosprest_ferrosalud', 'traductor_out_datosprest_ferrosalud', 'FERROSALUD');
--insert into define_secuencia_ws values ('datosprest', 88, 88,'traductor_in_datosprest_masvida', 'traductor_out_datosprest_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('datosprest', 94, 900,'traductor_in_datosprest_cruzdelnorte', 'traductor_out_datosprest_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('datosprest', 99, 900,'traductor_in_datosprest_banmedica', 'traductor_out_datosprest_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('datosprest', 1, 100,'traductor_in_datosprest_fonasa', 'traductor_out_datosprest_fonasa', 'FONASA');

--ENROLA
insert into define_secuencia_ws values ('enrola', 11, 11,'traductor_in_enrola_cchc', 'traductor_out_enrola_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('enrola', 44, 44,'traductor_in_enrola_vidacamara', 'traductor_out_enrola_vidacamara', 'VIDA_CAMARA');
insert into define_secuencia_ws values ('enrola', 62, 900,'traductor_in_enrola_sanlorenzo', 'traductor_out_enrola_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('enrola', 63, 900,'traductor_in_enrola_fusat', 'traductor_out_enrola_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('enrola', 65, 900,'traductor_in_enrola_chuqui', 'traductor_out_enrola_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('enrola', 67, 67,'traductor_in_enrola_colmena', 'traductor_out_enrola_colmena', 'COLMENA');
insert into define_secuencia_ws values ('enrola', 68, 900,'traductor_in_enrola_rioblanco', 'traductor_out_enrola_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('enrola', 71, 900,'traductor_in_enrola_consalud', 'traductor_out_enrola_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
insert into define_secuencia_ws values ('enrola', 76, 900,'traductor_in_enrola_fundacion', 'traductor_out_enrola_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('enrola', 78, 78,'traductor_in_enrola_cruzblanca', 'traductor_out_enrola_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('enrola', 80, 900,'traductor_in_enrola_vidatres', 'traductor_out_enrola_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('enrola', 81, 81,'traductor_in_enrola_ferrosalud', 'traductor_out_enrola_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('enrola', 88, 88,'traductor_in_enrola_masvida', 'traductor_out_enrola_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('enrola', 94, 900,'traductor_in_enrola_cruzdelnorte', 'traductor_out_enrola_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('enrola', 99, 900,'traductor_in_enrola_banmedica', 'traductor_out_enrola_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('enrola', 1, 100,'traductor_in_enrola_fonasa', 'traductor_out_enrola_fonasa', 'FONASA');

--ENVBONIS
insert into define_secuencia_ws values ('envbonis', 11, 11,'traductor_in_envbonis_cchc', 'traductor_out_envbonis_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('envbonis', 44, 44,'traductor_in_envbonis_vidacamara', 'traductor_out_envbonis_vidacamara', 'VIDA_CAMARA');
insert into define_secuencia_ws values ('envbonis', 62, 900,'traductor_in_envbonis_sanlorenzo', 'traductor_out_envbonis_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('envbonis', 63, 900,'traductor_in_envbonis_fusat', 'traductor_out_envbonis_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('envbonis', 65, 900,'traductor_in_envbonis_chuqui', 'traductor_out_envbonis_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('envbonis', 67, 67,'traductor_in_envbonis_colmena', 'traductor_out_envbonis_colmena', 'COLMENA');
insert into define_secuencia_ws values ('envbonis', 68, 900,'traductor_in_envbonis_rioblanco', 'traductor_out_envbonis_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('envbonis', 71, 900,'traductor_in_envbonis_consalud', 'traductor_out_envbonis_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
insert into define_secuencia_ws values ('envbonis', 76, 900,'traductor_in_envbonis_fundacion', 'traductor_out_envbonis_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('envbonis', 78, 78,'traductor_in_envbonis_cruzblanca', 'traductor_out_envbonis_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('envbonis', 80, 900,'traductor_in_envbonis_vidatres', 'traductor_out_envbonis_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('envbonis', 81, 81,'traductor_in_envbonis_ferrosalud', 'traductor_out_envbonis_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('envbonis', 88, 88,'traductor_in_envbonis_masvida', 'traductor_out_envbonis_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('envbonis', 94, 900,'traductor_in_envbonis_cruzdelnorte', 'traductor_out_envbonis_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('envbonis', 99, 900,'traductor_in_envbonis_banmedica', 'traductor_out_envbonis_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');
--insert into define_secuencia_ws values ('envbonis', 1, 100,'traductor_in_envbonis_fonasa', 'traductor_out_envbonis_fonasa', 'FONASA');

--INFENROLA
--insert into define_secuencia_ws values ('infenrola', 11, 11,'traductor_in_infenrola_cchc', 'traductor_out_infenrola_cchc', 'SM_CCHC');
--insert into define_secuencia_ws values ('infenrola', 44, 44,'traductor_in_infenrola_vidacamara', 'traductor_out_infenrola_vidacamara', 'VIDA_CAMARA');
--insert into define_secuencia_ws values ('infenrola', 62, 900,'traductor_in_infenrola_sanlorenzo', 'traductor_out_infenrola_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('infenrola', 63, 900,'traductor_in_infenrola_fusat', 'traductor_out_infenrola_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('infenrola', 65, 900,'traductor_in_infenrola_chuqui', 'traductor_out_infenrola_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('infenrola', 67, 67,'traductor_in_infenrola_colmena', 'traductor_out_infenrola_colmena', 'COLMENA');
--insert into define_secuencia_ws values ('infenrola', 68, 900,'traductor_in_infenrola_rioblanco', 'traductor_out_infenrola_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('infenrola', 71, 900,'traductor_in_infenrola_consalud', 'traductor_out_infenrola_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
--insert into define_secuencia_ws values ('infenrola', 76, 900,'traductor_in_infenrola_fundacion', 'traductor_out_infenrola_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
--insert into define_secuencia_ws values ('infenrola', 78, 78,'traductor_in_infenrola_cruzblanca', 'traductor_out_infenrola_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('infenrola', 80, 900,'traductor_in_infenrola_vidatres', 'traductor_out_infenrola_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
--insert into define_secuencia_ws values ('infenrola', 81, 81,'traductor_in_infenrola_ferrosalud', 'traductor_out_infenrola_ferrosalud', 'FERROSALUD');
--insert into define_secuencia_ws values ('infenrola', 88, 88,'traductor_in_infenrola_masvida', 'traductor_out_infenrola_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('infenrola', 94, 900,'traductor_in_infenrola_cruzdelnorte', 'traductor_out_infenrola_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('infenrola', 99, 900,'traductor_in_infenrola_banmedica', 'traductor_out_infenrola_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');

--LEERUTCOTIZ
insert into define_secuencia_ws values ('leerutcotiz', 11, 11,'traductor_in_leerutcotiz_cchc', 'traductor_out_leerutcotiz_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('leerutcotiz', 44, 44,'traductor_in_leerutcotiz_vidacamara', 'traductor_out_leerutcotiz_vidacamara', 'VIDA_CAMARA');
insert into define_secuencia_ws values ('leerutcotiz', 62, 900,'traductor_in_leerutcotiz_sanlorenzo', 'traductor_out_leerutcotiz_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('leerutcotiz', 63, 900,'traductor_in_leerutcotiz_fusat', 'traductor_out_leerutcotiz_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('leerutcotiz', 65, 900,'traductor_in_leerutcotiz_chuqui', 'traductor_out_leerutcotiz_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('leerutcotiz', 67, 67,'traductor_in_leerutcotiz_colmena', 'traductor_out_leerutcotiz_colmena', 'COLMENA');
insert into define_secuencia_ws values ('leerutcotiz', 68, 900,'traductor_in_leerutcotiz_rioblanco', 'traductor_out_leerutcotiz_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('leerutcotiz', 71, 900,'traductor_in_leerutcotiz_consalud', 'traductor_out_leerutcotiz_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
insert into define_secuencia_ws values ('leerutcotiz', 76, 900,'traductor_in_leerutcotiz_fundacion', 'traductor_out_leerutcotiz_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('leerutcotiz', 78, 78,'traductor_in_leerutcotiz_cruzblanca', 'traductor_out_leerutcotiz_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('leerutcotiz', 80, 900,'traductor_in_leerutcotiz_vidatres', 'traductor_out_leerutcotiz_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('leerutcotiz', 81, 81,'traductor_in_leerutcotiz_ferrosalud', 'traductor_out_leerutcotiz_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('leerutcotiz', 88, 88,'traductor_in_leerutcotiz_masvida', 'traductor_out_leerutcotiz_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('leerutcotiz', 94, 900,'traductor_in_leerutcotiz_cruzdelnorte', 'traductor_out_leerutcotiz_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('leerutcotiz', 99, 900,'traductor_in_leerutcotiz_banmedica', 'traductor_out_leerutcotiz_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');

--PRESTPAQUETE
--insert into define_secuencia_ws values ('prestpaquete', 11, 11,'traductor_in_prestpaquete_cchc', 'traductor_out_prestpaquete_cchc', 'SM_CCHC');
--insert into define_secuencia_ws values ('prestpaquete', 44, 44,'traductor_in_prestpaquete_vidacamara', 'traductor_out_prestpaquete_vidacamara', 'VIDA_CAMARA');
--insert into define_secuencia_ws values ('prestpaquete', 62, 900,'traductor_in_prestpaquete_sanlorenzo', 'traductor_out_prestpaquete_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('prestpaquete', 63, 900,'traductor_in_prestpaquete_fusat', 'traductor_out_prestpaquete_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('prestpaquete', 65, 900,'traductor_in_prestpaquete_chuqui', 'traductor_out_prestpaquete_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('prestpaquete', 67, 67,'traductor_in_prestpaquete_colmena', 'traductor_out_prestpaquete_colmena', 'COLMENA');
--insert into define_secuencia_ws values ('prestpaquete', 68, 900,'traductor_in_prestpaquete_rioblanco', 'traductor_out_prestpaquete_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('prestpaquete', 71, 900,'traductor_in_prestpaquete_consalud', 'traductor_out_prestpaquete_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
--insert into define_secuencia_ws values ('prestpaquete', 76, 900,'traductor_in_prestpaquete_fundacion', 'traductor_out_prestpaquete_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('prestpaquete', 78, 78,'traductor_in_prestpaquete_cruzblanca', 'traductor_out_prestpaquete_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('prestpaquete', 80, 900,'traductor_in_prestpaquete_vidatres', 'traductor_out_prestpaquete_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
--insert into define_secuencia_ws values ('prestpaquete', 81, 81,'traductor_in_prestpaquete_ferrosalud', 'traductor_out_prestpaquete_ferrosalud', 'FERROSALUD');
--insert into define_secuencia_ws values ('prestpaquete', 88, 88,'traductor_in_prestpaquete_masvida', 'traductor_out_prestpaquete_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('prestpaquete', 94, 900,'traductor_in_prestpaquete_cruzdelnorte', 'traductor_out_prestpaquete_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('prestpaquete', 99, 900,'traductor_in_prestpaquete_banmedica', 'traductor_out_prestpaquete_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');

--SOLICFOLIOS
insert into define_secuencia_ws values ('solicfolios', 11, 11,'traductor_in_solicfolios_cchc', 'traductor_out_solicfolios_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('solicfolios', 44, 44,'traductor_in_solicfolios_vidacamara', 'traductor_out_solicfolios_vidacamara', 'VIDA_CAMARA');
insert into define_secuencia_ws values ('solicfolios', 62, 900,'traductor_in_solicfolios_sanlorenzo', 'traductor_out_solicfolios_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('solicfolios', 63, 900,'traductor_in_solicfolios_fusat', 'traductor_out_solicfolios_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('solicfolios', 65, 900,'traductor_in_solicfolios_chuqui', 'traductor_out_solicfolios_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('solicfolios', 67, 67,'traductor_in_solicfolios_colmena', 'traductor_out_solicfolios_colmena', 'COLMENA');
insert into define_secuencia_ws values ('solicfolios', 68, 900,'traductor_in_solicfolios_rioblanco', 'traductor_out_solicfolios_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('solicfolios', 71, 900,'traductor_in_solicfolios_consalud', 'traductor_out_solicfolios_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
insert into define_secuencia_ws values ('solicfolios', 76, 900,'traductor_in_solicfolios_fundacion', 'traductor_out_solicfolios_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('solicfolios', 78, 78,'traductor_in_solicfolios_cruzblanca', 'traductor_out_solicfolios_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('solicfolios', 80, 900,'traductor_in_solicfolios_vidatres', 'traductor_out_solicfolios_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('solicfolios', 81, 81,'traductor_in_solicfolios_ferrosalud', 'traductor_out_solicfolios_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('solicfolios', 88, 88,'traductor_in_solicfolios_masvida', 'traductor_out_solicfolios_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('solicfolios', 94, 900,'traductor_in_solicfolios_cruzdelnorte', 'traductor_out_solicfolios_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('solicfolios', 99, 900,'traductor_in_solicfolios_banmedica', 'traductor_out_solicfolios_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('solicfolios', 1, 100,'traductor_in_solicfolios_fonasa', 'traductor_out_solicfolios_fonasa', 'FONASA');

--VALIDACAT
--insert into define_secuencia_ws values ('validacat', 11, 11,'traductor_in_validacat_cchc', 'traductor_out_validacat_cchc', 'SM_CCHC');
--insert into define_secuencia_ws values ('validacat', 44, 44,'traductor_in_validacat_vidacamara', 'traductor_out_validacat_vidacamara', 'VIDA_CAMARA');
--insert into define_secuencia_ws values ('validacat', 62, 900,'traductor_in_validacat_sanlorenzo', 'traductor_out_validacat_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('validacat', 63, 900,'traductor_in_validacat_fusat', 'traductor_out_validacat_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('validacat', 65, 900,'traductor_in_validacat_chuqui', 'traductor_out_validacat_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('validacat', 67, 67,'traductor_in_validacat_colmena', 'traductor_out_validacat_colmena', 'COLMENA');
--insert into define_secuencia_ws values ('validacat', 68, 900,'traductor_in_validacat_rioblanco', 'traductor_out_validacat_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('validacat', 71, 900,'traductor_in_validacat_consalud', 'traductor_out_validacat_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
--insert into define_secuencia_ws values ('validacat', 76, 900,'traductor_in_validacat_fundacion', 'traductor_out_validacat_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
--insert into define_secuencia_ws values ('validacat', 78, 78,'traductor_in_validacat_cruzblanca', 'traductor_out_validacat_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('validacat', 80, 900,'traductor_in_validacat_vidatres', 'traductor_out_validacat_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
--insert into define_secuencia_ws values ('validacat', 81, 81,'traductor_in_validacat_ferrosalud', 'traductor_out_validacat_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('validacat', 88, 88,'traductor_in_validacat_masvida', 'traductor_out_validacat_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('validacat', 94, 900,'traductor_in_validacat_cruzdelnorte', 'traductor_out_validacat_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('validacat', 99, 900,'traductor_in_validacat_banmedica', 'traductor_out_validacat_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('validacat', 1, 100,'traductor_in_validacat_fonasa', 'traductor_out_validacat_fonasa', 'FONASA');

--VALORIZI
--insert into define_secuencia_ws values ('valorizi', 11, 11,'traductor_in_valorizi_cchc', 'traductor_out_valorizi_cchc', 'SM_CCHC');
--insert into define_secuencia_ws values ('valorizi', 44, 44,'traductor_in_valorizi_vidacamara', 'traductor_out_valorizi_vidacamara', 'VIDA_CAMARA');
--insert into define_secuencia_ws values ('valorizi', 62, 900,'traductor_in_valorizi_sanlorenzo', 'traductor_out_valorizi_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('valorizi', 63, 900,'traductor_in_valorizi_fusat', 'traductor_out_valorizi_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('valorizi', 65, 900,'traductor_in_valorizi_chuqui', 'traductor_out_valorizi_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('valorizi', 67, 67,'traductor_in_valorizi_colmena', 'traductor_out_valorizi_colmena', 'COLMENA');
--insert into define_secuencia_ws values ('valorizi', 68, 900,'traductor_in_valorizi_rioblanco', 'traductor_out_valorizi_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valorizi', 71, 900,'traductor_in_valorizi_consalud', 'traductor_out_valorizi_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
--insert into define_secuencia_ws values ('valorizi', 76, 900,'traductor_in_valorizi_fundacion', 'traductor_out_valorizi_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
--insert into define_secuencia_ws values ('valorizi', 78, 78,'traductor_in_valorizi_cruzblanca', 'traductor_out_valorizi_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('valorizi', 80, 900,'traductor_in_valorizi_vidatres', 'traductor_out_valorizi_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
--insert into define_secuencia_ws values ('valorizi', 81, 81,'traductor_in_valorizi_ferrosalud', 'traductor_out_valorizi_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('valorizi', 88, 88,'traductor_in_valorizi_masvida', 'traductor_out_valorizi_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('valorizi', 94, 900,'traductor_in_valorizi_cruzdelnorte', 'traductor_out_valorizi_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('valorizi', 99, 900,'traductor_in_valorizi_banmedica', 'traductor_out_valorizi_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');

--VALORVARI
insert into define_secuencia_ws values ('valorvari', 11, 11,'traductor_in_valorvari_cchc', 'traductor_out_valorvari_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('valorvari', 44, 44,'traductor_in_valorvari_vidacamara', 'traductor_out_valorvari_vidacamara', 'VIDA_CAMARA');
insert into define_secuencia_ws values ('valorvari', 62, 900,'traductor_in_valorvari_sanlorenzo', 'traductor_out_valorvari_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valorvari', 63, 900,'traductor_in_valorvari_fusat', 'traductor_out_valorvari_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valorvari', 65, 900,'traductor_in_valorvari_chuqui', 'traductor_out_valorvari_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valorvari', 67, 67,'traductor_in_valorvari_colmena', 'traductor_out_valorvari_colmena', 'COLMENA');
insert into define_secuencia_ws values ('valorvari', 68, 900,'traductor_in_valorvari_rioblanco', 'traductor_out_valorvari_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valorvari', 71, 900,'traductor_in_valorvari_consalud', 'traductor_out_valorvari_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
insert into define_secuencia_ws values ('valorvari', 76, 900,'traductor_in_valorvari_fundacion', 'traductor_out_valorvari_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('valorvari', 78, 78,'traductor_in_valorvari_fundacion', 'traductor_out_valorvari_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('valorvari', 78, 78,'traductor_in_valtrans_cruzblanca', 'traductor_out_valtrans_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('valorvari', 80, 900,'traductor_in_valorvari_vidatres', 'traductor_out_valorvari_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('valorvari', 81, 81,'traductor_in_valorvari_ferrosalud', 'traductor_out_valorvari_ferrosalud', 'FERROSALUD');
--insert into define_secuencia_ws values ('valorvari', 88, 88,'traductor_in_valorvari_masvida', 'traductor_out_valorvari_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('valorvari', 94, 900,'traductor_in_valorvari_cruzdelnorte', 'traductor_out_valorvari_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('valorvari', 99, 900,'traductor_in_valorvari_banmedica', 'traductor_out_valorvari_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');

--VALTRANS
insert into define_secuencia_ws values ('valtrans', 1, 100,'traductor_in_valtrans_fonasa', 'traductor_out_valtrans_fonasa', 'FONASA');
insert into define_secuencia_ws values ('valtrans', 11, 11,'traductor_in_valtrans_cchc', 'traductor_out_valtrans_cchc', 'SM_CCHC');
insert into define_secuencia_ws values ('valtrans', 44, 44,'traductor_in_valtrans_vidacamara', 'traductor_out_valtrans_vidacamara', 'VIDA_CAMARA');
insert into define_secuencia_ws values ('valtrans', 62, 900,'traductor_in_valtrans_sanlorenzo', 'traductor_out_valtrans_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valtrans', 63, 900,'traductor_in_valtrans_fusat', 'traductor_out_valtrans_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valtrans', 65, 900,'traductor_in_valtrans_chuqui', 'traductor_out_valtrans_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valtrans', 67, 67,'traductor_in_valtrans_colmena', 'traductor_out_valtrans_colmena', 'COLMENA');
insert into define_secuencia_ws values ('valtrans', 68, 900,'traductor_in_valtrans_rioblanco', 'traductor_out_valtrans_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('valtrans', 71, 900,'traductor_in_valtrans_consalud', 'traductor_out_valtrans_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
insert into define_secuencia_ws values ('valtrans', 76, 900,'traductor_in_valtrans_fundacion', 'traductor_out_valtrans_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('valtrans', 78, 78,'traductor_in_valtrans_cruzblanca', 'traductor_out_valtrans_cruzblanca', 'CRUZ_BLANCA');
insert into define_secuencia_ws values ('valtrans', 80, 900,'traductor_in_valtrans_vidatres', 'traductor_out_valtrans_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
insert into define_secuencia_ws values ('valtrans', 81, 81,'traductor_in_valtrans_ferrosalud', 'traductor_out_valtrans_ferrosalud', 'FERROSALUD');
insert into define_secuencia_ws values ('valtrans', 88, 88,'traductor_in_valtrans_masvida', 'traductor_out_valtrans_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('valtrans', 94, 900,'traductor_in_valtrans_cruzdelnorte', 'traductor_out_valtrans_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('valtrans', 99, 900,'traductor_in_valtrans_banmedica', 'traductor_out_valtrans_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');

--CERMENSAJEBEN
--insert into define_secuencia_ws values ('cermensajeben', 11, 11,'traductor_in_cermensajeben_cchc', 'traductor_out_cermensajeben_cchc', 'SM_CCHC');
--insert into define_secuencia_ws values ('cermensajeben', 44, 44,'traductor_in_cermensajeben_vidacamara', 'traductor_out_cermensajeben_vidacamara', 'VIDA_CAMARA');
--insert into define_secuencia_ws values ('cermensajeben', 62, 900,'traductor_in_cermensajeben_sanlorenzo', 'traductor_out_cermensajeben_sanlorenzo', 'SAN_LORENZO', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('cermensajeben', 63, 900,'traductor_in_cermensajeben_fusat', 'traductor_out_cermensajeben_fusat', 'FUSAT', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('cermensajeben', 65, 900,'traductor_in_cermensajeben_chuqui', 'traductor_out_cermensajeben_chuqui', 'CHUQUICAMATA', '127.0.0.1', 'seq_puerto_fusat');
--insert into define_secuencia_ws values ('cermensajeben', 67, 67,'traductor_in_cermensajeben_colmena', 'traductor_out_cermensajeben_colmena', 'COLMENA');
--insert into define_secuencia_ws values ('cermensajeben', 68, 900,'traductor_in_cermensajeben_rioblanco', 'traductor_out_cermensajeben_rioblanco', 'RIO_BLANCO', '127.0.0.1', 'seq_puerto_fusat');
insert into define_secuencia_ws values ('cermensajeben', 71, 900,'traductor_in_cermensajeben_consalud', 'traductor_out_cermensajeben_consalud', 'CONSALUD', '127.0.0.1', 'seq_puerto_consalud');
--insert into define_secuencia_ws values ('cermensajeben', 76, 900,'traductor_in_cermensajeben_fundacion', 'traductor_out_cermensajeben_fundacion', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('cermensajeben', 78, 78,'traductor_in_cermensajeben_cruzblanca', 'traductor_out_cermensajeben_cruzblanca', 'FUNDACION', '127.0.0.1', 'seq_puerto_fundacion');
insert into define_secuencia_ws values ('cermensajeben', 80, 900,'traductor_in_cermensajeben_vidatres', 'traductor_out_cermensajeben_vidatres', 'VIDA_TRES', '127.0.0.1', 'seq_puerto_banmedica');
--insert into define_secuencia_ws values ('cermensajeben', 81, 81,'traductor_in_cermensajeben_ferrosalud', 'traductor_out_cermensajeben_ferrosalud', 'FERROSALUD');
--insert into define_secuencia_ws values ('cermensajeben', 88, 88,'traductor_in_cermensajeben_masvida', 'traductor_out_cermensajeben_masvida', 'MAS_VIDA');
insert into define_secuencia_ws values ('cermensajeben', 94, 900,'traductor_in_cermensajeben_cruzdelnorte', 'traductor_out_cermensajeben_cruzdelnorte', 'CRUZ_DEL_NORTE', '127.0.0.1', 'seq_puerto_cruzdelnorte');
insert into define_secuencia_ws values ('cermensajeben', 99, 900,'traductor_in_cermensajeben_banmedica', 'traductor_out_cermensajeben_banmedica', 'BANMEDICA', '127.0.0.1', 'seq_puerto_banmedica');


