Getting and Cleaning Data
=========================
Here I have described the steps that I followed to clean up the data. This is my first attempt towards writing a README file. Suggestions to improve it are welcomed.

#Reading the files into R
The files are read into R studio using *list.files()* function and assigned it to suitable variables. 

#Creating first tidy dataset
##Attach features label to training and testing datasets
After training dataset, test dataset and features.txt have been read into R, feature labels were merged into train and test datsets. 

##Attach activity labels to train and test datasets
Text file containg activity labels along with files containg activity information for test and train were loaded in R. values from 1-6 in y_test.txt and y_train.txt were changed into activity labels("Walking", "Sitting" etc.). 

##Extract mean and standard deviation features from trian and test datasets
Columns containg mean and stadard deviation labels were extracted. Training and Test datasets were merged using *rbind* to get first clean dataset

#Creating second tidy dataset
##Splitting data based on subject id and activity label
Text file containing subject id for test and train datasets were loaded and merged with corresponding datasets. Test and train datsets were combined and then spltted based on their subject id and activity label. 

##Calculating mean of each variable and each activity
For calculating mean, I wrote a function called *mymean* that calculates the mean of each feature variable across all splitted dataframes. The result will be a list each containing mean of each feature variable for each subject and each activity.

##Merging Results
Results in the list are then merged to obtain the second dataset

#Saving Results in a text file
datasets1 and dataset2 are then saved into text file.
 



