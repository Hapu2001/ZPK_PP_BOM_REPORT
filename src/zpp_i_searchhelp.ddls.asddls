@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search help for BOM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_I_SEARCHHELP as select distinct from I_MaterialBOMLink
{
    //key BillOfMaterialVariantUsage,
    key BillOfMaterialCategory,
    key BillOfMaterialVariant
}
