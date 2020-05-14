@AbapCatalog.sqlViewName: 'ZIUSERRATING03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'UserRating View'
define view ZI_USERRATING_03
  as select from zuserratings_03
  association to ZI_PLANGINFO_03 as _Planguages on $projection.langid = _Planguages.langid
{
      //zuserrating_03
  key langid,
  key username,
      _Planguages.name,
      performancerating,
      nativrelibariesratings,
      communityrating,
      frameworkrating,
      workflowrating
}
