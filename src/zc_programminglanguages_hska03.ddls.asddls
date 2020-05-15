@EndUserText.label: 'Projection View for Programming Language'
@AccessControl.authorizationCheck: #CHECK

@UI: {
 headerInfo: { typeName: 'Programming Language', typeNamePlural: 'Programming Languages', title: { type: #STANDARD, value: 'Name' } } }

@Search.searchable: true

define root view entity ZC_PROGRAMMINGLANGUAGES_HSKA03
  as projection on ZI_ProgrammingLanguages_HSKA03
{


      @UI.facet: [ { id:              'ProgrammingLanguageInfo',
                       purpose:         #STANDARD,
                       type:            #IDENTIFICATION_REFERENCE,
                       position:        10,
                       label: 'Details'},

                   { id:               'UserRating',
                     label:            'User Reviews',
                     type:             #LINEITEM_REFERENCE,
                     position:         20,
                     targetElement:    '_UserRating' }]



      @UI: {
                 lineItem:       [ { position: 10, importance: #HIGH } ],
                 identification: [ { position: 10, label: 'LanguageID'} ] }

      @UI.hidden: true

  key langid             as ID,

      @UI: {
               identification: [ { position: 70, label: 'Documentation Link', type: #WITH_URL, url: 'DocumentationLink'} ] }
      documentationhref  as DocumentationLink,

      @UI: {
               identification: [ { position: 60, label: 'Getting-Started Link', type: #WITH_URL, url: 'GettingStartedLink'} ]}
      gettingstartedhref as GettingStartedLink,

      @UI: {
               lineItem:       [ { position: 40, label: 'Release Date', importance: #HIGH, value: 'CreationDate'} ],
               identification: [ { position: 40, label: 'Release Date'} ],
               selectionField: [ { position: 40 } ] }
      age                as CreationDate,

      @UI: {
               lineItem:       [ { position: 30, label: 'Usage', importance: #HIGH } ],
               identification: [ { position: 30, label: 'Usage'} ],
               selectionField: [ { position: 30 } ] }
      operationarea      as OperationArea,

      @UI: {
               lineItem:       [ { position: 50, importance: #HIGH },
               { type: #FOR_ACTION, dataAction: 'updatePopulatrity', label: 'Update Popularity' } ],
               identification: [ { position: 50, label: 'Popularity'} ] }
              
      popularity         as Popularity,


      @UI: {
                     lineItem:       [ { position: 10, label: 'Language Name', importance: #HIGH } ],
                     identification: [ { position: 10, label: 'Language Name'} ],
                     selectionField: [ { position: 10 } ] }
      //@Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_PLANGINFO_03', element: 'name'  } }]

      @Search.defaultSearchElement: true
      name               as Name,
      
      @UI: {
               lineItem:       [ { position: 75, importance: #HIGH, type: #AS_DATAPOINT } ],
               dataPoint: { title: 'Overall Rating', 
                        valueFormat.numberOfFractionalDigits: 2,
                        visualization: #RATING,
                        targetValue: 5 } }
      overall,

      @UI: {
               lineItem:       [ { position: 80, importance: #HIGH, type: #AS_DATAPOINT } ],
               dataPoint: { title: 'Performance Rating', 
                        valueFormat.numberOfFractionalDigits: 2,
                        visualization: #RATING,
                        targetValue: 5 } }
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_USERAVG_03', element: 'performanceavg'  } }]


      performanceavg     as PerformanceAvarage,

      @UI: {
               lineItem:       [ { position: 90, importance: #HIGH, type: #AS_DATAPOINT } ],
               dataPoint: { title: 'Native Rating', 
                        valueFormat.numberOfFractionalDigits: 2,
                        visualization: #RATING,
                        targetValue: 5 }}
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_USERAVG_03', element: 'nativelibrariesavg'  } }]

      nativelibrariesavg as NativeLibrariesAvarage,

      @UI: {
               lineItem:       [ { position: 100, importance: #HIGH, type: #AS_DATAPOINT } ],
               dataPoint: { title: 'Framework Rating', 
                        valueFormat.numberOfFractionalDigits: 2,
                        visualization: #RATING,
                        targetValue: 5 }}
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_USERAVG_03', element: 'frameworkavg'  } }]

      frameworkavg       as FrameworkAvarage,

      @UI: {
               lineItem:       [ { position: 110, importance: #HIGH, type: #AS_DATAPOINT } ],
               dataPoint: { title: 'Workflow Rating', 
                        valueFormat.numberOfFractionalDigits: 2,
                        visualization: #RATING,
                        targetValue: 5 }}
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_USERAVG_03', element: 'workflowavg'  } }]

      workflowavg        as WorkflowAvarage,

      @UI: {
               lineItem:       [ { position: 120, importance: #HIGH, type: #AS_DATAPOINT } ],
               dataPoint: { title: 'Community Rating', 
                        valueFormat.numberOfFractionalDigits: 2,
                        visualization: #RATING,
                        targetValue: 5 }}
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_USERAVG_03', element: 'communityavg'  } }]

      communityavg       as CommunityAvarage,
      
      _UserRating : redirected to composition child ZC_USERREVIEW_HSKA03

}
