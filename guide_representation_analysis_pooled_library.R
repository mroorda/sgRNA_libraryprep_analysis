## Guide representation analysis pooled library
## Maurits Roorda
## 2018-07-27
## Version 1.0

## This script serves to take the output file of the python script "nprot.2017.016-SD3.py" supplied by Joung et al.,
## available online at https://www.nature.com/articles/nprot.2017.016. The output file is a CSV countaining counts for
## sgRNAs from a CRISPR library. In this script, 2 density plots are produced: counts for each single sgRNA, and counts 
## for each gene targeted by the sgRNAs

## Install and load dependencies
install.packages("yaml")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("ggpubr")
library(dplyr)
library(ggplot2)
library(ggpubr)
library(yaml)

## Set working directory
setwd("C:/...")

## Import the count data "input_file.csv", remove empty rows and name the columns "gRNA_sequence" and "Counts"
gRNA_counts <- as.data.frame(read.csv("input_file.csv", header = FALSE)) 
gRNA_counts <- gRNA_counts[rowSums(is.na(gRNA_counts)) != ncol(gRNA_counts),]
colnames(gRNA_counts) <- c("sgRNA_sequence", "Counts")

## Make density plot of all counts
gRNA_counts_density <- ggplot(gRNA_counts, aes(x = Counts))+
  geom_density(fill = "lightblue", color = "black", size = 1)+
  ylab("Density")+
  ggtitle("Put your title here")+
  theme_minimal(base_size = 15) +
  theme(axis.line = element_line(colour = "black"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.title = element_text(hjust = .5))

gRNA_counts_density

## Save the plot to a file you so desire
ggsave(filename = "sgRNA count distribution.jpeg", plot = gRNA_counts_density)

## The next part of the script serves to average single sgRNA counts over each gene

## Import the file "sgRNA_mapping.txt" containing gene-gRNA sequence mapping
gRNA_map <- read.table("sgRNA_mapping.txt", sep = "\t")
gRNA_map <- as.data.frame(merge(gRNA_map,gRNA_counts, by = "sgRNA_sequence"))

## Remove "sg", "_" and "0-9" from the sgRNA_ID column
gRNA_map$sgRNA_ID <- gsub("^sg|_\\d+$", "", gRNA_map$sgRNA_ID)

## Aggregate individual genes and calculate the mean counts for each gene
gRNA_map_grouped <- aggregate(Counts ~ sgRNA_ID, data = gRNA_map, FUN = mean)

## Make density plot of average count per gene 
gRNA_gene_density <- ggplot(gRNA_map_grouped, aes(Counts))+
  geom_density(fill = "lightblue", color = "black", size = 1)+
  ylab("sgRNA/gene density")+
  ggtitle("Put your title here")+
  theme_minimal(base_size = 15) +
  theme(axis.line = element_line(colour = "black"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.title = element_text(hjust = .5))

gRNA_gene_density

## Save the plot to a file you so desire
ggsave(filename = "Average sgRNA count per gene.jpeg", plot = gRNA_gene_density)
