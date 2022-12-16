
with vessel_ports_deduplicates as (

    select * from {{ ref('stg_vessel_ports') }}
),

vessel_tracking_events_deduplicate as (

    select * from {{ ref('stg_vessel_tracking_events') }}
),

ports_events_tracked_count as (

    select count(distinct concat(port_at_call,'-',port_at_call_country)) as ports_event_cnt from vessel_tracking_events_deduplicate

),

existing_ports_count as (

    select count(distinct concat(port, '-',country_code)) as existing_ports
    
    from vessel_ports_deduplicates
),


ports_tracked_vs_exist_ratio as (

    select round(ports_event_cnt/(select existing_ports from existing_ports_count),2) as ports_ratio from ports_events_tracked_count

),

final as (

    select * from ports_tracked_vs_exist_ratio
)

select * from final
