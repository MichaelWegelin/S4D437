@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension Include View for Travel Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@AbapCatalog.extensibility: {
    extensible: true,
    allowNewDatasources: false,
    dataSources: [ 'Item' ],
    elementSuffix: 'ZIT'
}
define view entity Z00_E_TravelItem as select from z00_tritem as Item
{
    key item_uuid as ItemUuid
}
