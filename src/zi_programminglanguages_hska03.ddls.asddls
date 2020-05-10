@AbapCatalog.sqlViewName: 'ZIPROGLANGHSKA03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Information about programming languages'
define root view ZI_ProgrammingLanguages_HSKA03
  as select from zplanginfo_03 as ProgrammingLanguageInfo
  join zplanguages_03 as _ProgrammingLanguages on ProgrammingLanguageInfo.langid = _ProgrammingLanguages.id
  join zuseravg_03    as _UserAvarage          on ProgrammingLanguageInfo.langid = _UserAvarage.langid
{
  key ProgrammingLanguageInfo.langid,
      documentationhref,
      gettingstartedhref,
      age,
      operationarea,
      popularity,

      _ProgrammingLanguages.name,
      _UserAvarage.communityavg,
      _UserAvarage.frameworkavg,
      _UserAvarage.nativelibrariesavg,
      _UserAvarage.performanceavg,
      _UserAvarage.workflowavg
}
