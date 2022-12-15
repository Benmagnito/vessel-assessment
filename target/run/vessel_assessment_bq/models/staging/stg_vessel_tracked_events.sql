
  
    

    create or replace table `rentoza-dataware-house`.`data_science`.`stg_vessel_tracked_events`
    
    
    OPTIONS()
    as (
      with source_vessel_tracking_events as (

    select distinct * from `rentoza-dataware-house`.`data_science`.`vessel_tracking_events`
),

vessel_ports_all as (
    
    select 
        mmsi,
        port_at_call as port,
        port_at_call_country as country_code,
        port_type
    from source_vessel_tracking_events

    union all
    
    select
        mmsi,
        case when voyage_origin_port = '-' then destination_port
             when destination_port =  '-' then voyage_origin_port 
             else 'other' end as port,

        case when origin_port_country = '-' then destination_port_country
             when destination_port_country =  '-' then origin_port_country 
             else 'other' end as country_code,
        port_type

    from source_vessel_tracking_events 

),

vessel_ports_interaction as (

    select 
        mmsi,
        port_type,
        case when regexp_contains(port,'(?i)anch.*') is true then regexp_replace(port, coalesce(regexp_extract(port,'(?i)anch.*'),''),'')
             when regexp_contains(port,'(?i)marin.*') is true then regexp_replace(port, coalesce(regexp_extract(port,'(?i)marin.*'),''),'')
             when regexp_contains(port,'(?i)canal.*') is true then regexp_replace(port, coalesce(regexp_extract(port,'(?i)canal.*'),''),'')
             when regexp_contains(port,'(?i)terminal.*') is true then regexp_replace(port, coalesce(regexp_extract(port,'(?i)terminal.*'),''),'')
              else port end as port,
        country_code

        from vessel_ports_all
),

vessel_ports_interaction_dedupe as (

    select distinct
        mmsi,
        port_type,
        concat(trim(port),'-',trim(country_code)) as unique_port

        from vessel_ports_interaction
),

vessel_sines_rodman as (

    select *
from source_vessel_tracking_events

    where regexp_contains(voyage_origin_port,'(?i)sines*') is true and 
          regexp_contains(port_at_call,'(?i)rodman*') is true

),

final as (

    select * from vessel_sines_rodman

)

select * from final
    );
  