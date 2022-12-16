
with vessel_info_noduplicates as (

    select distinct * from {{ ref('stg_vessel_info') }}
),

distinct_ships_with_information as (

    select
        status,
        count(vessel_name) as ships_with_vessel_name,
        countif(left(mmsi,1) != '-') as ships_with_mmsi_id
    from vessel_info_noduplicates

    group by status

),

final as (

    select * from distinct_ships_with_information

)

select * from final
