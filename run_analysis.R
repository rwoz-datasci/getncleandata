library(data.table)
library(dplyr)


dataPath <- file.path(".","data")
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- file.path(dataPath,paste0("HAR-Dataset.zip")
                     
if(!file.exists(dataPath)){ dir.create(dataPath) }
if(!file.exists(zipFile)) {
    download.file(zipURL, zipFile)
    file.create(file.path(dataPath,paste0("HAR-Dataset-download-datetime-",format(Sys.time(), "%Y%m%d-%H%M"))))
}
unzip(zipFile,exdir=dataPath)

harBasePath <- file.path(dataPath,"UCI HAR Dataset")
harSubsetPath <- c("test","train")
harSensorDataPath <- "Inertial Signals"

dataSubSets <- list(TEST=1,TRAIN=2)
features <- "features.txt"
activityLabels <- "activity_labels.txt"
featureVectors <- c("X_test.txt","X_train.txt")
activityIds <- c("y_test.txt","y_train.txt")
subjectIds <- c("subject_test.txt","subject_train.txt")





extractCleanFeatureNames <- function(fileName)
{
    ## set variable names from features.txt
    ## after cleaning label strings:
    ## replace , with -
    ## replace angle(...) with angle-of-
    ## remove () and traling )
    tbl3 <- fread(featureNameFile)
    featureNames_tbl <- tbl_df(tbl3)
    rm(tbl3)
    
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



prepareSubset <- function(featureNamesVector, activityLabelsTable, featureFile, activityFile, subjectFile)
{
    
    tbl1 <- fread(featureFile)
    tbl2 <- fread(activityFile)
    tbl4 <- fread(subjectFile)


    features_tbl <- tbl_df(tbl1)
    rm(tbl1)
    names(features_tbl) <- featureNamesVector


    ## insert subject ids
    subjectids_tbl <- tbl_df(tbl4)
    rm(tbl4)
    features_tbl <- features_tbl %>%
        mutate(subjectid = factor(subjectids_tbl$V1)) %>%
        select(subjectid,1:ncol(features_tbl))

    ## join activity labels with recorded activity ids

    activity_tbl <- tbl_df(tbl2)
    rm(tbl2)
    mergedLabels <- activity_tbl %>%
        inner_join(labels) %>%
        select(V2)

    ## insert activity labels on the left 
    features_tbl <- features_tbl %>%
        mutate(activity = factor(mergedLabels$V2)) %>%
        select(activity,1:ncol(features_tbl))

    ## FINAL STEP: select only measurements involving mean and stddev
    main_tbl <- features_tbl  %>%
        select(activity,subjectid,matches("(mean|std)")) %>%
        print

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




featureNameFile <- file.path(harBasePath,features)
labelsFile <- file.path(harBasePath,activityLabels)



featureNames <- extractCleanFeatureNames(featureNameFile)

## load activity ids and labels
tbl0 <- fread(labelsFile)
activityLabels_tbl <- tbl_df(tbl0)


##
## Load and prepare all subsets: TEST, TRAINING
##
## Add each data table to the subsetList
##
subsetList <- vector("list",0)
for(idx in dataSubSets)
{
    featFile <- file.path(harBasePath,harSubsetPath[idx],featureVectors[idx]) 
    activityFile <- file.path(harBasePath,harSubsetPath[idx],activityIds[idx])
    subjFile <- file.path(harBasePath,harSubsetPath[idx],subjectIds[idx])

    subset_tbl <- prepareSubset(featureNames,activityLabels_tbl,featFile, activityFile,subjFile)

    subset_tbl <- insertColumnOfTypeFactor(subset_tbl,"modeofoperation",names(dataSubSets)[idx],names(dataSubSets))

    subsetList[[names(dataSubSets[idx])]] <- subset_tbl
}


##
## Merge all data tables in the subsetList
##
## FINAL HAR DATASET containing subject ids, activity labels,
## mode-of-operation lables (test,train) additionally to measurements
## involving mean and stddev
##
## According to the steps 1 thru 4 of course project instructions [2019-11-12]
##
harDataset <- bind_rows(subsetList)




