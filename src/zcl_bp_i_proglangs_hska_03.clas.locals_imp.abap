CLASS lhc_ProgrammingLanguages DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS CreateAvgs FOR DETERMINATION ProgrammingLanguages~CreateAvgs
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

  METHOD CreateAvgs.
    SELECT FROM ZI_ProgrammingLanguages_HSKA03
        FIELDS MAX( langid ) INTO @DATA(lv_max_langid).

    LOOP AT keys INTO DATA(ls_key).
      lv_max_langid = lv_max_langid + 1.

      DATA entry TYPE zuseravg_03.
      entry = VALUE #( langid =  ls_key-langid performanceavg = 0 nativelibrariesavg = 0 communityavg = 0 frameworkavg = 0 workflowavg = 0 ).

      INSERT INTO zuseravg_03
      VALUES @entry.
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

  READ ENTITIES OF ZI_ProgrammingLanguages_HSKA03 IN LOCAL MODE
    ENTITY ProgrammingLanguages
     FIELDS ( name )
     WITH CORRESPONDING #(  keys )
    RESULT DATA(lt_programminglanguages).

    LOOP AT lt_programminglanguages INTO DATA(ls_programminglanguages).

    DATA:
      lv_res    TYPE string,
      lv_str TYPE string,
      lv_res_int Type int4,
      lv_res_float TYPE f.

    DATA(lv_url) = |http://europe-west2-abappopulation.cloudfunctions.net/helloWorld?name=| && ls_programminglanguages-name.

    TRY.

        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( lv_url ).
        DATA(lo_http) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        DATA(lo_request) = lo_http->get_http_request( ).

        DATA(lo_reponse) = lo_http->execute( i_method = if_web_http_client=>get ).

        lv_res = lo_reponse->get_text( ).

      CATCH cx_root INTO DATA(lx_root).

        lv_res_float = 200.
    ENDTRY.

        lv_res_float = lv_res.

    if sy-subrc <> 0.
        lv_res_float = 404.
    endif.

    ENDLOOP.

    MODIFY ENTITIES OF ZI_ProgrammingLanguages_HSKA03 IN LOCAL MODE
    ENTITY ProgrammingLanguages
      UPDATE FROM VALUE #( FOR key IN keys ( langid = key-langid
                                                        popularity = lv_res_float
                                                         %control-popularity = if_abap_behv=>mk-on ) )
      FAILED   failed
      REPORTED reported.

    READ ENTITIES OF ZI_ProgrammingLanguages_HSKA03 IN LOCAL MODE
       ENTITY ProgrammingLanguages
       FROM VALUE #( FOR key IN keys (  langid = key-langid
                                        %control = VALUE #(
                                          documentationhref = if_abap_behv=>mk-on
                                          gettingstartedhref = if_abap_behv=>mk-on
                                            age = if_abap_behv=>mk-on
                                            operationarea = if_abap_behv=>mk-on
                                            popularity = if_abap_behv=>mk-on
                                            name = if_abap_behv=>mk-on
                                            communityavg = if_abap_behv=>mk-on
                                            frameworkavg = if_abap_behv=>mk-on
                                            nativelibrariesavg = if_abap_behv=>mk-on
                                            performanceavg = if_abap_behv=>mk-on
                                            workflowavg = if_abap_behv=>mk-on
                                        ) ) )
       RESULT DATA(lt_programming_languages).

    result = VALUE #( FOR programming_language IN lt_programming_languages ( langid = programming_language-langid
                                                                             %param = programming_language ) ).

  ENDMETHOD.

  METHOD get_features.
    READ ENTITY ZI_ProgrammingLanguages_HSKA03 FROM VALUE #( FOR keyval IN keys
                                                      (  %key                    = keyval-%key ) )
                                RESULT DATA(lt_prog_result).

    result = VALUE #( FOR ls_prog IN lt_prog_result
                       ( %key                           = ls_prog-%key
                         %features-%action-updatePopulatrity = if_abap_behv=>fc-o-enabled
                      ) ).
  ENDMETHOD.

ENDCLASS.
