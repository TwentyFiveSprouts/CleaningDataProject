
library("data.table")

##      Read in labels files. I can use these as preliminary column headers

features <- read.table("UCI HAR Dataset/features.txt")

##      This file gives the translation between the numeric "labels" and the
##      activities associated with each of those labels.

activelab <- read.table("UCI HAR Dataset/activity_labels.txt")

##      These are the subjects' ID numbers associated with each record

stest<- read.table("UCI HAR Dataset/test/subject_test.txt")
strain<- read.table("UCI HAR Dataset/train/subject_train.txt")

##      These are the numeric values for the activities that were being
##      measured in each record

testlab<- read.table("UCI HAR Dataset/test/y_test.txt")
trainlab<- read.table("UCI HAR Dataset/train/y_train.txt")

##      Now the actual data

testdata<- read.table("UCI HAR Dataset/test/x_test.txt")
traindata<- read.table("UCI HAR Dataset/train/x_train.txt")

##      Now to add the feature labels (features) as the names for the columns
##      in testdata and traindata

names(testdata)<- features[,2]
names(traindata)<- features[,2]

##      Add the subject info for both. Note that in order for the column
##      name to be "subject" I had to name the vector "subject", so I
##      re-used that variable name

subject<- stest$V1
testdata<- cbind(subject, testdata)
subject<- strain$V1
traindata<- cbind(subject, traindata)

##      same for adding the labels

label<- testlab$V1
testdata <- cbind(testdata, label)
label<- trainlab$V1
traindata <- cbind(traindata, label)

##      now combine the two sets

alldata<- rbind(traindata, testdata)



##      next, put in text activity labels in place of the numbered values
##      using a loop

mylength <- nrow(alldata)
activity <- vector("character", mylength)


for(i in 1:mylength){

        activity[i] <- as.character(activelab[alldata$label[i],2])

}

alldata<- cbind(activity, alldata)

##      reduce to needed information only - means and std devs

meanstdcolumns<-grep("mean|std", names(alldata))
wantedcolumns<- c(1,2,meanstdcolumns)

smalldata <- alldata[wantedcolumns]

##      now for the column labels

names(smalldata) <- tolower(names(smalldata))
names(smalldata) <- gsub("-", "", names(smalldata))
names(smalldata) <- gsub("\\(\\)", "", names(smalldata))

##      Finally, to structure into a summary table

summarydata <- melt(smalldata, id.vars = 1:2, measure.vars = 3:81)
summarydata <- dcast(summarydata, subject+activity~variable, mean)

##      Write out the summary table
write.table(summarydata, "summarydata.txt", row.names = FALSE)

