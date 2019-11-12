# Repository: getncleandata
Course repository for Coursera's online lecture 'Getting and Cleaning Data'


## The Human Activity Recognition Using Smartphones Dataset

README.txt describes the dataset thoroughly listing all types of data
files and their purpose.

The dataset is prepared for machine learning. The files (X|y)_(train|test).txt
contain feature vectors and activity labels to train and test a classifier.
They do not contain any raw data.

Raw data is available in the subdirectory 'Inertial Signals' where
accelerometer and gyroscope measurements are stored in text files.


## Preparing the data: Steps to perform


Goal: combine data into one clean table of records

* Merge subject data to the left with feature data from X_train.txt and subject_train.txt.
  Check if no. rows is identical!

* Replace actitivity ids in y_train.txt with respective labels from acitivity_labels.txt

* Merge activities to the left with feature table
  Check if no. rows is identical!

* Merge sensor data to the right the previous table from
  body_acc_xzy_train.txt, body_gyro_xyz_train.txt,
  total_acc_xyz_train.txt.  Each row is to be stored as one element of
  the target column, because a complete row is associated with its
  resp. feature vector.
  Check if no. rows is identical!

* Define variable names as follows:
  ("activity","subject",...features.txt...,"bodyaccx",..."bodygyrox",..."totalaccz")

* Do the same for TEST data

* Concatenate training and test data frames

