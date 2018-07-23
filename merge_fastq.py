## Merge .fastq files
## Maurits Roorda
## 2018-07-27
## Version 1.0

## This script serves to merge 2 .fastq files into 1 .fastq file

## Import packages
from Bio import SeqIO
import itertools
import sys
import os
import shutil

## Set working directory
os.chdir('')

## Take file_1.fastq and take file_2.fastq and merge them into NGS.fastq
with open('NGS.fastq', 'wb') as outFile:
    with open('file_1.fastq', 'rb') as file_1, open('file_2.fastq', 'rb') as file_2:
        shutil.copyfileobj(file_1, outFile)
        shutil.copyfileobj(file_2, outFile)
