# test that the fatal crash dimensions are stable

    Code
      dim(dat_road_fatal_crash)
    Output
      [1] 49903    14

# test names of fatal crash are the same

    Code
      names(dat_road_fatal_crash)
    Output
       [1] "crash_id"          "n_fatalities"      "month"            
       [4] "year"              "weekday"           "time"             
       [7] "state"             "crash_type"        "bus"              
      [10] "heavy_rigid_truck" "articulated_truck" "speed_limit"      
      [13] "date"              "date_time"        

# classes are consistent

    Code
      classes(dat_road_fatal_crash)
    Output
      $crash_id
      [1] "numeric"
      
      $n_fatalities
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
      
      $date
      [1] "Date"
      
      $date_time
      [1] "POSIXct" "POSIXt" 
      

