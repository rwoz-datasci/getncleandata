##
## Script developed as part of the course project of 'Getting and Cleaning Data'
##
## This code downloads a 2012 version of the UCI 'Human Activity
## Recognition Using Smartphones Data Set', cleans and merges the
## contained tables of feature vectors followed by summarising the
## data grouped by activity and participant (subjectid).
## 
## Downloaded from
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Available originally at
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## Short description: the dataset represents feature vectors computed from
## accelerometer and gyroscope data from smartphone user. The data was
## taken while users performed different types of body movements.
##
## @see CodeBook.md in the git repository for details.
##
##
##
## Script structure:                                                   
##   Constant values are defined on top                                
##                                                                     
##   Functions definitions follow:                                     
##     fetchData(..)                                                   
##     extractCleanFeatureNames(..)                                    
##     prepareSubset(..)                                               
##     insertColumnOfTypeFactor(..)                                    
##     summariseGroupedByActivitySubject(..)                           
##                                                                     
##   "Main" function on the bottom performing the download and         
##   computation using the functions above                             
##                                                                     
##                                                                     
## Input:                                                              
##   Expects the file "./data/UCI HAR Dataset.zip".                    
##   Downloads the ZIP file if it is missing.                          
##                                                                     
## Output:                                                             
##                                                                     
##   harDataset .....The feature vector data of training and test data 
##              subsets are combined with human-readable activity.     
##              All variables describing mean and standard deviation   
##              are kept. All others are discarded.                    
##                                                                     
##   harDatasetSummarisedBySubjectAndActivity .....additionally, a     
##              tabular summary is created containing the mean of all  
##              variables *grouped by* activity and subject id.        
##                                                                     
##   File 'HAR-dataset-summary.txt' .....a space-separated file dump of
##              harDatasetSummarisedBySubjectAndActivity                
##
##
## @author Ralph Wozelka
## @email coursera@wozelka.at
## @date 2019-11-12
##
##
library(data.table)
library(dplyr)


########################################################################
## CONSTANTS
##
dataPath <- file.path(".","data")
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- file.path(dataPath,"UCI HAR Dataset.zip")

harBasePath <- file.path(dataPath,"UCI HAR Dataset")
harSubsetPath <- c("test","train")
harSensorDataPath <- "Inertial Signals"

dataSubSets <- list(TEST=1,TRAIN=2)
features <- "features.txt"
activityLabels <- "activity_labels.txt"
featureVectors <- c("X_test.txt","X_train.txt")
activityIds <- c("y_test.txt","y_train.txt")
subjectIds <- c("subject_test.txt","subject_train.txt")



########################################################################
## FUNCTIONS
##
fetchData <- function(url,zipPath) {

    basePath <- dirname(zipPath)
    if(!file.exists(basePath)){ dir.create(basePath,recursive=T) }
    if(!file.exists(zipPath)) {
        print(basename(url))
        stopifnot(download.file(zipURL, zipPath) == 0)
        file.create(file.path(basePath,paste0("UCI-HAR-Dataset-download-datetime-",format(Sys.time(), "%Y%m%d-%H%M"))))
    }
    unzip(zipPath,exdir=dirname(zipPath))
}



extractCleanFeatureNames <- function(fileName)
{
    ## set variable names from features.txt
    ## after cleaning label strings:
    ## replace , with -
    ## replace angle(...) with angle-of-
    ## remove () and traling )
    tbl1 <- fread(featureNameFile)
    featureNames_tbl <- tbl_df(tbl1)
    rm(tbl1)
    
    sub("[()]","",
        sub("[)]$","",
            sub("angle[(]","angle-of-",
                sub("[(][)]","",
                    sub(",","-",
                        make.unique(
                            tolower(featureNames_tbl$V2),
                            sep="-"
                        )
                        )
                    )
                )
            )
        )
}



##
## Read a feature vector table.
## Adds the column of subject ids to the left.
## Add user-readable activity labels in a column to the left. 
## 
prepareSubset <- function(featureNamesVector, activityLabelsTable, featureFile, activityFile, subjectFile)
{
    
    tbl1 <- fread(featureFile)
    tbl2 <- fread(subjectFile)
    tbl3 <- fread(activityFile)
    features_tbl <- tbl_df(tbl1)
    subjectids_tbl <- tbl_df(tbl2)
    activity_tbl <- tbl_df(tbl3)
    rm(tbl1,tbl2,tbl3)
    
    names(features_tbl) <- featureNamesVector

    ## insert subject ids
    features_tbl <- features_tbl %>%
        mutate(subjectid = subjectids_tbl$V1) %>%
        select(subjectid,1:ncol(features_tbl))

    ## join activity labels with recorded activity ids
    mergedLabels <- activity_tbl %>%
        inner_join(activityLabelsTable) %>%
        select(V2)

    ## insert activity labels on the left 
    features_tbl <- features_tbl %>%
        mutate(activity = factor(mergedLabels$V2)) %>%
        select(activity,1:ncol(features_tbl))

    ## FINAL STEP: select only measurements involving mean and stddev
    main_tbl <- features_tbl  %>%
        select(activity,subjectid,matches("(mean|std)")) %>%
        print
    return(main_tbl)
}

insertColumnOfTypeFactor <- function(table,name,value,levels)
{
    length <- nrow(table)
    newCol <- factor(rep(value,length),levels=levels)
    tmp <- table %>%
        mutate(tempnewname = newCol) %>%
        select(tempnewname,1:ncol(table))
    names(tmp)[1] <- name
    return(tmp)
}


summariseGroupedByActivitySubject <- function(dataset)
{
    summarised <- dataset %>%
        group_by(activity,subjectid) %>%
        summarise_if(is.numeric,mean) %>%
        arrange(activity,subjectid)

    suffixes <- rep("-groupedmean",length(names(summarised)))
    suffixes[1:2]=c("","")
    amendedNames <- paste0(names(summarised),suffixes)
    names(summarised) <- amendedNames
    
    ## Print the first 4 columns for demo purposes
    summarised %>%
        select(activity,subjectid,3:4) %>%
        as.data.frame
    return(summarised)
}    


########################################################################
##
## MAIN
##
########################################################################


fetchData(zipURL,zipFile)

featureNameFile <- file.path(harBasePath,features)
labelsFile <- file.path(harBasePath,activityLabels)



featureNames <- extractCleanFeatureNames(featureNameFile)

## load activity id to label mapping
tbl0 <- fread(labelsFile)
activityLabels_tbl <- tbl_df(tbl0)
rm(tbl0)

##
## Load and prepare all subsets: TEST, TRAINING
##
## Adds subset's label (TEST,TRAINING) in the column 'modeofoperation' to the left.
## Adds each data table to the subsetList.
##
subsetList <- vector("list",0)
for(idx in dataSubSets)
{
    featFile <- file.path(harBasePath,harSubsetPath[idx],featureVectors[idx]) 
    activityFile <- file.path(harBasePath,harSubsetPath[idx],activityIds[idx])
    subjFile <- file.path(harBasePath,harSubsetPath[idx],subjectIds[idx])

    subset_tbl <- prepareSubset(featureNames,activityLabels_tbl,featFile,activityFile,subjFile)

    subset_tbl <- insertColumnOfTypeFactor(subset_tbl,"modeofoperation",names(dataSubSets)[idx],names(dataSubSets))

    subsetList[[names(dataSubSets[idx])]] <- subset_tbl
}


##
## Merge all data tables in the subsetList
##
## Step 1-4: FINAL HAR DATASET containing subject ids, activity labels,
## mode-of-operation lables (test,train) additionally to measurements
## involving mean and stddev
##
## According to the steps 1 thru 4 of course project instructions [2019-11-12]
##
harDataset <- bind_rows(subsetList)




##
## Step 5: calculates the means of all values grouped by activity and
## subject
##
harDatasetSummarisedBySubjectAndActivity <- summariseGroupedByActivitySubject(harDataset)


write.table(harDatasetSummarisedBySubjectAndActivity,file="HAR-dataset-summary.txt",row.names=F)
