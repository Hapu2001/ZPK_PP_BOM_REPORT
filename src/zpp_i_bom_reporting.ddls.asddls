@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM Reporting'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZPP_I_BOM_REPORTING
  with parameters
    @Environment.systemField: #SYSTEM_DATE
    @EndUserText.label            : 'Key Date'
    P_KeyDate : sydate
  as select from    I_MaterialBOMLink                                               as bom
    left outer join I_BOMComponentWithKeyDate( P_KeyDate :$parameters.P_KeyDate )   as bomDate      on  bomDate.BillOfMaterial         = bom.BillOfMaterial
                                                                                                    and bomDate.BillOfMaterialVariant  = bom.BillOfMaterialVariant
                                                                                                    and bomDate.BillOfMaterialCategory = bom.BillOfMaterialCategory
    left outer join I_BillOfMaterialWithKeyDate( P_KeyDate :$parameters.P_KeyDate ) as materialDate on  materialDate.BillOfMaterial         = bom.BillOfMaterial
                                                                                                    and materialDate.BillOfMaterialVariant  = bom.BillOfMaterialVariant
                                                                                                    and materialDate.BillOfMaterialCategory = bom.BillOfMaterialCategory
    left outer join I_Product                                                       as product      on product.Product = bom.Material
  association [1..1] to I_ProductText as textProductBOMLink on  textProductBOMLink.Product  = $projection.Material
                                                            and textProductBOMLink.Language = 'E'
  association [1..1] to I_ProductText as textComponent      on  textComponent.Product  = $projection.BillOfMaterialComponent
                                                            and textComponent.Language = 'E'
{
        @EndUserText.label            : 'Plant'
        @UI.lineItem                  : [{ position: 10}]
        @UI.selectionField            : [{ position: 20 }]
        @Consumption.filter: { mandatory: true }
        @Consumption.valueHelpDefinition: [{ entity: {
                name                        : 'I_Plant',
                element                     : 'Plant'} }]
  key   bom.Plant,
        @EndUserText.label            : 'BOM Usage '
        @UI.lineItem                  : [{ position: 20}]
        @UI.selectionField            : [{ position: 10 }]
        @Consumption.filter: { mandatory: true }
        @Consumption.valueHelpDefinition: [{ entity: {
        name                        : 'ZPP_I_SEARCHHELP_USAGE',
        element                     : 'Value'} }]
      @Search.defaultSearchElement  : true
  key   bom.BillOfMaterialVariantUsage,
        @EndUserText.label            : 'Material '
        @UI.lineItem                  : [{ position: 30}]
        @UI.selectionField            : [{ position: 30 }]
        @Consumption.valueHelpDefinition: [
         { entity:  { name:    'C_BOMMaterialVH',
                     element: 'Material' }
        }]
  key   bom.Material,
        //  key   bom.BillOfMaterial,
        @EndUserText.label            : 'Alternative BOM'
        @UI.lineItem                  : [{ position: 50}]
        @UI.selectionField            : [{ position: 57 }]
        @Consumption.valueHelpDefinition: [{ entity: {
        name                        : 'ZPP_I_SEARCHHELP',
        element                     : 'BillOfMaterialVariant'} }]
  key   bom.BillOfMaterialVariant,
        @EndUserText.label            : 'Item'
        @UI.lineItem                  : [{ position: 100}]
        @UI.selectionField            : [{ position: 100 }]
        @Consumption.filter.hidden: true
  key   bomDate.BillOfMaterialItemNodeNumber,
        @EndUserText.label            : 'BOM Category'
        @UI.lineItem                  : [{ position: 220}]
        @UI.selectionField            : [{ position: 220 }]
//        @Consumption.valueHelpDefinition: [{ entity: {
//        name                        : 'ZPP_I_SEARCHHELP',
//        element                     : 'BillOfMaterialCategory'} }]
        bom.BillOfMaterialCategory,
        @EndUserText.label            : 'Material Description'
        @UI.lineItem                  : [{ position: 40}]
        @UI.selectionField            : [{ position: 40 }]
        @Consumption.filter.hidden: true
        textProductBOMLink.ProductName,
        @EndUserText.label            : 'Status '
        @UI.lineItem                  : [{ position: 60}]
        @UI.selectionField            : [{ position: 60 }]
        @Consumption.filter.hidden: true
        materialDate.BillOfMaterialStatus,
        @EndUserText.label            : 'Base Quantity '
        @UI.lineItem                  : [{ position: 70}]
        @UI.selectionField            : [{ position: 70 }]
        @Semantics.quantity.unitOfMeasure: 'BOMHeaderBaseUnit'
        @Consumption.filter.hidden: true
        materialDate.BOMHeaderQuantityInBaseUnit,
        @EndUserText.label            : 'Base Unit'
        @UI.lineItem                  : [{ position: 80}]
        @UI.selectionField            : [{ position: 80 }]
        @Consumption.filter.hidden: true
        materialDate.BOMHeaderBaseUnit,
        @EndUserText.label            : 'Valid From '
        @UI.lineItem                  : [{ position: 90}]
        @UI.selectionField            : [{ position: 90 }]
        @Consumption.filter.hidden: true
        materialDate.HeaderValidityStartDate,
        @EndUserText.label            : 'BOM Component'
        @UI.lineItem                  : [{ position: 110}]
        @UI.selectionField            : [{ position: 110 }]
        @Consumption.valueHelpDefinition: [
         { entity:  { name:    'C_BOMMaterialVH',
                     element: 'Material' }
        }]
        bomDate.BillOfMaterialComponent,
        @EndUserText.label            : 'Component Description'
        @UI.lineItem                  : [{ position: 120}]
        @UI.selectionField            : [{ position: 120 }]
        @Consumption.filter.hidden: true
        textComponent.ProductName as ComponentDesc,
        @EndUserText.label            : 'Quantity'
        @UI.lineItem                  : [{ position: 130}]
        @UI.selectionField            : [{ position: 130 }]
        @Consumption.filter.hidden: true
        @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
        bomDate.BillOfMaterialItemQuantity,
        @EndUserText.label            : 'Unit'
        @UI.lineItem                  : [{ position: 140}]
        @UI.selectionField            : [{ position: 140 }]
        @Consumption.filter.hidden: true
        bomDate.BillOfMaterialItemUnit,
        @EndUserText.label            : 'Assembly'
        @UI.lineItem                  : [{ position: 150}]
        @UI.selectionField            : [{ position: 150 }]
        @Consumption.filter.hidden: true
        case
          when bomDate.IsAssembly like 'X'
              then 'Yes'
              else 'No'
        end                       as Assembly,
        @EndUserText.label            : 'Created On'
        @UI.lineItem                  : [{ position: 160}]
        @UI.selectionField            : [{ position: 160 }]
        @Consumption.filter.hidden: true
        materialDate.RecordCreationDate,
        @EndUserText.label            : 'Created By'
        @UI.lineItem                  : [{ position: 170}]
        @UI.selectionField            : [{ position: 170 }]
        @Consumption.filter.hidden: true
        materialDate.CreatedByUser,
        @EndUserText.label            : 'Changed On'
        @UI.lineItem                  : [{ position: 180}]
        @UI.selectionField            : [{ position: 180 }]
        @Consumption.filter.hidden: true
        materialDate.LastChangeDate,
        @EndUserText.label            : 'Changed By'
        @UI.lineItem                  : [{ position: 190}]
        @UI.selectionField            : [{ position: 190 }]
        @Consumption.filter.hidden: true
        materialDate.LastChangedByUser,
        @EndUserText.label            : 'Costing'
        @UI.lineItem                  : [{ position: 200}]
        @UI.selectionField            : [{ position: 200 }]
        @Consumption.filter.hidden: true
        case
          when bomDate.BOMItemIsCostingRelevant like 'X'
              then 'Yes'
              else 'No'
        end                       as Costing,
        @EndUserText.label            : 'Valid On'
        @UI.lineItem                  : [{ position: 210}]
        @UI.selectionField            : [{ position: 210 }]
        @Consumption.filter.hidden: true
        materialDate.HeaderValidityEndDate,
        @EndUserText.label            : 'Scrapping (%)'
        @UI.lineItem                  : [{ position: 230}]
        @UI.selectionField            : [{ position: 230 }]
        @Consumption.filter.hidden: true
        bomDate.ComponentScrapInPercent,
        @EndUserText.label            : 'Issue SLOC'
        @UI.lineItem                  : [{ position: 240}]
        @UI.selectionField            : [{ position: 240 }]
        @Consumption.filter.hidden: true
        bomDate.ProdOrderIssueLocation,
        @EndUserText.label            : 'Material Type'
        @UI.selectionField            : [{ position: 55 }]
        //@Consumption.filter: { mandatory: true }
        @Consumption.valueHelpDefinition: [{ entity: {
            name                        : 'I_ProductType_2',
            element                     : 'ProductType'} }]
        @Search.defaultSearchElement  : true
        product.ProductType,
        @EndUserText.label            : 'Material Group'
        @UI.selectionField            : [{ position: 56 }]
        @Consumption.valueHelpDefinition: [{ entity: {
            name                        : 'I_ProductGroup_2',
            element                     : 'ProductGroup'} }]
        product.ProductGroup
}
