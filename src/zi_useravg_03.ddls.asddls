@AbapCatalog.sqlViewName: 'ZIUSERSVG03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'useravg View'
define view ZI_USERAVG_03 as select from zuseravg_03 
 {
    //zuseravg_03
    key langid,
    performanceavg,
    nativelibrariesavg,
    communityavg,
    frameworkavg,
    workflowavg
}
