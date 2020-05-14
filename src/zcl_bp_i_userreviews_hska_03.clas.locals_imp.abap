CLASS lhc_ZI_USERREVIEW_HSKA03 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS CalculateRatingAvarage FOR DETERMINATION UserReview~CalculateRatingAvarage
      IMPORTING keys FOR UserReview.

    METHODS validateRating FOR VALIDATION UserReview~validateRating
      IMPORTING keys FOR UserReview.

ENDCLASS.

CLASS lhc_ZI_USERREVIEW_HSKA03 IMPLEMENTATION.

  METHOD CalculateRatingAvarage.
    Data: lv_count_corresponding TYPE int4.

    SELECT langid, COUNT( communityrating ) AS count FROM ZUSERRATINGS_03
    GROUP BY langid INTO TABLE @DATA(lt_count).

    SELECT * FROM zuseravg_03 INTO TABLE @DATA(lt_avg).

    READ ENTITIES OF zi_userreview_hska03 IN LOCAL MODE
    ENTITY UserReview
     FIELDS ( langid communityrating frameworkrating nativrelibariesratings performancerating workflowrating )
     WITH CORRESPONDING #(  keys )
    RESULT DATA(lt_userratings).

    LOOP AT lt_userratings INTO DATA(ls_userrating).
      LOOP AT lt_count INTO DATA(ls_count).
        if ls_userrating-langid EQ ls_count-langid.
            lv_count_corresponding = ls_count-count.
            EXIT.
        ENDIF.
      ENDLOOP.

    SELECT * FROM zuseravg_03 WHERE langid = @ls_userrating-langid INTO @DATA(ls_avg).
    ENDSELECT.

    DATA(new_commavg) = ( ls_avg-communityavg * lv_count_corresponding + ls_userrating-communityrating ) / ( lv_count_corresponding + 1 ).
    DATA(new_perfavg) = ( ls_avg-performanceavg * lv_count_corresponding + ls_userrating-performancerating ) / ( lv_count_corresponding + 1 ).
    DATA(new_frameavg) = ( ls_avg-frameworkavg * lv_count_corresponding + ls_userrating-frameworkrating ) / ( lv_count_corresponding + 1 ).
    DATA(new_nativeavg) = ( ls_avg-nativelibrariesavg * lv_count_corresponding + ls_userrating-nativrelibariesratings ) / ( lv_count_corresponding + 1 ).
    DATA(new_workavg) = ( ls_avg-workflowavg * lv_count_corresponding + ls_userrating-workflowrating ) / ( lv_count_corresponding + 1 ).

    UPDATE zuseravg_03 SET
    communityavg = @new_commavg,
    performanceavg = @new_perfavg,
    frameworkavg = @new_frameavg,
    nativelibrariesavg = @new_nativeavg,
    workflowavg = @new_workavg
    WHERE langid = @ls_userrating-langid. "ls_count_corresponding + ls_userrating-communityrating / ls_count_corresponsponding + 1
    ENDLOOP.

  ENDMETHOD.

  METHOD validateRating.
    READ ENTITIES OF zi_userreview_hska03 IN LOCAL MODE
    ENTITY UserReview
     FIELDS ( communityrating frameworkrating nativrelibariesratings performancerating workflowrating  )
     WITH CORRESPONDING #(  keys )
    RESULT DATA(lt_userreviews).

    LOOP AT lt_userreviews INTO DATA(ls_userreviews).

      IF ls_userreviews-communityrating < 0 OR ls_userreviews-frameworkrating < 0 OR ls_userreviews-nativrelibariesratings < 0 OR ls_userreviews-workflowrating < 0 OR ls_userreviews-performancerating < 0.
        APPEND VALUE #( langid = ls_userreviews-langid username = ls_userreviews-username ) TO failed.
      ENDIF.

      IF ls_userreviews-communityrating > 5 OR ls_userreviews-frameworkrating > 5 OR ls_userreviews-nativrelibariesratings > 5 OR ls_userreviews-workflowrating > 5 OR ls_userreviews-performancerating > 5.
        APPEND VALUE #( langid = ls_userreviews-langid username = ls_userreviews-username ) TO failed.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
