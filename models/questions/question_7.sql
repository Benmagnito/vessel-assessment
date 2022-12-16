
with vessel_tracking_events as (

    select * from {{ ref('stg_vessel_tracking_events')  }} 

    where voyage_origin_port is not null and
          left(voyage_origin_port,1) != '-'
),

vessel_origin_destination_ports_events as (

    select 
        mmsi, 
        voyage_origin_port as origin_port, 
        ata as origin_port_time_stamp,
        destination_port,
        atd as destination_port_time_stamp,
        time_at_port,
        voyage_time_underway as travel_time,
        leg_time_underway as canal_anchorage_time_docking_time
       
    from vessel_tracking_events 
),

vessel_origin_destination_ports_events_rename as (

    select * 

    from vessel_origin_destination_ports_events
    
),

final as (

    select * from vessel_origin_destination_ports_events_rename

)

select * from final
