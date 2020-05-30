files in this data set include

1. UCI HAR Dataset
2.run_analysis.R -creates a tidied version of the data using the training and test dataset included in the UCI HAR Dataset
3.codebook.txt-describes what transformations are applied on the original dataset
4.FinalData.txt-contains final output of the analysis done by run_analysis.R

Analysis R Script

performs the following transformation

1.Downloads UCI HAR Dataset and unzips it in working directory.
2.Reads and combines the subject IDs in subject_test.txt with the measurement data in the test set X_test.txt
3.combines the subject IDs and measurement data in the training set, i.e. subject_train.txt & X_train.txt
4.Merge the datasets from #2 and #3
5.Extract activity labels from activity_labels.txt and recode the merged dataset
6.column containing "mean" & "std",names are extracted from the features.txt
7.The variable names are renamed for clarity under these conditions:
	Parentheses removed, i.e. "()"
	First letter of "mean" and "std" capitalised, i.e. "Mean"
	Duplicates removed, i.e. "BodyBody"
	Hyphens removed, i.e. "-"
8.The variables in #5 are renamed with the renamed features in #7
9.The dataset from #8 is summarised by participant ID and Activity labels to yield the mean values of each variable
10.The dataset from #9 is exported to a txt file, i.e. "FinalData.txt"2.combines the subject IDs and measurement data in the training set,i.e subject_train.txt and x_train.txt
