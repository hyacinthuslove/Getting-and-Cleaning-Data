## Getting and Cleaning Data Course Project

<B><U>Introduction</U></B><BR>
<P>This repo contains the files required (except data) for Getting and Cleaning 
Data Course Project. </P>

<B><U>Setup</U></B><BR>
<P>The data files required to run the source code can be downloaded 
from this <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">link</a>.The source code and downloaded data file should be unzipped into this folder on your computer i.e. C:/Coursera/Getting-and-Cleaning-Data/Project. Create the directory and folders if it does not exist yet.Rename the unzipped data folder "UCI HAR Dataset" to "data" before 
running the source code "run_analysis.R"</P>

<B><U>About run_analysis.R</U></B><BR>
<P>The R script run_analysis.R does the following: <BR>
1. Merges the training and the test sets to create one data set.<BR>
2. Extracts only the measurements on the mean and standard deviation for each measurement. <BR>
3. Uses descriptive activity names to name the activities in the data set<BR>
4. Labels the data set with descriptive variable names.<BR> 
5. From the data set in step 4, creates a second independent tidy data set with the average of each variable for each activity and each subject<BR></P>

<P>The data created from Step 5 is at this <a href="https://s3.amazonaws.com/coursera-uploads/user-e8f9861397ebef4141779706/972585/asst-3/17482b103e3211e4b10c030fe14d2736.txt">link</a>.</P>



