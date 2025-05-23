CLASS zcl_00_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    CONSTANTS c_agency_id TYPE /dmo/agency_id VALUE '070000'.
    CONSTANTS c_travel_id TYPE /dmo/travel_id VALUE '00004240'.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_eml IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    READ ENTITIES OF z00_r_travel
      ENTITY Travel
        ALL FIELDS
        WITH   VALUE #( ( agencyid = c_agency_id
                          travelid = c_travel_id ) )
        RESULT DATA(travels)
        FAILED DATA(failed).

    IF failed IS NOT INITIAL.
      out->write( `Error retrieving the travel` ).
    ELSE.
      MODIFY ENTITIES OF z00_r_travel
        ENTITY Travel
        UPDATE
        FIELDS ( description )
        WITH   VALUE #( ( agencyid    = c_agency_id
                          travelid    = c_travel_id
                          description = `My new Description` ) )
        FAILED failed.

      IF failed IS INITIAL.
        COMMIT ENTITIES.
        out->write( `Description successfully updated` ).
      ELSE.
        ROLLBACK ENTITIES.
        out->write( `Error updating the description` ).
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
