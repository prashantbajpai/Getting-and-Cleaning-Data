setwd("D:/R projects//Learning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")

library(ggplot2)
library(reshape2)
library(dplyr)

# read all the files
x <- list.files(recursive = T)

test <- read.table(x[16])
test_label <- read.table(x[17])
test_subject <- read.table(x[14])

train <- read.table(x[27])
train_label <- read.table(x[28])
train_subject <- read.table(x[26])

#There are 561 features
features <- read.table(x[2])

activity_label <- read.table(x[1])

#The function assigns feature labels and activity labels. Also activity labels are
#appropriately converted(like "1" to "walking") 
datacleaning <- function(x, features = features, label){
        colnames(x) <- as.character(features$V2)
        #attach labels
        x <- cbind(label = as.character(label$V1), x)
        x$label <- as.character(x$label)
        myswitch <- function(x){
                switch(x, "1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs", 
                       "4" = "sitting", "5" = "standing", "6" = "laying")
        }
        for(i in 1:length(x$label)){
                x$label[i] <- myswitch(x$label[i])
        }
        return(x)
}

test_cleaned <- datacleaning(test, features = features, label = test_label)
train_cleaned <- datacleaning(train, features = features, label = train_label)

#test and train datasets are combined and columns containg mean and s.d are taken
combined_data <- rbind(test_cleaned, train_cleaned)
combined_data1 <- combined_data[,1:7]

#For the second tidy dataset subject information is merged to test and train dataset
combined_data2 <- cbind(rbind(test_subject, train_subject), combined_data)
colnames(combined_data2)[1] <- "subject.id"
combined_data2$subject.id <- as.factor(combined_data2$subject.id)
combined_data2$label <- as.factor(combined_data2$label)

#data is split based on subject id and activity label
splitteddata <- split(combined_data2, list(combined_data2$subject.id, 
                                           combined_data2$label))

#This function calculates mean of each feature for each subject and each activity label
mymean <- function(df){
        df1 <- df[,-(1:2)]
        df1 <- apply(df1, 2, mean)
        res <- cbind(df[1,1:2], t(df1))
        return(res)
}

t <- lapply(splitteddata, mymean)
result2 <- do.call("rbind", t)
result2 <- result2[order(result2$subject.id),]
row.names(result2) <- NULL

#save the data into text file
write.table(combined_data1, "dataset1.txt", row.names = F)
write.table(result2, "dataset2.txt", row.names = F)
