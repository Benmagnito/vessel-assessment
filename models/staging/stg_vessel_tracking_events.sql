

with source_vessel_tracking_events as (

    select distinct * from {{ source('vessel','vessel_tracking_events') }}

    order by mmsi, ata_atd
),

vessel_tracking_events_alignment as (     

    select
        port_type,
        port_call_type,
        port_at_call,
        port_at_call_country,
        lag(ata_atd) over w as ata,
        ata_atd as atd,
        time_at_port,
        destination_port,
        destination_port_country,
        lag(voyage_origin_port) over w as voyage_origin_port,
        lag(origin_port_country) over w as origin_port_country,
        lag(voyage_time_underway) over w as voyage_time_underway,
        lag(voyage_distance_travelled) over w as voyage_distance_travelled,
        lag(leg_start_port_anch) over w as leg_start_port_anch,
        lag(leg_time_underway) over w as leg_time_underway,
        lag(leg_distance_travelled) over w as leg_distance_travelled,
        mmsi
    from source_vessel_tracking_events

    window w as (partition by mmsi order by ata_atd)

),

vessel_tracking_events_time_at_port as (
    
    select 
        mmsi,
        port_type,
        port_at_call,
        port_at_call_country,
        ata,
        atd,
        date_diff(atd,ata,minute) as time_at_port,
        destination_port,
        destination_port_country,
        voyage_origin_port,
        origin_port_country,
        voyage_time_underway,
        voyage_distance_travelled,
        leg_start_port_anch,
        leg_time_underway,
        leg_distance_travelled

    from  vessel_tracking_events_alignment 
    
    where port_call_type = 'DEPARTURE'
),

final as (
    
    select * from vessel_tracking_events_time_at_port 

)

    select * from final

