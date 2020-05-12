@AbapCatalog.sqlViewName: 'ZIPLANGINFO03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'PLangInfo View'
define view ZI_PLANGINFO_03 as select from zplanginfo_03 {
    //zplanginfo_03
    key langid,
    documentationhref,
    gettingstartedhref,
    age,
    operationarea,
    popularity
}
