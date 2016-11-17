# check for directory and data
if (!file.exists("R/UCI HAR Dataset")) {
        # download the data
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipper <- "data/UCI_HAR_data.zip"
        download.file(fileURL, destfile = zipper, method="curl")
        unzip(zipper, exdir="R")
}

# read data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt") 
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt") 
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") 
x_test <- read.table("UCI HAR Dataset/test/X_test.txt") 
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt") 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt") 

# merge datasets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
merged_data <- list(x = x_data, y = y_data, subject = subject_data)

# extract mean and std measures
# read features
features <- read.table("UCI HAR Dataset/features.txt")
# find relevant columns
columns_mean <- sapply(features[,2], function(l) grepl("mean()", l, fixed = TRUE))
columns_std <- sapply(features[,2], function(l) grepl("std()", l, fixed = TRUE))
# extract them from the set data 
extracted_data <- x_data[, (columns_mean | columns_std)]
names(extracted_data) <- features[(columns_mean | columns_std), 2]
head(extracted_data)

# name the labels based on activities
names(y_data) <- "Activity"
y_data$Activity[y_data$Activity == 1] <- "WALKING"
y_data$Activity[y_data$Activity == 2] <- "WALKING_UPSTAIRS"
y_data$Activity[y_data$Activity == 3] <- "WALKING_DOWNSTAIRS"
y_data$Activity[y_data$Activity == 4] <- "SITTING"
y_data$Activity[y_data$Activity == 5] <- "STANDING"
y_data$Activity[y_data$Activity == 6] <- "LAYING"

# name the set data based on features as well
names(x_data) <- features[,2]

# name the subject id column
names(subject_data) <- "Subject"

# combine newly manipulated data
combined_data <- cbind(x_data, y_data, subject_data)


# tidy the dataset by creating a tall and skinny dataset and then recasting it into desired form
install.packages("reshape2")
library(reshape2)
melted <- melt(combined_data, id=c("Subject","Activity"))
tidy <- dcast(melted, Subject+Activity ~ variable, mean)

# write tidy dataset to a csv file
IndependentTidyData <- write.table(tidy, "INDTIDYDATA.txt", row.names=FALSE)

