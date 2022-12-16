
with vessel_tracking_events as (

    select * from {{ ref('stg_vessel_tracking_events')  }} 
),

vessel_origin_destination_ports as (

    select 
        mmsi, 
        ata,
        atd,
        date_diff(atd,ata,minute) as time_interval_in_minutes,
        destination_port,
        voyage_origin_port,

    from vessel_tracking_events 
   
    where regexp_contains(voyage_origin_port,'(?i)sines') is true and 
          regexp_contains(destination_port,'(?i)rodman') is true
),

vessel_average_time_interval as (

    select div(sum(time_interval_in_minutes),count(mmsi)) as avg_time_interval_in_minutes

    from vessel_origin_destination_ports 

),

final as (

    select * from vessel_average_time_interval

)

select * from final

