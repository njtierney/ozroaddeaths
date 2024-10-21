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

# classes are consistent

    Code
      classes(dat_road_fatalities)
    Output
      $crash_id
      [1] "numeric"
      
      $month
      [1] "numeric"
      
      $year
      [1] "numeric"
      
      $weekday
      [1] "character"
      
      $time
      [1] "hms"      "difftime"
      
      $state
      [1] "character"
      
      $crash_type
      [1] "character"
      
      $bus
      [1] "character"
      
      $heavy_rigid_truck
      [1] "character"
      
      $articulated_truck
      [1] "character"
      
      $speed_limit
      [1] "numeric"
      
      $road_user
      [1] "character"
      
      $gender
      [1] "character"
      
      $age
      [1] "numeric"
      
      $date
      [1] "Date"
      
      $date_time
      [1] "POSIXct" "POSIXt" 
      

