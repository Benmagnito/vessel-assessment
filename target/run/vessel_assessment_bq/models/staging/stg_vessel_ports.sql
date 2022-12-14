
  
    

    create or replace table `rentoza-dataware-house`.`data_science`.`stg_vessel_ports`
    
    
    OPTIONS()
    as (
      with source_vessel_ports as (

    select distinct * from `rentoza-dataware-house`.`data_science`.`vessel_ports`
),


vessel_ports_derived_fields as (
    
    select 
        *,
        concat(port,'-',country_code) as unique_port,
        case when left(code,2) = left(country_code,2) then 1 else 0 end as is_correct_code 

    from source_vessel_ports 

),

final as (

    select * from vessel_ports_derived_fields

)

select * from final
    );
  