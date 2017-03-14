#"activity_labels.txt" data file gives the activity number (1-6) for each activity
# for each measurement - 7351 records (rows)

#"features.txt" data files give the column names corresponding to a measurement or statistic
# of a measurement

#"Subject_train" gives the subject who underwent the measurement - 7352 records (rows)
#"Subject_test" gives the subject who underwent the measurement - 2947 records (rows)

#"X_train.txt" is a data table of 7352 by 561 columns - this is the training group (21 participants)
#"Y_train.txt" is a vector of 7352 of the activity number corresponding to each record
#"X_test.txt" is a data table of 2947 by 561 columns - this is the test group 
#"Y_test.txt" is a vector of 2947 of the activity number corresponding to each record (9 participants)

#get the test and train data into dataframes
TrainSet <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
TestSet  <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)

# make a vector to list all participants' measurements 
TrainPeople <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
TestPeople  <-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)

# make a vector to list activity corresponding to the record
TrainActiv <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
TestActiv  <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)

exp_group <- rep("TRAINING", nrow(TrainPeople))
#Fourth, merge TrainSet with participants and TestSet with activity and participants vector
TrainSet <- cbind(exp_group,TrainPeople, TrainActiv, TrainSet)
exp_group <- rep("TEST" , nrow(TestPeople))
TestSet <- cbind(exp_group, TestPeople,TestActiv, TestSet)

#Vertically merge the two dataframes
TRandTE_Set <- rbind(TrainSet,TestSet)

#give column names
colnames(TRandTE_Set)[2:3] <- c('subject','activity')
MeasLbls  <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
MeasLbls  <- as.character(MeasLbls$V2)
colnames(TRandTE_Set)[4:ncol(TRandTE_Set)] <- MeasLbls

#recode activity coding to have better identification
ActLbls  <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
Activities <- as.character(ActLbls$V2)
TRandTE_Set$activity <- ifelse(TRandTE_Set$activity == 1, Activities[[1]], ifelse(TRandTE_Set$activity == 2, Activities[[2]],
                        ifelse(TRandTE_Set$activity == 3, Activities[[3]], ifelse(TRandTE_Set$activity == 4, Activities[[1]],
                        ifelse(TRandTE_Set$activity == 5, Activities[[5]], ifelse(TRandTE_Set$activity == 6, Activities[[6]],
                        NA))))))

#check NA values
if (length(which(is.na(TRandTE_Set))) > 0.) {
  warning("NA values present in dataframe")
} else {
 message("No NA values")
}

#extract mean and standard deviation column headings
StatLbls <- grep("[Mm][Ee][Aa][Nn][(]|[Ss][Tt][Dd]", names(TRandTE_Set), value = TRUE)
#subset these columns out of original datatable
Stat_Set <- subset(TRandTE_Set, select=c("exp_group","subject","activity",StatLbls))

#Fix column names
#remove "parantheses
names(Stat_Set) <- gsub("[()]", "", names(Stat_Set))


#Form new tidy data set with ave of each variable for each activity and each subject.
TidyTable <- Stat_Set %>% 
                group_by(subject, exp_group, activity) %>%
                  summarise_each(funs(mean))

names(TidyTable) <- gsub("&", ")", names(TidyTable))
names(TidyTable) <- gsub("$", ")", names(TidyTable))
colnames(TidyTable)[1:3] <- c('subject', 'exp_group', 'activity')

write.table(TidyTable, "./tidytable_Kitover.txt", sep = "\t", row.name = FALSE)



