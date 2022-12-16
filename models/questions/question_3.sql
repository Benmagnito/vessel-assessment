
with vessel_ports_deduplicate as (

    select distinct * from {{ ref('stg_vessel_ports') }}
),


vessel_ports_incorrect_code as (
    
    select
        *,
        case when left(code,2) = left(country_code,2) then 1 else 0 end as is_correct_code

    from vessel_ports_deduplicate 
),

vessel_ports_incorrect_code_list as (

    select * except(is_correct_code) from vessel_ports_incorrect_code

    where is_correct_code = 0
),

final as (

    select * from vessel_ports_incorrect_code_list
)

select * from final
