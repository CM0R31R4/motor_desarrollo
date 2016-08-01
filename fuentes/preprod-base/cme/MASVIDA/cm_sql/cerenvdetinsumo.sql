locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> Name	Owner	Type	Created_datetime
CERENVDETINSUMO	dbo	stored procedure	sep 10 2013 04:55
(1 row affected)
Parameter_name		Type	Length	Prec	Scale	Param_order	Collation
@CtaCorrRegistro	numeric	5	4	0	1	NULL
@CtaCodFinanciador	numeric	5	3	0	2	NULL
@CtaRutConvenio		char	12	12	NULL	3	SQL_Latin1_General_CP1_CI_AS
@CtaNumCta		char	12	12	NULL	4	SQL_Latin1_General_CP1_CI_AS
@CtaNumCobro		numeric	5	5	0	5	NULL
@CtaTipEnvio		tinyint	1	3	0	6	NULL
@CtaCodIntervenPtd	char	12	12	NULL	7	SQL_Latin1_General_CP1_CI_AS
@CtaDescIntervenPtd	char	120	120	NULL	8	SQL_Latin1_General_CP1_CI_AS
@CtaCodIntervenHom	char	12	12	NULL	9	SQL_Latin1_General_CP1_CI_AS
@CtaNroIntenven		numeric	5	2	0	10	NULL
@CtaTipoVal		tinyint	1	3	0	11	NULL
@CtaFecAtencion		datetime	8	23	3	12	NULL
@CtaHoraAtencion	char	5	5	NULL	13	SQL_Latin1_General_CP1_CI_AS
@CtaTipoDet		tinyint	1	3	0	14	NULL
@CtaUrgencia		char	1	1	NULL	15	SQL_Latin1_General_CP1_CI_AS
@CtaRecargoHora		char	1	1	NULL	16	SQL_Latin1_General_CP1_CI_AS
@CtaOrigenAten		char	1	1	NULL	17	SQL_Latin1_General_CP1_CI_AS
@CtaCodInsumo		char	15	15	NULL	18	SQL_Latin1_General_CP1_CI_AS
@CtaDescInsumo		char	120	120	NULL	19	SQL_Latin1_General_CP1_CI_AS
@CtaCodInsumoHom	char	15	15	NULL	20	SQL_Latin1_General_CP1_CI_AS
@CtaCantidadIns		numeric	5	5	2	21	NULL
@CtaTipoMov		tinyint	1	3	0	22	NULL
@CtaMtoTotal		numeric	9	10	0	23	NULL
@CtaMtoAfecto		numeric	9	10	0	24	NULL
@CtaMtoExento		numeric	9	10	0	25	NULL
@CtaMtoIva		numeric	9	10	0	26	NULL
@@CtaMtoRecargoHorario	numeric	9	10	0	27	NULL
@CtaRutFacturador	char	12	12	NULL	28	SQL_Latin1_General_CP1_CI_AS
@CtaNombreFacturador	char	40	40	NULL	29	SQL_Latin1_General_CP1_CI_AS
@CtaIndBonificable	char	1	1	NULL	30	SQL_Latin1_General_CP1_CI_AS

@CtaCodError		char	1	1	NULL	31	SQL_Latin1_General_CP1_CI_AS
@CtaMensajeError	char	60	60	NULL	32	SQL_Latin1_General_CP1_CI_AS
(32 rows affected)
(return status = 0)
1> 
