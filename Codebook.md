# Introduction

The script `run_analysis.R`
- downloads data from UCI
- merges the training and test sets to create one data set
- provides descriptive activity names to the variables in the data set
- extracts mean and standard deviation variables (for each measurement) from the data set
- creates another independent tidy dataset with averages grouped by activity and subject
  
# run_analysis.R

The script runs linearly by creating a directory and executing operations on the downloaded data.

# Data Set

The original data set is split into training and test sets that contain
- measurements from the equipment (x_data has 561 variables and 10299 observations)
- activity labels (y_data has 1 variable and 10299 observations)
- subject ids (subject_data has 1 variable and 10299 observations)

# Getting and Cleaning the Data

If the data is not already there, it is downloaded. Data is read into data frames. The data frames of similar classes are then combined. (combined_data)

After this, 66 mean and standard deviation features are extracted from the measurement data set. (extracted_data)

Next, activity labels are replaced by names. The same goes for the measurement and subject data sets. 

The final step melts the data using the reshape package. And recasts it to give us the desired information. (tidy)

Finally, the new data is written to a text file. (INDTIDYDATA.txt)