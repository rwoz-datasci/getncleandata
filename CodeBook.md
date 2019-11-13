# CODEBOOK (Getting and Cleaning Data - Course Project)


## The Human Activity Recognition Using Smartphones Dataset

README.txt describes the dataset thoroughly listing all types of data
files and their purpose.

The dataset is prepared for machine learning. The files
(X|y)_(train|test).txt contain feature vectors and activity labels to
train and test a classifier.  They do not contain any raw data.

Raw data is available in the subdirectory 'Inertial Signals' where
accelerometer and gyroscope measurements are stored in text files.


## Preparing the data: Steps to perform

Goals:
1. combine data into one clean table of records only containing
   variables representing means and standard deviations
2. summarise the dataset grouped by actitvity and subject id


Steps to accomplish these goals:

* Merge subject data to the left with feature data from X_train.txt
  and subject_train.txt.  Check if no. rows is identical!

* Replace actitivity ids from y_train.txt with respective labels from
  acitivity_labels.txt by changing the variable from integer to type
  'factor'

* Merge activitiy column to the left with feature table
  Check if no. rows is identical!

* Define variable names as follows:
  ("activity","subject",...features.txt...,"bodyaccx",..."bodygyrox",..."totalaccz")

* Do the same for TEST data

* Concatenate training and test data frames

* Summarise the dataset grouped by actitvity and subject id

* Append suffix "-groupedmean" to indicate the operations performed in
  the previous step


### The Summarised Dataset

The dataset obatained by goal "1." is grouped by actitvity and subject
id. Multiple rows are then replaced by their mean value.  The result
is one row of means per activity and subject id, i.e. 30 rows per
activity as there are 30 distinct subject ids.  The rows are sorted in
ascending order by activity (their order according to activity ids
from 'activity_labels.txt') and subject id.


## Variables

The variables below represent all those describing a mean or standard
deviation feature as they are listed in 'UCI HAR
Dataset/features.txt'.

Please look at 'UCI HAR Dataset/features_info.txt' for more detailed
information on how they were constructed.


### List of Variables 

activity 
    description: body movement which has been performed by a subject
    type: factor
    labels: WALKING
            WALKING_UPSTAIRS
            WALKING_DOWNSTAIRS
            SITTING
            STANDING
            LAYING



subjectid
    description: id of a participant (subject)
    type: integer
    value: 1 thru 30


tbodyacc-mean-x | tbodyacc-mean-y | tbodyacc-mean-z
    description: mean of values grouped by activity and subjectid of the time-domain body acceleration mean on x/y/z-axis
    type: double

tbodyacc-std-x | tbodyacc-std-y | tbodyacc-std-z
    description: mean of values grouped by activity and subjectid of the time-domain body acceleration std deviation on x/y/z-axis
    type: double

tgravityacc-mean-x | tgravityacc-mean-y | tgravityacc-mean-z
    description: mean of values grouped by activity and subjectid of the time-domain gravitational acceleration mean on x/y/z-axis
    type: double

tgravityacc-std-x | tgravityacc-std-y | tgravityacc-std-y
    description: mean of values grouped by activity and subjectid of the time-domain body acceleration std deviation on x/y/z-axis
    type: double

tbodyaccjerk-mean-x | tbodyaccjerk-mean-y | tbodyaccjerk-mean-z
    description: mean of values grouped by activity and subjectid of the time-domain mean body acceleration jerk (1st deriv) on x/y/z-axis
    type: double

tbodyaccjerk-std-x | tbodyaccjerk-std-y | tbodyaccjerk-std-z
    description: mean of values grouped by activity and subjectid of the time-domain body acceleration jerk (1st deriv) std deviation on x/y/z-axis
    type: double

tbodygyro-mean-x | tbodygyro-mean-y | tbodygyro-mean-z
    description: mean of values grouped by activity and subjectid of the time-domain mean angular velocity on x/y/z-axis
    type: double

tbodygyro-std-x | tbodygyro-std-y | tbodygyro-std-z
    description: mean of values grouped by activity and subjectid of the time-domain angular velocity std deviation on x/y/z-axis
    type: double

tbodygyrojerk-mean-x | tbodygyrojerk-mean-y | tbodygyrojerk-mean-z
    description: mean of values grouped by activity and subjectid of the time-domain mean angular velocity jerk (1st deriv) on x/y/z-axis
    type: double

tbodygyrojerk-std-x | tbodygyrojerk-std-y | tbodygyrojerk-std-z
    description: mean of values grouped by activity and subjectid of the time-domain angualar velocity jerk (1st deriv) std deviation on x/y/z-axis
    type: double

tbodyaccmag-mean
    description: mean of values grouped by activity and subjectid of the time-domain mean body acceleration magnitude (Euclidian norm)
    type: double

tbodyaccmag-std
    description: mean of values grouped by activity and subjectid of the time-domain body acceleration magnitude std deviation (Euclidian norm)
    type: double

tgravityaccmag-mean
    description: mean of values grouped by activity and subjectid of the time-domain mean gravitational acceleration magnitude (Euclidian norm)
    type: double

tgravityaccmag-std
    description: mean of values grouped by activity and subjectid of the time-domain body gravitational acceleration magnitude std deviation (Euclidian norm)
    type: double

tbodyaccjerkmag-mean
    description: mean of values grouped by activity and subjectid of the time-domain mean body acceleration jerk
    type: double

tbodyaccjerkmag-std
    description: mean of values grouped by activity and subjectid of the time-domain body acceleration jerk (1st deriv) std deviation (1st deriv)
    type: double

tbodygyromag-mean
    description: mean of values grouped by activity and subjectid of the time-domain mean angualar velocity magnitude (Euclidian norm)
    type: double

tbodygyromag-std
    description: mean of values grouped by activity and subjectid of the time-domain angualar velocity magnitude std deviation (Euclidian norm)
    type: double

tbodygyrojerkmag-mean
    description: mean of values grouped by activity and subjectid of the time-domain mean angualar velocity jerk (1st deriv) magnitude (Euclidian norm)
    type: double

tbodygyrojerkmag-std
    description: mean of values grouped by activity and subjectid of the time-domain angualar velocity jerk (1st deriv) magnitude std deviation (Euclidian norm)
    type: double

fbodyacc-mean-x | fbodyacc-mean-y | fbodyacc-mean-z
    description: mean of values grouped by activity and subjectid of the frequency-domain mean body acceleration on x/y/z-axis
    type: double

fbodyacc-std-x | fbodyacc-std-y | fbodyacc-std-z
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration std deviation on x/y/z-axis
    type: double

fbodyacc-meanfreq-x | fbodyacc-meanfreq-y | fbodyacc-meanfreq-z
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration mean frequency on x/y/z-axis
    type: double

fbodyaccjerk-mean-x | fbodyaccjerk-mean-y | fbodyaccjerk-mean-z
    description: mean of values grouped by activity and subjectid of the frequency-domain mean body acceleration jerk (1st deriv) on x/y/z-axis
    type: double

fbodyaccjerk-std-x | fbodyaccjerk-std-y | fbodyaccjerk-std-z
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration jerk (1st deriv) std deviation (1st deriv) on x/y/z-axis
    type: double

fbodyaccjerk-meanfreq-x | fbodyaccjerk-meanfreq-y | fbodyaccjerk-meanfreq-z
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration jerk (1st deriv) mean frequency (1st deriv) on x/y/z-axis
    type: double

fbodygyro-mean-x | fbodygyro-mean-y | fbodygyro-mean-z
    description: mean of values grouped by activity and subjectid of the frequency-domain mean angualar velocity on x/y/z-axis
    type: double

fbodygyro-std-x | fbodygyro-std-y | fbodygyro-std-z
    description: mean of values grouped by activity and subjectid of the frequency-domain angualar velocity std deviation on x/y/z-axis
    type: double

fbodygyro-meanfreq-x | fbodygyro-meanfreq-y | fbodygyro-meanfreq-z
    description: mean of values grouped by activity and subjectid of the frequency-domain angualar velocity mean frequency on x/y/z-axis
    type: double

fbodyaccmag-mean
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration magnitude mean (Euclidian norm)
    type: double

fbodyaccmag-std
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration magnitude std deviation (Euclidian norm)
    type: double

fbodyaccmag-meanfreq
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration magnitude mean frequency (Euclidian norm)
    type: double

fbodybodyaccjerkmag-mean
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration jerk (1st deriv) magnitude mean (Euclidian norm) 
    type: double

fbodybodyaccjerkmag-std
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration jerk (1st deriv) magnitude std deviation (Euclidian norm)
    type: double

fbodybodyaccjerkmag-meanfreq
    description: mean of values grouped by activity and subjectid of the frequency-domain body acceleration jerk (1st deriv) magnitude mean frequency  (Euclidian norm)
    type: double

fbodybodygyromag-mean
    description: mean of values grouped by activity and subjectid of the frequency-domain mean angualar velocity magnitude (Euclidian norm)
    type: double

fbodybodygyromag-std
    description: mean of values grouped by activity and subjectid of the frequency-domain angualar velocity magnitude std deviation (Euclidian norm)
    type: double

fbodybodygyromag-meanfreq
    description: mean of values grouped by activity and subjectid of the frequency-domain angualar velocity magnitude mean frequency (Euclidian norm)
    type: double

fbodybodygyrojerkmag-mean
    description: mean of values grouped by activity and subjectid of the frequency-domain angualar velocity jerk (1st deriv) magnitude mean (Euclidian norm)
    type: double

fbodybodygyrojerkmag-std
    description: mean of values grouped by activity and subjectid of the frequency-domain angualar velocity jerk (1st deriv) magnitude std deviation (Euclidian norm)
    type: double

fbodybodygyrojerkmag-meanfreq
    description: mean of values grouped by activity and subjectid of the frequency-domain angualar velocity jerk (1st deriv) magnitude mean frequency (Euclidian norm)
    type: double

angle-of-tbodyaccmean-gravity
    description: mean of values grouped by activity and subjectid of angle between time-domain body acceleration mean and gravity (mean)
    type: double

angle-of-tbodyaccjerkmean-gravitymean
    description: mean of values grouped by activity and subjectid of angle between time-domain mean body acceleration jerk (1st deriv) and mean gravity
    type: double
    
angle-of-tbodygyromean-gravitymean
    description: mean of values grouped by activity and subjectid of angle between  time-domain mean angular velocity  and mean gravity
    type: double

angle-of-tbodygyrojerkmean-gravitymean
    description: mean of values grouped by activity and subjectid of angle between  time-domain mean angular velocity jerk (1st deriv) and mean gravity
    type: double

angle-of-x-gravitymean | angle-of-y-gravitymean | angle-of-z-gravitymean
    description: mean of values grouped by activity and subjectid of angle of gravity mean to z-axis
    type: double


