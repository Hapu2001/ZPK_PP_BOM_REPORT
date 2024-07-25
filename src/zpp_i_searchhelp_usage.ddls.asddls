@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search help for Usage'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZPP_I_SEARCHHELP_USAGE  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T
                 (
                 p_domain_name
                 :
                 'ZDO_BOM_USAGE'
                 )
{
    @UI.hidden: true
    key domain_name,
    @UI.hidden: true
    key value_position,
    @UI.hidden: true
    key language,
    @EndUserText.label            : 'BOM Usage'
    value_low as Value,
    @EndUserText.label            : 'BOM Usage Description'
    text as Description
}
