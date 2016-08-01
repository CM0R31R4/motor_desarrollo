//gsoap ns1 service name: MCWebSdxWS 
//gsoap ns1 service namespace: http://www.multicaja.cl/sodexho/MCWebSdxWS.wsdl
//gsoap ns1 service location: http://192.168.1.10:7023
//gsoap ns1 service executable:
//gsoap ns1 service encoding: encoded
//gsoap ns1 schema namespace: urn: MCWebSdxWS





struct ns1__WSInputActivacionTarjeta
{
    int                                  sTipoId                        1;	///< Required element.
    char*                                sValorId                       1;	///< Required element.
    int                                  sServicio                      1;	///< Required element.
    char*                                sCliente                       1;	///< Required element.
    int                                  __sizesTarjetas                1;
    struct ns1__ListTarjetas*            sTarjetas                      1;
};

struct ns1__ActivacionTarjeta
{
    struct ns1__WSInputActivacionTarjeta*  arg0                           0;	///< Optional element.
};

struct ns1__ListTarjetas
{
    char*                                Tarjeta                        1;	///< Required element.
};




struct ns1__outputWSActivacionTarjeta
{
   int                                  __sizelistaTrjOut              0;
   struct ns1__listTrjOut*              listaTrjOut                    0;	///< Nullable pointer.
    char*                                SGlosaStatus                   0;	///< Optional element.
    int                                  SStatusMsg                     1;	///< Required element.
};

struct ns1__ActivacionTarjetaResponse
{
    struct ns1__outputWSActivacionTarjeta*  return_                        0;	///< Optional element.
};

struct ns1__listTrjOut
{
    char*                                SStatusTarjeta                 0;	///< Optional element.
    char*                                STarjeta                       0;	///< Optional element.
};

//---------------------------------------------------------------------------------------------------------------




struct ns1__WSInputSaldoTrx
{
    int                                  S_USCORETipo_USCOREID          1;	///< Required element.
    char*                                S_USCOREValor_USCOREID         1;	///< Required element.
    int                                  S_USCOREServicio               1;	///< Required element.
    char*                                S_USCORECliente                1;	///< Required element.
};

struct ns1__ConsultaSaldoYTrxDiaPorAfiliado
{
    struct ns1__WSInputSaldoTrx*         arg0                           0;	///< Optional element.
};





struct ns1__rsspSaldoTrxAfiliad
{
    char*                                SFecha                         0;	///< Optional element.
    char*                                SIdConsumo                     0;	///< Optional element.
    LONG64                               SMonto                         1;	///< Required element.
    char*                                SRutBenef                      0;	///< Optional element.
    int                                  SStatusTrx                     1;	///< Required element.
    char*                                STarjeta                       0;	///< Optional element.
    int                                  STipo                          1;	///< Required element.
};

struct ns1__outputWSSaldoTrxAfiliad
{
    char*                                SGlosaStatus                   0;	///< Optional element.
    int                                  SStatus                        1;	///< Required element.
   int                                  __sizetrxsAfiliado             0;
    struct ns1__rsspSaldoTrxAfiliad*     trxsAfiliado                   0;	///< Nullable pointer.
};

struct ns1__ConsultaSaldoYTrxDiaPorAfiliadoResponse
{

    struct ns1__outputWSSaldoTrxAfiliad*  return_                        0;	///< Optional element.
};

//------------------------------------------------------------------------------------------------------

struct ns1__ConsultaSaldoYTrxDiaPorBeneficiario
{
    struct ns1__WSInputSaldoTrx*         arg0                           0;	///< Optional element.
};

struct ns1__rsspSaldoTrxBenef
{
    char*                                SFecha                         0;	///< Optional element.
    char*                                SIdConsumo                     0;	///< Optional element.
    LONG64                               SMonto                         1;	///< Required element.
    char*                                STarjeta                       0;	///< Optional element.
    int                                  STipo                          1;	///< Required element.
};

struct ns1__outputWSSaldoTrxBenef
{
    char*                                SGlosaStatus                   0;	///< Optional element.
    int                                  SSaldoDisp                     1;	///< Required element.
    int                                  SSaldoVenc                     1;	///< Required element.
    int                                  SStatus                        1;	///< Required element.
   int                                  __sizetrxsBeneficiario         0;
    struct ns1__rsspSaldoTrxBenef*       trxsBeneficiario               0;	///< Nullable pointer.
};

struct ns1__ConsultaSaldoYTrxDiaPorBeneficiarioResponse
{
    struct ns1__outputWSSaldoTrxBenef*   return_                        0;	///< Optional element.
};




//------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------


int __ns1__ActivacionTarjeta(
    struct ns1__ActivacionTarjeta*      ns1__ActivacionTarjeta,	///< Request parameter
    struct ns1__ActivacionTarjetaResponse* ns1__ActivacionTarjetaResponse	///< Response parameter
);



int __ns1__ConsultaSaldoYTrxDiaPorAfiliado(
    struct ns1__ConsultaSaldoYTrxDiaPorAfiliado* ns1__ConsultaSaldoYTrxDiaPorAfiliado,	///< Request parameter
    struct ns1__ConsultaSaldoYTrxDiaPorAfiliadoResponse* ns1__ConsultaSaldoYTrxDiaPorAfiliadoResponse	///< Response parameter
);


int __ns1__ConsultaSaldoYTrxDiaPorBeneficiario(
    struct ns1__ConsultaSaldoYTrxDiaPorBeneficiario* ns1__ConsultaSaldoYTrxDiaPorBeneficiario,	///< Request parameter
    struct ns1__ConsultaSaldoYTrxDiaPorBeneficiarioResponse* ns1__ConsultaSaldoYTrxDiaPorBeneficiarioResponse	///< Response parameter
);
