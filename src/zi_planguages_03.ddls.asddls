@AbapCatalog.sqlViewName: 'ZIPLANGUAGES03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Planguages View'
define view ZI_PLANGUAGES_03 as select from zplanguages_03 
{

    //zplanguages_03
    key langid,
    name
}
