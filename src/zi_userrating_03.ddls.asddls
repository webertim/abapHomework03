@AbapCatalog.sqlViewName: 'ZIUSERRATING03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'UserRating View'
define view ZI_USERRATING_03
  as select from zuserrating_03
  association to ZI_PLANGUAGES_03 as _Planguages on $projection.langid = _Planguages.langid
{
      //zuserrating_03
  key langid,
      _Planguages.name,
      username,
      performancerating,
      nativrelibariesratings,
      communityrating,
      frameworkrating,
      workflowrating
}
