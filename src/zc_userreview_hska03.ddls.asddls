@EndUserText.label: 'Rating Platform'
@AccessControl.authorizationCheck: #CHECK

@UI: {
 headerInfo: { typeName: 'Rating', typeNamePlural: 'Ratings', title: { type: #STANDARD, value: 'username' } } }

@Search.searchable: false
define view entity ZC_USERREVIEW_HSKA03
  as projection on ZI_USERREVIEW_HSKA03
{
      //ZI_USERREVIEW_HSKA03
      @UI.facet: [ { id:              'ProgrammingLanguageInfo',
                       purpose:         #STANDARD,
                       type:            #IDENTIFICATION_REFERENCE,
                       position:        10,
                       label: 'Review'},
                       { id : 'idHeader' ,
                        type: #DATAPOINT_REFERENCE , position: 10,
                        label: 'Header' ,
                        purpose: #HEADER ,
                        targetQualifier: 'overall' }]



      @UI: {
              
                 identification: [ { position: 10 , label: 'Select Language'} ] }

      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_PLANGINFO_03', element: 'langid'  } }]
     key langid,
     
          
     @UI: {
               lineItem:       [ { position: 30, label: 'Username', importance: #HIGH } ],
               identification: [ { position: 30, label: 'Username'} ] }       
     key username,
     
     @UI: {
               lineItem:       [ { position: 20, label: 'Language Name', importance: #HIGH } ],
               identification: [ { position: 20, label: 'Language Name'} ] }
     @Search.defaultSearchElement: true
     @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_PLANGINFO_03', element: 'name'  } }]
     _PLangInfo.name,
     
     @UI: {
               lineItem:       [ { position: 20, importance: #HIGH } ],
               identification: [ { position: 20 , label: 'LanguageID'} ] }
     @Search.defaultSearchElement: true
     @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_PLANGINFO_03', element: 'foreignLangid'  } }]
     @UI.hidden: true
     _PLangInfo.langid as LangInfoKey,
     

      
      @UI: {
               lineItem:       [ { position: 40, importance: #HIGH, type: #AS_DATAPOINT } ],
               dataPoint: { title: 'Overall',
                        visualization: #RATING,
                        targetValue: 5 } }
     overall,
      
      @UI: {
               lineItem:       [ { position: 50, importance: #HIGH, type: #AS_DATAPOINT } ],
               identification: [ { position: 50 , label: 'Community'} ],
               dataPoint: { title: 'Community Rating',
                        visualization: #RATING,
                        targetValue: 5 } }
     communityrating,
     
     @UI: {
               lineItem:       [ { position: 60, importance: #HIGH, type: #AS_DATAPOINT } ],
               identification: [ { position: 60 , label: 'Framework'} ],
               dataPoint: { title: 'Framework Rating',
                        visualization: #RATING,
                        targetValue: 5 } }
     frameworkrating,
     
     @UI: {
               lineItem:       [ { position: 70, importance: #HIGH , type: #AS_DATAPOINT} ],
               identification: [ { position: 70 , label: 'Native Libraries'} ],
               dataPoint: { title: 'Native Libaries Rating',
                        visualization: #RATING,
                        targetValue: 5 } }
     nativrelibariesratings,
     
      @UI: {
               lineItem:       [ { position: 80, importance: #HIGH, type: #AS_DATAPOINT } ],
               identification: [ { position: 80 , label: 'Performance'} ],
               dataPoint: { title: 'Performance Rating',
                        visualization: #RATING,
                        targetValue: 5 } }
     performancerating,
      
      
     @UI: {
               lineItem:       [ { position: 90, importance: #HIGH, type: #AS_DATAPOINT } ],
               identification: [ { position: 90 , label: 'Workflow'} ], 
               dataPoint: { title: 'Workflow Rating',
                        visualization: #RATING, 
                        targetValue: 5 } }
     workflowrating,
     
     
     
     _ProgrammingLanguages : redirected to parent ZC_PROGRAMMINGLANGUAGES_HSKA03

     
     
}
