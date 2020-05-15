@AbapCatalog.sqlViewName: 'ZIPROGLANGHSKA03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Information about programming languages'
define root view ZI_ProgrammingLanguages_HSKA03
  as select from zplanginfos_03 as ProgrammingLanguageInfo
  association [0..1] to ZI_USERAVG_03    as _UserAvarage          on $projection.langid = _UserAvarage.langid
  
  composition [0..*] of ZI_USERREVIEW_HSKA03 as _UserRating
{
  key langid,
      documentationhref,
      gettingstartedhref,
      age,
      operationarea,
      popularity,

      name,
      _UserAvarage.communityavg,
      _UserAvarage.frameworkavg,
      _UserAvarage.nativelibrariesavg,
      _UserAvarage.performanceavg,
      _UserAvarage.workflowavg,
      
      _UserRating,
      cast (_UserAvarage.performanceavg + _UserAvarage.nativelibrariesavg + _UserAvarage.communityavg + _UserAvarage.frameworkavg + _UserAvarage.workflowavg as abap.fltp(16, 16) ) / 5.0 as overall
      
}
