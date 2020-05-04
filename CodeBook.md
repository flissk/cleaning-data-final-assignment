Description of raw data included in URI HAR Dataset
---------------------------------------------------

-   Six datasets are included, namely `subject_train.txt`,
    `subject_test.txt`, `x_train.txt`, `x_test.txt`, `y_train.txt` and
    `y_test.txt`
-   `activity_labels.txt` links the class labels with their activity
    name (total of six activites), which is denoted by the values in
    `y_train.txt` and `y_test.txt`
-   `features.txt` lists all features derived from sensor signals, and
    thus corresponds to the `x_train.txt`, `x_test.txt` column.
    `features_info.txt` provides more info
-   `README.txt` details the research design

Work performed
--------------

Wrote R script `run_analysis.R` using `dplyr` package, to complete the
following:

1.  Appropriately labels the data set with descriptive variable names,
    e.g. `train_set`, `test_set`

2.  Uses descriptive activity names to name the activities in the data
    set, which are included in `activityLabels`

3.  Merges the training (`merged_train`) and the test (`merged_test`)
    sets to create one data set, using the rbind function.

4.  Extracts only the measurements on the mean and standard deviation
    for each measurement, by subsetting columns which contain the text
    strings `mean()` or `std()`.The dataset in question is `subset_df`,
    and is made available in `subset_df.txt`

5.  From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject. This was done by aggregating the feature/variable for every
    given \[subject id - activity\] combination. The dataset in question
    is `df_averaged`, and is made available in `averaged_df.txt`

Description of tidy data set
----------------------------

Final tidy datasets are `subset_df` (merges training and test data)
and`df_averaged` (averages all variables for every given \[subject id -
activity\] combination)

`subset_df` contains 10299 observations and 68 variables. Column 1 is
the activity number (there are 6 activities, i.e. WALKING,
WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) and
Column 2 is the ID of the research subject. The other 66 variables are
the mean and standard deviation of the feature variables.

`df_averaged` contains 180 observations and 68 variables. Column 1 is
the subject, Column 2 is the activity number and the rest are the
aggregate means of the feature variables.
