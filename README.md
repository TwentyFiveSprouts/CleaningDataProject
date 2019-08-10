# CleaningDataProject
Final Project for Coursera data science: Getting and Cleaning Data

run_analysis.R 

This routine assumes that the UCI HAR Dataset directory is a subdirectory of 
the home directory. It loads the following files:
UCI HAR Dataset/activity_labels.txt
UCI HAR Dataset/features.txt
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt

The routine then adds the values of "features.txt" as column names for each
of the data sets, and the subject_test and y_test as additional columns. The 
two datasets are then stitched together into one large dataset.

Next, a column is added with the translation of the activities from numeric to 
text. The data are then subsetted to give only the columns of interest:
subject, activity, and means and standard deviations for the x, y, and z 
directions.

Finally a summary table is generated from the small data set, showing the 
averages for each of the measurements, broken out by subject and activity. The
file is saved as summarydata.txt.

