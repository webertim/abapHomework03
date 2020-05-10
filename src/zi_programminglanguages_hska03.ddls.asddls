@AbapCatalog.sqlViewName: 'ZIPROGLANGHSKA03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Information about programming languages'
define root view ZI_ProgrammingLanguages_HSKA03 as select from zplanginfo_03 as ProgrammingLanguageInfo
    association [1] to zplanguages_03 as _ProgrammingLanguages on $projection.langid = _ProgrammingLanguages.id
    association [1] to zuseravg_03 as _UserAvarage on $projection.langid = _UserAvarage.langid
{
  key langid,
  documentationhref,
  gettingstartedhref,
  age,
  operationarea,
  popularity,
  
  _ProgrammingLanguages,
  _UserAvarage
    
}
