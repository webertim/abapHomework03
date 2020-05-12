CLASS lhc_ProgrammingLanguages DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS CalculateLanguageKey FOR DETERMINATION ProgrammingLanguages~CalculateLanguageKey
      IMPORTING keys FOR ProgrammingLanguages.

    METHODS validateDate FOR VALIDATION ProgrammingLanguages~validateDate
      IMPORTING keys FOR ProgrammingLanguages.

    METHODS validatePopularity FOR VALIDATION ProgrammingLanguages~validatePopularity
      IMPORTING keys FOR ProgrammingLanguages.

    METHODS validateUrl FOR VALIDATION ProgrammingLanguages~validateUrl
      IMPORTING keys FOR ProgrammingLanguages.

    METHODS updatePopulatrity FOR MODIFY
      IMPORTING keys FOR ACTION ProgrammingLanguages~updatePopulatrity RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR ProgrammingLanguages RESULT result.

ENDCLASS.

CLASS lhc_ProgrammingLanguages IMPLEMENTATION.

  METHOD CalculateLanguageKey.
    SELECT FROM ZI_ProgrammingLanguages_HSKA03
        FIELDS MAX( langid ) INTO @DATA(lv_max_langid).

    LOOP AT keys INTO DATA(ls_key).
      lv_max_langid = lv_max_langid + 1.
      MODIFY ENTITIES OF ZI_ProgrammingLanguages_HSKA03  IN LOCAL MODE
        ENTITY ProgrammingLanguages
          UPDATE SET FIELDS WITH VALUE #( ( langid = lv_max_langid ) )
          REPORTED DATA(ls_reported).
      APPEND LINES OF ls_reported-ProgrammingLanguages TO reported-ProgrammingLanguages.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDate.

    "READ ENTITY ZI_ProgrammingLanguages_HSKA03 FIELDS ( age ) WITH
    "VALUE #(  FOR <root_key> IN keys (  %key = <root_key> ) ) "CORRESPONDING #( keys )
    "RESULT DATA(lt_programminglanguages).

    READ ENTITIES OF ZI_ProgrammingLanguages_HSKA03 IN LOCAL MODE
    ENTITY ProgrammingLanguages
     FIELDS ( age )
     WITH CORRESPONDING #(  keys )
    RESULT DATA(lt_programminglanguages).

    LOOP AT lt_programminglanguages INTO DATA(ls_programminglanguages).

      IF ls_programminglanguages-age >= cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( langid = ls_programminglanguages-langid ) TO failed.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validatePopularity.
    READ ENTITIES OF ZI_ProgrammingLanguages_HSKA03 IN LOCAL MODE
    ENTITY ProgrammingLanguages
     FIELDS ( popularity )
     WITH CORRESPONDING #(  keys )
    RESULT DATA(lt_programminglanguages).

     LOOP AT lt_programminglanguages INTO DATA(ls_programminglanguages).

      IF ls_programminglanguages-popularity < 0.
        APPEND VALUE #( langid = ls_programminglanguages-langid ) TO failed.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateUrl.

    READ ENTITIES OF ZI_ProgrammingLanguages_HSKA03 IN LOCAL MODE
    ENTITY ProgrammingLanguages
     FIELDS ( documentationhref gettingstartedhref )
     WITH CORRESPONDING #(  keys )
    RESULT DATA(lt_programminglanguages).

    LOOP AT lt_programminglanguages INTO DATA(ls_programminglanguages).
      DATA(lo_matcher_documentation) = cl_abap_matcher=>create( pattern = '(http|https)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?' text = ls_programminglanguages-documentationhref ).
      DATA(lo_matcher_getting_started) = cl_abap_matcher=>create( pattern = '(http|https)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?' text = ls_programminglanguages-gettingstartedhref ).

      DATA(lv_valid_documentation) = lo_matcher_documentation->match(  ).
      DATA(lv_valid_getting_started) = lo_matcher_getting_started->match(  ).

      IF lv_valid_documentation = abap_false.
        APPEND VALUE #( langid = ls_programminglanguages-langid ) TO failed.
      ENDIF.

      IF lv_valid_getting_started = abap_false.
        APPEND VALUE #( langid = ls_programminglanguages-langid ) TO failed.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD updatePopulatrity.
  ENDMETHOD.

  METHOD get_features.
  ENDMETHOD.

ENDCLASS.
