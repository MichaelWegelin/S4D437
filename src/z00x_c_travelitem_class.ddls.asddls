extend view entity Z00_C_TRAVELITEM with {

    @Consumption.valueHelpDefinition: [{ 
        entity: { 
            name: '/LRN/437_I_ClassStdVH', 
            element: 'ClassID' 
        } 
    }]
    Item.ZZClassZit
}
