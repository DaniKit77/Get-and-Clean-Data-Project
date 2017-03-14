# Get-and-Clean-Data-Project

This repo holds the [run_analysis.R](https://github.com/DaniKit77/Get-and-Clean-Data-Project/blob/master/run_analysis.R) script. It is a script developed per the instructions from the Coursera course "Getting and Cleaning Data" final assignment. The data utilized for the project is data collected from the accelerometers from the Samsung Galaxy S smartphone. The goal of the assignment is to take the large collection of measurements and condense ("get and clean") into a tidy data set.

The script will do the following: 
1. downlad data files (assuming in home directory) from a group of files called "UCI HAR Dataset"
2. process the files into a dataframe (note that a few of the files are info files and do not yield direct data)
3. join the two major dataframes (one for the test experimental group and one for the training experimental group) into one large dataframe
4. rename columns for easy referencing
5. extract from the joined dataframe only measurements of mean and standard deviation of the measurements
6. check for any NA values
7. form a tidy data set by grouping the extracted data (no. 5 above) according to subject (30 total), experimental group(test or training), and activity (6 possible; lying, walking, etc.) and average measurements according to grouping
8. clean up column names
9. write a new "tidytable.txt" to home directory
