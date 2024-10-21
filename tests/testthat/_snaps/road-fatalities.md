# test that the fatal crash dimensions are stable

    Code
      dim(dat_road_fatalities)
    Output
      [1] 55360    16

# test names of fatal crash are the same

    Code
      names(dat_road_fatalities)
    Output
       [1] "crash_id"          "month"             "year"             
       [4] "weekday"           "time"              "state"            
       [7] "crash_type"        "bus"               "heavy_rigid_truck"
      [10] "articulated_truck" "speed_limit"       "road_user"        
      [13] "gender"            "age"               "date"             
      [16] "date_time"        

