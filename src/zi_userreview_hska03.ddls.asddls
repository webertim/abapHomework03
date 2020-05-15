@AbapCatalog.sqlViewName: 'ZIUSERREVSHSKA03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS for user reviews'
define view ZI_USERREVIEW_HSKA03
  as select from zuserratings_03 as UserRating
  association [1..1] to ZI_PLANGINFO_03 as _PLangInfo on $projection.langid = _PLangInfo.langid
  
  association to parent ZI_ProgrammingLanguages_HSKA03 as _ProgrammingLanguages on $projection.langid = _ProgrammingLanguages.langid
{

      //zuserrating_03
  key langid,
  key username,
      _PLangInfo,
      performancerating,
      nativrelibariesratings,
      communityrating,
      frameworkrating,
      workflowrating,
      cast (performancerating + nativrelibariesratings + communityrating + frameworkrating + workflowrating as abap.fltp(16, 16) ) / 5.0 as overall,
      
      _ProgrammingLanguages
}
