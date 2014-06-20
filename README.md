cdcourseproject1
================

READ ME FILE 

   I downloaded the data and unzipped it before I started writting the scripts
   Data downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Datas      et.zip 
   
  _______________________________________________
  
  I place the following text file on my working directory so I could upload them using scripts
  -activity_table.txt
  -features.txt
  -feature_info.txt
  
  
  I used the plyr package and reshape2
  
  ______________________________________________________________________
  
  STEP 1. Merging The Data
  
  -I read the "Xtrain.txt"" data in xtrain and the "y_train.txt" in "ytrain"" and sunjecttrain.txt data    
  into strain
  
  -Then I binded all this data along the columns using cbind
   I saved this data in "traind" data frame
  
  -Similarly, I did this with the test data and saved it into "testd" data frame
  
  
  -then I merged the "traind"" and "testd" along the rows using rbind into the "mdata" dataframe
  
  - mdata has dimentions 10299  by 563. mdata is short for merged data

 ______________________________________________________________
 STEPS 2. and 4. Extracting the columns involving mean and standard deviation / 
   Uses descriptive variable   names
    
  -I read the "features.txt" data into cnames
  -i stored the second column of cnames into cnames1  
  -i removed any non alpha numberic charactes using the gsub command
  -I used the grep command to get all the  column numbers who's  names include mean and standard
  deviation. I also included the column number for activity and subject. 
  -I stored this column numers in  nmeanstd 
  - I used the number from nmeanstd to subset my mdata\
  - the data incuding only mean and standard deviation is in dataframe edata
  -edata is short for extracted data
  
  ______________________________________________________________
  STEP 3. Replacing activity number with descriptive neames
    
 -I read the activity_lables into actlabel
 -then I used the sub command to replace the activity nuber 
 with its descriptive name
 
 _________________________________________________________
 STEP 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  - I saved all the variable names into nedata1
  - I melted the data and saved it into datamelt
  - I casted the data ids are "activity" and "subject"
  - Each variable is the mean measuremend for each subject and activity combination
  for more infor on variables go to the code book
  -there is a different row for each subject

  
  

  # here we melt the data ids activity and subject all other col names are variables
  
  datamelt <- melt(edata,id = c("activity","subject"), measure.vars = nedata1   )
  
  # here we compute the mean of each variable for each subject and activity
  
  tidydata <- dcast(datamelt,subject~variable+activity,mean)
 
  
  
  
  
