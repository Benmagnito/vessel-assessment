
with source_vessel_info as (

    select distinct * from {{ source('vessel','vessel_info') }}
),

vessel_derived_fields as (

    select
        *,
        case when length >= 366 and width >= 49 then 1 else 0 end as is_ulcv, 
    from source_vessel_info
),

final as (

    select * from vessel_derived_fields

)

select * from final
