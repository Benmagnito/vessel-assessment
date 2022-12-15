
  
    

    create or replace table `rentoza-dataware-house`.`data_science`.`mart_vessel_tracked_events`
    
    
    OPTIONS()
    as (
      select * from `rentoza-dataware-house`.`data_science`.`stg_vessel_tracked_events`
    );
  