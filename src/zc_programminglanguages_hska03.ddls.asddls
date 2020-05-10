@EndUserText.label: 'Projection View for Programming Language'
@AccessControl.authorizationCheck: #CHECK

@UI: {
 headerInfo: { typeName: 'Programming Language', typeNamePlural: 'Programming Languages', title: { type: #STANDARD, value: 'ID' } } }

@Search.searchable: true

define root view entity ZC_PROGRAMMINGLANGUAGES_HSKA03
  as projection on ZI_ProgrammingLanguages_HSKA03
{

      @UI.facet: [ { id:              'ProgrammingLanguageInfo',
                       purpose:         #STANDARD,
                       type:            #IDENTIFICATION_REFERENCE,
                       label:           'Programming Language',
                       position:        10 } ]


      @UI: {
                 lineItem:       [ { position: 10, importance: #HIGH } ],
                 identification: [ { position: 10 , label: 'LanguageID'} ] }

  key langid                          as ID,

      @UI: {
               lineItem:       [ { position: 70, importance: #HIGH } ],
               identification: [ { position: 70 , label: 'DocumentationLink'} ] }
      documentationhref               as DocumentationLink,

      @UI: {
               lineItem:       [ { position: 60, importance: #HIGH } ],
               identification: [ { position: 60 , label: 'GettingStartedLink'} ] }
      gettingstartedhref              as GettingStartedLink,

      @UI: {
               lineItem:       [ { position: 40, importance: #HIGH } ],
               identification: [ { position: 40 ,label: 'CreationDate'} ],
               selectionField: [ { position: 40 } ] }
      age                             as CreationDate,

      @UI: {
               lineItem:       [ { position: 30, importance: #HIGH } ],
               identification: [ { position: 30 , label: 'OperationArea'} ],
               selectionField: [ { position: 30 } ] }
      operationarea                   as OperationArea,

      @UI: {
               lineItem:       [ { position: 50, importance: #HIGH } ],
               identification: [ { position: 50 , label: 'Popularity'} ] }
      popularity                      as Popularity,


      @UI: {
                     lineItem:       [ { position: 20, importance: #HIGH } ],
                     identification: [ { position: 20 , label: 'Name'} ],
                     selectionField: [ { position: 20 } ] }
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZPLANGUAGES_03', element: 'name'  } }]
     
      @Search.defaultSearchElement: true
      name      as Name,

      @UI: {
               lineItem:       [ { position: 80, importance: #HIGH } ],
               identification: [ { position: 80 , label: 'PerformanceAverage' } ] }
      --@Consumption.valueHelpDefinition: [{ entity : {name: 'ZUSERAVG_03', element: 'performanceavg'  } }]
       
      performanceavg     as PerformanceAvarage,

      @UI: {
               lineItem:       [ { position: 90, importance: #HIGH } ],
               identification: [ { position: 90 , label: 'NativeLibrariesAverage' } ] }
      --@Consumption.valueHelpDefinition: [{ entity : {name: 'ZUSERAVG_03', element: 'nativelibrariesavg'  } }]

      nativelibrariesavg as NativeLibrariesAvarage,

      @UI: {
               lineItem:       [ { position: 100, importance: #HIGH } ],
               identification: [ { position: 100 , label: 'FrameworkAverage' } ] }
      --@Consumption.valueHelpDefinition: [{ entity : {name: 'ZUSERAVG_03', element: 'frameworkavg'  } }]

      frameworkavg       as FrameworkAvarage,

      @UI: {
               lineItem:       [ { position: 110, importance: #HIGH } ],
               identification: [ { position: 110 , label: 'WorkflowAverage' } ] }
      --@Consumption.valueHelpDefinition: [{ entity : {name: 'ZUSERAVG_03', element: 'workflowavg'  } }]

      workflowavg        as WorkflowAvarage,

      @UI: {
               lineItem:       [ { position: 120, importance: #HIGH } ],
               identification: [ { position: 120 , label: 'CommunityAverage' } ] }
      --@Consumption.valueHelpDefinition: [{ entity : {name: 'ZUSERAVG_03', element: 'communityavg'  } }]

      communityavg       as CommunityAvarage


}
