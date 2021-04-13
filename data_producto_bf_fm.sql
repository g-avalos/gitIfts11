EXEC insertProducto -1,'BF','Bingo Domingon'       , 1, 'JU', 0, 'CANALVENTA', 0, 0, 0, 0, null,0,null,0,1;
EXEC insertJuegoFamilia -1,'BF','BINGO'       , 1 ;
EXEC insertJuego -1,'BF','BF',0,99;
EXEC insertRetencion -1, 'LEY1590'  ,'Retención sobre apuesta Ley 1590'          , 1, 'BF', 'PRV','APU';

EXEC insertExtracto  -1, 'BFL1' , 'Línea'                 , '90', 1, 'BF', 1, null,'BFB1';
EXEC insertExtracto  -1, 'BFL2' , 'Línea segunda ronda'   , '90', 1, 'BF', 1, null,'BFB2';
EXEC insertExtracto  -1, 'BFB1' , 'Bingo'                 , '90', 1, 'BF', 1, null,'BFB1';
EXEC insertExtracto  -1, 'BFB2' , 'Bingo segunda ronda'   , '90', 1, 'BF', 1, null,'BFB2';
EXEC insertExtracto  -1, 'BFRB' , 'Reposición de billete' , '1' , 1, 'BF', 1, null,'BFRB';
EXEC insertExtracto  -1, 'BFSB' , 'Sorteo de billete'     , '1' , 1, 'BF', 1, null,'BFSB';

EXEC insertModalidad  -1, 'BFB1' , 'Bingo'                 , '90', 1, 'BF', 'BFB1', '0', 'Bingo     ', 2,0;
EXEC insertModalidad  -1, 'BFB2' , 'Bingo segunda ronda'   , '90', 1, 'BF', 'BFB2', '1', '2da.Ronda ', 2,1;
EXEC insertModalidad  -1, 'BFRB' , 'Reposición de billete' , '1' , 1, 'BF', 'BFRB', '2', 'Reposición', 1,1;
EXEC insertModalidad  -1, 'BFSB' , 'Sorteo de billete'     , '1' , 1, 'BF', 'BFSB', '3', 'Billete   ', 5,1;


EXEC insertModalidadPremio -1,'BFB1LI'   , 'Línea'                           , '1'            ,2   ,  1, 1, 'BFB1' , 'NN';
EXEC insertModalidadPremio -1,'BFB1BI'   , 'Bingo'                           , '1'            ,2   ,  2, 1, 'BFB1' , 'NN';
EXEC insertModalidadPremio -1,'BFB2LI'   , 'Línea'                           , '1'            ,2   ,  1, 1, 'BFB2' , 'NN';
EXEC insertModalidadPremio -1,'BFB2BI'   , 'Bingo'                           , '1'            ,2   ,  2, 1, 'BFB2' , 'NN';
EXEC insertModalidadPremio -1,'BFRB'     , 'Reposición'                      , '1'            ,1   ,  1, 1, 'BFRB' , 'NN';
EXEC insertModalidadPremio -1,'BFSB'     , 'Billete'                         , '1'            ,5   ,  1, 1, 'BFSB' , 'NN';
EXEC insertModalidadPremio -1,'BFB1E'    , 'premio estimulo'                 , '1'          ,2   , 99, 1, 'BFB1'  , 'NN' ;
EXEC insertModalidadPremio -1,'BFB2E'    , 'premio estimulo'                 , '1'          ,2   , 99, 1, 'BFB2'  , 'NN' ;

EXEC insertModalidadApuesta -1, 'BFB1'    , 'BFB1', 1 ;
EXEC insertModalidadApuesta -1, 'BFB2'    , 'BFB2', 1 ;


EXEC insertProductoCanalVenta 'BF','RP' , 1;
EXEC insertProductoCanalVenta 'BF','WW' , 1;
EXEC insertProductoCanalVenta 'BF','CM' , 1;
EXEC insertProductoCanalVenta 'BF','AS' , 1;



EXEC insertProductoGrupo 'LIQMENS'                                   , 'BF',-1, 1;
EXEC insertProductoGrupo 'ESQUEMA'                                   , 'BF',-1, 1;
EXEC insertProductoGrupo 'PARAMETRO'                                 , 'BF',-1, 1;
EXEC insertProductoGrupo 'HABILITA_PARAMETRO'                        , 'BF',-1, 1;
EXEC insertProductoGrupo 'DESHACER'                                  , 'BF',-1, 1;
EXEC insertProductoGrupo 'CAPTURA_APUESTA'                           , 'BF',-1, 1;
EXEC insertProductoGrupo 'CALCULO_POZO'                              , 'BF',-1, 1;
EXEC insertProductoGrupo 'EXTRACTO'                                  , 'BF',-1, 1;
EXEC insertProductoGrupo 'IMPORTAR_PREMIO'                           , 'BF',-1, 1;
EXEC insertProductoGrupo 'LIQUIDACION_DIARIA'                        , 'BF',-1, 1;
EXEC insertProductoGrupo 'CONSULTA_ESTADO'                           , 'BF',-1, 1;
EXEC insertProductoGrupo 'LIQUIDACION_PRESCRIPTO'                    , 'BF',-1, 1;
EXEC insertProductoGrupo 'LISTADO_PRESCRIPTO'                        , 'BF',-1, 1;
EXEC insertProductoGrupo 'EXPORTAR_MARKETING_DIARIO'                 , 'BF',-1, 1;
EXEC insertProductoGrupo 'EXPORTAR_MARKETING_MENSUAL'                , 'BF',-1, 1;
EXEC insertProductoGrupo 'LISTADOS_GENERADOR'                        , 'BF',-1, 1;
EXEC insertProductoGrupo 'LISTADOS_PERIODO'                          , 'BF',-1, 1;
EXEC insertProductoGrupo 'CONSULTA_CANCELADAS'                       , 'BF',-1, 1;
EXEC insertProductoGrupo 'CONSULTA_PREMIOS'                          , 'BF',-1, 1;
EXEC insertProductoGrupo 'EXPORTACION_MARKETING_MENSUAL'             , 'BF',-1, 1;
EXEC insertProductoGrupo 'CONSULTA_PV'                               , 'BF',-1, 1;


EXEC insertProductoProvincia 'BF', 'FM', 0, 0.00, 0.0, 0.00;

--NPI
--EXEC insertProcesadorConfig 'LIQ_DIARIA', 'JUEGO_PRELIQUIDADOR_QU'   , 'BF', 1, 1 ;
--EXEC insertProcesadorConfig 'LIQ_DIARIA', 'JUEGO_COMISIONADOR_CV'    , 'BF', 2, 1 ;
--EXEC insertProcesadorConfig 'LIQ_DIARIA', 'JUEGO_POSLIQUIDADOR'      , 'BF', 3, 1 ;
EXEC insertProcesadorConfig 'LIQ_PRESCR', 'JUEGO_PRESC_GENERADOR'    , 'BF', 1, 1 ;
EXEC insertProcesadorConfig 'LIQ_PRESCR', 'JUEGO_PRESC_LIQUIDADOR'   , 'BF', 2, 1 ;

--EXEC insertDesgloseConfig 'SINDESGLO', 'JUEGO_PRELIQUIDADOR_BF'    , 'BF', 1;

--exec insertPropiedadCustom NULL, 'LIQUIDACION_DIARIA', 'PRELIQ_DIVIDIR_APUESTA_POR_MODALIDAD' , 'true', 0, 'BF', NULL;

EXEC insertPlantilla 'BF0000001', 'BF por defecto', 1, 'BF';

EXEC insertPlantillaDetalle 'esquema.bf.minimoValidacionPago'                    , 'Monto minimo para validacion de pago' ,1 , 'BF0000001',  'Datos Generales';
EXEC insertPlantillaDetalle 'esquema.bf.minimoUif'                               , 'Mínimo UIF'                           ,1 , 'BF0000001',  'Otros';


EXEC insertRetencion -1, 'LEY20630' ,'Ley 20630'         , 1, 'BF', 'NAC';
EXEC insertRetencion -1, 'LEY23351' ,'Ley 23351'         , 1, 'BF', 'NAC';
EXEC insertRetencion -1, 'LEY24800' ,'Ley 24800'         , 1, 'BF', 'NAC';


EXEC insertPlantillaDetalle 'esquema.bf.seccion_datos_basicos'                   , 'Datos basicos'                        ,1 , 'BF0000001',  'Configuración Datos Básicos';
EXEC insertPlantillaDetalle 'esquema.bf.sorteo'                                  , 'Sorteo'                               ,1 , 'BF0000001',  'Configuración Datos Básicos';
EXEC insertPlantillaDetalle 'esquema.bf.fechaSorteo'                             , 'Fecha Sorteo'                         ,1 , 'BF0000001',  'Configuración Datos Básicos';
EXEC insertPlantillaDetalle 'esquema.bf.horaSorteo'                              , 'Hora de Sorteo'                       ,1 , 'BF0000001',  'Configuración Datos Básicos'; 
EXEC insertPlantillaDetalle 'esquema.bf.horaCierre'                              , 'Hora de cierre'                       ,1 , 'BF0000001',  'Configuración Datos Básicos'; 
EXEC insertPlantillaDetalle 'esquema.bf.fechaPrescripcion'                       , 'Fecha de Prescripción'                ,1 , 'BF0000001',  'Configuración Datos Básicos';
EXEC insertPlantillaDetalle 'esquema.bf.fechaProximoSorteo'                      , 'Fecha de Próximo Sorteo'              ,1 , 'BF0000001',  'Configuración Datos Básicos';
EXEC insertPlantillaDetalle 'esquema.bf.horaProximoSorteo'                       , 'Hora de Próximo Sorteo'               ,1 , 'BF0000001',  'Configuración Datos Básicos';

EXEC insertPlantillaDetalle 'esquema.bf.seccion_liquidacion'                     , 'Configuración Liquidación'            ,1 , 'BF0000001',  'Configuración Liquidación'  ;
EXEC insertPlantillaDetalle 'esquema.bf.seccion_liquidacion_canal_venta'         , 'Configuración Liquidación por CV'     ,1 , 'BF0000001',  'Configuración Liquidación'  ;
EXEC insertPlantillaDetalle 'esquema.bf.seccion_liquidacion_adicional'           , 'Configuración Liquidación adicional'  ,0 , 'BF0000001',  'Configuración Liquidación'  ;
EXEC insertPlantillaDetalle 'esquema.bf.iibb'                                    , 'Ingresos brutos'                      ,1 , 'BF0000001',  'Configuración Liquidación'  ;

EXEC insertPlantillaDetalle 'esquema.bf.seccion_configuracion_otra'              , 'Otras configuraciones'                ,1 , 'BF0000001',  'Otras configuraciones'      ;
EXEC insertPlantillaDetalle 'esquema.bf.topePagoAge'                             , 'Tope de pago por agencia'             ,1 , 'BF0000001',  'Otras configuraciones'      ;

EXEC insertPlantillaDetalle 'esquema.bf.seccion_configuracion_jugada'            , 'Configuracion de jugadas'             ,1 , 'BF0000001',  'Configuración jugadas'      ;
EXEC insertPlantillaDetalle 'esquema.bf.rango'                                   , 'Rango de apuesta'                     ,1 , 'BF0000001',  'Configuración jugadas'      ;

EXEC insertPlantillaDetalle 'esquema.bf.seccion_configuracion_juego'             , 'Configuración Juego'                  ,1 , 'BF0000001',  'Configuración Juego'      ;
EXEC insertPlantillaDetalle 'esquema.bf.porcentajeFondoReservaVacante'           , 'Porc. Fondo Reserva Vacante'           ,1 , 'BF0000001',  'Configuración Juego'      ;
EXEC insertPlantillaDetalle 'esquema.bf.pozoPorcentajePremio'                    , 'Pozo Porc. Premio'                     ,1 , 'BF0000001',  'Configuración Juego'      ;
EXEC insertPlantillaDetalle 'esquema.bf.pozoInicial'                             , 'Pozo inicial'                          ,1 , 'BF0000001',  'Configuración Juego'      ;
EXEC insertPlantillaDetalle 'esquema.bf.importeApuesta'                          , 'Importe apuesta'                      ,1 , 'BF0000001',  'Configuración Juego'        ;

EXEC insertPlantillaDetalle 'esquema.bf.seccion_configuracion_premios'           , 'Configuración premios'                ,1 , 'BF0000001',  'Configuración premios'      ;
EXEC insertPlantillaDetalle 'esquema.bf.minimoImponible'                         , 'Minimo imponible'                     ,1 , 'BF0000001',  'Configuración premios'      ;
EXEC insertPlantillaDetalle 'esquema.bf.imponible'                               , 'Imponible'                            ,1 , 'BF0000001',  'Configuración premios'      ;
EXEC insertPlantillaDetalle 'esquema.bf.ley20630'                                , 'Ley 20630'                            ,1 , 'BF0000001',  'Configuración premios'      ;
EXEC insertPlantillaDetalle 'esquema.bf.ley23351'                                , 'Ley 23351'                            ,1 , 'BF0000001',  'Configuración premios'      ;
EXEC insertPlantillaDetalle 'esquema.bf.ley24800'                                , 'Ley 24800'                            ,1 , 'BF0000001',  'Configuración premios'      ;
EXEC insertPlantillaDetalle 'esquema.bf.arancelImporte'                          , 'Arancel'                              ,1 , 'BF0000001',  'Impuestos sobre jugadas';
EXEC insertPlantillaDetalle 'esquema.bf.LEY1590'                                 , 'Ley 1590'                             ,1 , 'BF0000001',  'Impuestos sobre jugadas';

EXEC insertExportador 'CCFOR', 'Cuenta Corriente', '/exportar/ccFormosa', 3, 'BF', 1;
EXEC insertExportador 'ASFOR', 'Exportar Archivos para Sorteador', '/exportar/archivosSorteador', 1, 'BF', 1;

EXEC insertProcesoConfiguracion 'BFFM','POCEADO_CON_E','FM','BF'

-- Captura
EXEC insertListado 'LISPAR'	    , 'Parámetro del Sorteo'                                , '/listados/ParametrosxJuego'                          , 1 , 'BF', 1,'';
-- Pozo
EXEC insertListado 'TOTSOR'	    , 'Totales generales del sorteo'                        , '/listados/totalesGeneralesDelSorteo'                 , 2 , 'BF', 1, 'FM/totalesGeneralesSorteoBF.jrxml';
--Busqueda
--EXEC insertListado 'EXTRACTO'	, 'Extracto del Sorteo'                                 , '/listados/extractoPdf'                               , 3 , 'BF', 1;
EXEC insertListado 'LISPREPA'	, 'Premios a pagar por tipo de sistema'                 , '/listados/premiosAPagarSantaFe'                      , 3 , 'BF', 1;
--EXEC insertListado 'CUGAAGSU'	, 'Cupones ganadores por agencia y subagencia'          , '/listados/cuponesganadoresagente'		            , 3 , 'BF', 1;
EXEC insertListado 'LPREMIOS'	, 'Premios con retención impositiva'                    , '/listados/premiosConRetencionImpositiva'             , 3 , 'BF', 1;
--PosLiquidacion
EXEC insertListado 'BALAGE'	    , 'Afectaciones de agentes por delegación'              , '/listados/afectacionesAgentePorDelegacion'           , 4 , 'BF', 1, 'FM/afectacionesPorDelegacionModalidad.jrxml';
EXEC insertListado 'BALPV'	    , 'Afectaciones de puntos de venta por delegación'      , '/listados/afectacionesPVPorDelegacion'               , 4 , 'BF', 1, 'FM/afectacionesPorDelegacionModalidad.jrxml';
EXEC insertListado 'L23'	    , 'Estadísticas de premios y aciertos'                  , '/listados/l23'                                       , 4 , 'BF', 1, 'FM/premiosAciertos.jrxml';
EXEC insertListado 'L25'	    , 'Cuadro de ganancias y perdidas'                      , '/listados/l25'                                       , 4 , 'BF', 1, 'FM/gananciasYPerdidasQXPF.jrxml';
EXEC insertListado 'MEMO_JUEGO_SORTEO'	    , 'Memo Juego Sorteo'                       , '/listados/memosJuegoSorteo'                          , 4 , 'BF', 1;

EXEC insertExportador 'MARKETING', 'Exportacion a Marketing', '/exportar/marketingDiario', 3, 'BF', 1;
EXEC insertExportador 'CCFOR', 'Cuenta Corriente', '/exportar/ccFormosa', 3, 'BF', 1;
EXEC insertExportador 'PSISCAP', 'Premios Sistema de captura', '/exportar/premiados', 2, 'BF', 1;
EXEC insertExportador 'ESISCAP', 'Extractos Sistema de captura', '/exportar/extracto', 2, 'BF', 1;

exec insertPropiedadCustom NULL, 'PREMIO_POZO', @propiedadCodigo = 'DESCUENTA_PREMIOS' , @valor = 'true'                , @forceUpdate = 1, @productoCodigo = 'BF', @provinciaCodigo = 'FM' ;
