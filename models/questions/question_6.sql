
with vessel_tracking_events_deduplicate as (

    select distinct * from {{ ref('stg_vessel_tracking_events') }}
),

apl_gulf_express_routes as (

    select distinct
           voyage_origin_port as origin_port,
           destination_port as destination_port

    from vessel_tracking_events_deduplicate
    
    where mmsi = (select distinct mmsi from {{ ref('stg_vessel_info')  }}  
                   where regexp_contains(vessel_name,'(?i)APL GULF EXPRESS') is true )

),

final as (

    select * from apl_gulf_express_routes

)
#
select * from final
