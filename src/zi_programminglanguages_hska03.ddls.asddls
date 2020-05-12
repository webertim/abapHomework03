@AbapCatalog.sqlViewName: 'ZIPROGLANGHSKA03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Information about programming languages'
define root view ZI_PROGRAMMINGLANGUAGES_HSKA03
  as select from zplanginfo_03 as ProgrammingLanguageInfo
  association [1] to ZI_USERAVG_03    as _UserAvarage on $projection.langid = _UserAvarage.langid
  association [1] to ZI_PLANGUAGES_03 as _PLanguages on $projection.langid = _PLanguages.langid
{

  key ProgrammingLanguageInfo.langid,
      documentationhref,
      gettingstartedhref,
      age,
      operationarea,
      popularity,

      _PLanguages.name,
      
      _UserAvarage.communityavg,
      _UserAvarage.frameworkavg,
      _UserAvarage.nativelibrariesavg,
      _UserAvarage.performanceavg,
      _UserAvarage.workflowavg
      
}
