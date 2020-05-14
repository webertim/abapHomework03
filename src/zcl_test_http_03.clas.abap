CLASS zcl_test_http_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_http_03 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
  DATA:
      lv_res    TYPE string,
      lv_str TYPE string,
      lv_res_int Type int4,
      lv_res_float TYPE f.

    lv_str = 'CSS'.
    DATA(lv_url) = |http://europe-west2-abappopulation.cloudfunctions.net/helloWorld?name=| && lv_str.

    TRY.

        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( lv_url ).
        DATA(lo_http) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        DATA(lo_request) = lo_http->get_http_request( ).

        DATA(lo_reponse) = lo_http->execute( i_method = if_web_http_client=>get ).

        lv_res = lo_reponse->get_text( ).

      CATCH cx_root INTO DATA(lx_root).

        out->write( lx_root->get_longtext( ) ).

    ENDTRY.

    lv_res_float = lv_res.

    out->write( lv_res ).
    out->write( lv_res_float ).


  ENDMETHOD.

ENDCLASS.
