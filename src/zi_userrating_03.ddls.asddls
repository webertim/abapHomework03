@AbapCatalog.sqlViewName: 'ZIUSERRATING03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'UserRating View'
define view ZI_USERRATING_03 as select from zuserrating_03 {
    //zuserrating_03
    key langid,
    username,
    performancerating,
    nativrelibariesratings,
    communityrating,
    frameworkrating,
    workflowrating
}
