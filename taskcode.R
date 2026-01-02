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

#Task 2:merging both data frames by specific_Protein_aa
sift.fold.merge <- merge(sift_data,fold_data, by = 'specific_Protein_aa')
View(sift.fold.merge)

#According to the authors: SIFT Score below 0.05 is deleterious and FoldX score greater than 2 kCal/mol is deleterious
#Task 3: Using the criteria above, Find all mutations that have a SIFT score below 0.05 and FoldX Score above 2 (i.e: Mutations that affect both structure and function)
deleterious_mutations <- sift.fold.merge[sift.fold.merge$sift_Score < 0.05 & sift.fold.merge$foldX_Score > 2.0,]

nrow(deleterious_mutations) #there are a total of 5261 mutations harming both structure and function

#Task 4: extracting the original amino acid one-letter code from the Amino Acid column
orig_aa <- substr(deleterious_mutations$Amino_Acid.x,1,1)
#(optional) Adding the Original Amino Acid to the data frame
deleterious_mutations <- deleterious_mutations$orig_aa

#Task 5: creating a frequency table for the original amino acids
aa_count <- table(deleterious_mutations$orig_aa)
#(optional) determining the highest occuring amino acid
highest_aa <- names(aa_count)[which.max(aa_count)]

#Task 6: create a barplot and pie chart to represent the frequency distribution of the amino acids
barplot(aa_count, 
        main='Distribution of Amino Acid Occurence',
        xlab='Amino Acids(denoted by one-letter code)',
        ylab='Frequency of Occurence',
        col='darkblue')
