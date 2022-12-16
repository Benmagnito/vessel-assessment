
with source_vessel_ports as (

    select distinct * from {{ source('vessel','vessel_ports') }}
),

final as (

    select * from source_vessel_ports

)

select * from final
