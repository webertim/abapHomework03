@AbapCatalog.sqlViewName: 'ZIUSERREVSHSKA03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS for user reviews'
define root view ZI_USERREVIEW_HSKA03
  as select from zuserrating_03
  association [1] to zplanguages_03 as _ProgrammingLanguages on $projection.langid = _ProgrammingLanguages.id
{
  key langid,
      username,
      performancerating,
      nativrelibariesratings,
      communityrating,
      frameworkrating,
      workflowrating,

      _ProgrammingLanguages
}
