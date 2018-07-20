# sgRNA_libraryprep_analysis
Analysis of NGS data from pooled sgRNA libraries to assess library complexity. 

First, merge .fastq files into one single .fastq file using merge_fastq.py. 
Second, count sgRNA abundance using nprot.2017.016-SD3.py. 
Third, produce density plots of sgRNA and gene counts using guide_representation_analysis_pooled_library.R.
