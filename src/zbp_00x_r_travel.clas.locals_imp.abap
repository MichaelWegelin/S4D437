CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS ZZValidateClass FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~ZZValidateClass.

ENDCLASS.

CLASS lhc_item IMPLEMENTATION.

  METHOD ZZValidateClass.
    CONSTANTS c_area TYPE string VALUE `CLASS`.

    READ ENTITIES OF z00_r_travel IN LOCAL MODE
      ENTITY item
      FIELDS ( agencyid travelid ZZClassZit )
      WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).

      APPEND VALUE #( %tky = <item>-%tky
                      %state_area = c_area
                     )
          TO reported-item.

      IF <item>-ZZClassZit IS INITIAL.

        APPEND VALUE #(  %tky = <item>-%tky )
            TO failed-item.

        APPEND VALUE #( %tky = <item>-%tky
                        %msg = NEW /lrn/cm_s4d437(
                                     /lrn/cm_s4d437=>field_empty
                                   )
                        %element-zzclasszit = if_abap_behv=>mk-on
                        %state_area = c_area
                        %path-travel = CORRESPONDING #( <item> )
                       )
            TO reported-item.
      ELSE.

        SELECT SINGLE
          FROM /lrn/437_i_classstdvh
        FIELDS classid
         WHERE classid = @<item>-ZZClassZit
          INTO @DATA(dummy).

        IF sy-subrc <> 0.

          APPEND VALUE #(  %tky = <item>-%tky )
              TO failed-item.

          APPEND VALUE #( %tky = <item>-%tky
                          %msg = NEW /lrn/cm_s4d437(
                                       textid   = /lrn/cm_s4d437=>class_not_exist
                                       classid  = <item>-ZZClassZit
                                     )
                          %element-zzclasszit = if_abap_behv=>mk-on
                          %state_area = c_area
                        %path-travel = CORRESPONDING #( <item> )
                         )
          TO reported-item.

        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z00_R_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z00_R_TRAVEL IMPLEMENTATION.

  METHOD save_modified.
* Handle items that require update of booking class field
    LOOP AT update-item ASSIGNING FIELD-SYMBOL(<item>)
      WHERE %control-ZZClassZit = if_abap_behv=>mk-on.

      UPDATE z00_tritem
         SET zzclasszit = @<item>-ZZClassZit
       WHERE item_uuid     = @<item>-itemuuid.

    ENDLOOP.

* Update booking class field in items that were created
*    -> the new data sets are already on the DB
    LOOP AT create-item ASSIGNING <item>
      WHERE %control-ZZClassZit = if_abap_behv=>mk-on.

      UPDATE z00_tritem
         SET zzclasszit = @<item>-ZZClassZit
       WHERE item_uuid = @<item>-itemuuid.

    ENDLOOP.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
