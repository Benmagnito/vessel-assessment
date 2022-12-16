
with source_vessel_info as (

    select distinct * from {{ source('vessel','vessel_info') }}
),

final as (

    select * from source_vessel_info

)

select * from final
