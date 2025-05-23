class lcl_handler definition INHERITING FROM cl_abap_behavior_event_handler.

   private section.
     METHODS on_travel_created for ENTITY EVENT
       importing new_travels
       for Travel~TravelCreated.
endclass.

CLASS lcl_handler IMPLEMENTATION.

  METHOD on_travel_created.
* Without parameter
    DATA log TYPE TABLE FOR CREATE /lrn/437_i_travellog.

    LOOP AT new_travels ASSIGNING FIELD-SYMBOL(<travel>).
      APPEND VALUE #(
                      agencyid = <travel>-agencyid
                      travelid = <travel>-travelid
                      origin   = <travel>-hugo
                    )
         TO log.

    ENDLOOP.

    MODIFY ENTITIES OF /lrn/437_i_travellog
       ENTITY travellog
         CREATE AUTO FILL CID
         FIELDS ( agencyid travelid origin )
         WITH log.

  ENDMETHOD.

ENDCLASS.
