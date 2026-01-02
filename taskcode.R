#importing the data sets
fold_data<- read.delim('https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/foldX.tsv', header= TRUE, sep = '')
sift_data<- read.delim('https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/sift.tsv', header=TRUE,sep='')

#checking the data structure and summary
str(sift_data)
summary (sift_data)
str (fold_data)
summary (fold_data)

#Task 1: creating new columns in each data set named "specific_Protein_aa' that is a concantenation of the Protein and Amino Acid columns
sift_data$specific_Protein_aa <- paste(sift_data$Protein,sift_data$Amino_Acid, sep='_')
fold_data$specific_Protein_aa <- paste(fold_data$Protein,fold_data$Amino_Acid, sep='_')
