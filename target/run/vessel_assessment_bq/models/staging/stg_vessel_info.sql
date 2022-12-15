
  
    

    create or replace table `rentoza-dataware-house`.`data_science`.`stg_vessel_info`
    
    
    OPTIONS()
    as (
      with source_vessel_info as (

    select distinct * from `rentoza-dataware-house`.`data_science`.`vessel_info`
),

vessel_derived_fields as (

    select 
        imo,
        mmsi,
        vessel_name,
        generic_type,
        detailed_type,
        status,
        call_sign,
        flag,
        gross_tonnage,
        dwt,
        length,
        width,
        case when length >= 366 and width >= 49 then 1 else 0 end as is_ulcv, 
        year_built
    from source_vessel_info
),

final as (

    select * from vessel_derived_fields

)

select * from final
    );
  