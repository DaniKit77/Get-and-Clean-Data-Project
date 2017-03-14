### CODE BOOK
#### This code book describes the variables, the data, and transformations used to clean up the data.

#### Data:
----------------
Data was originally taken from the dataset :
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


#### Variables:
-----------------
Original data set contains 561 columns, which indicates 561 measurements but many of these are statistics (max, min, meant,etc.) of measurements. 

As per instructions of the assignments, only measurements which took a mean or a standard deviation were extracted from the original set. This reduced the collection of measurements to 66.

**Terminology of variable names:**
 * t - time domain signal
 * f - frequency domain signal
 * body - Body Acceleration signal
 * gravity - Gravity Acceleration signal 
 * acc - Accelerometer signal
 * gyro - gyroscope signal
 * jerk - jerk signal
 * mag - magnitude of signal
 * x, y, or z - direction
 * mean - mean of measurements
 * std - standard deviation of measurements
 
 The three grouping variables are:
 
   * subject: which of the 30 participants
  
   * exp_group: there were two groups (one for generating the training data and the other the test data)  
   
     Groups: TEST, TRAINING
  
   * activity: each participant performed six activities  
  
     Groups: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
     
#### Transformation:
-----------------------
To create the tidy data set as instructed ("create a second, independent tidy data set with the average of each variable for each activity and each subject"), the summarize function was used to find the grouped averages of the extracted variables according to the participant, whether they did test/train, and for each activity.

As a result of tidying up the data and to clarify that again averages were taken, the column headings of the grouped measurements have are edited from "var_name" to AVERAGE("var name").

The new tidy table is then written as a new tab-delimited text file called "tidytable_Kitover.txt"
