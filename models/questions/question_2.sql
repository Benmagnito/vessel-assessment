
with vessel_info_noduplicates as (

    select distinct * from {{ ref('stg_vessel_info') }}
),

ulcv_ships_classification as (

    select
        vessel_name,
        case when length >= 366 and width >= 49 then 1 else 0 end as is_ulcv, 
    from vessel_info_noduplicates

),

ulcv_ships as (

    select count(vessel_name) as ulcv_ships_count
    from ulcv_ships_classification
    
    where is_ulcv = 1
),

final as (

    select * from ulcv_ships

)

select * from final
