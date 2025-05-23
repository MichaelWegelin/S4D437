@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Travel Projection View'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true

@Search.searchable: true
define root view entity Z00_C_TRAVEL
  provider contract transactional_query
  as projection on Z00_R_TRAVEL
{
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Agency_StdVH',
              element: 'AgencyID' }
      }]
  key AgencyId,
  key TravelId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.6
      Description,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Customer_StdVH',
              element: 'CustomerID' }
      }]
      CustomerId,
      BeginDate,
      EndDate,
      @EndUserText.label: 'Duration (days)'
      Duration,
      Status,
      ChangedAt,
      LocChangedAt,
      ChangedBy,
      _TravelItem: redirected to composition child Z00_C_TRAVELITEM
}
