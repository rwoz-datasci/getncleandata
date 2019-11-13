# Repository: getncleandata
Course repository for Coursera's online lecture 'Getting and Cleaning Data'


## Scripts

The task is accomplished solely by one script 'run_analysis.R'

### Structure

  Constant values are defined on top                                
                                                                    
  Functions definitions follow:                                     
    fetchData(..)                                                   
    extractCleanFeatureNames(..)                                    
    prepareSubset(..)                                               
    insertColumnOfTypeFactor(..)                                    
    summariseGroupedByActivitySubject(..)                           
                                                                    
  "Main" block on the bottom performing the download and         
  computation using the functions above                             
                                                                    

### Pre and Postconditions

Input:                                                              
  Expects the original dataset in the file "./data/UCI HAR Dataset.zip".
  Downloads the ZIP file if it is missing.                          
                                                                    
Output:                                                             
                                                                    
  harDataset The feature vector data of training and test data
             subsets are combined with human-readable activity.     
             All variables describing mean and standard deviation   
             are kept. All others are discarded.                    
                                                                    
  harDatasetSummarisedBySubjectAndActivity 
             additionally, a tabular
             summary is created containing the mean of all variables
             *grouped by* activity and subject id.
                                                                    
  File 'HAR-dataset-summary.txt' .....a space-separated file dump of
             harDatasetSummarisedBySubjectAndActivity               
