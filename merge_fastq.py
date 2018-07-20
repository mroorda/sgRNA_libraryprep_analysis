## This script serves to merge 2 .fastq files into 1 .fastq file

from Bio import SeqIO
import itertools
import sys
import os
import shutil

os.chdir('E:/180502_NB501840_0073_AHMYHLBGX5/MB180423/MB180423_007_S7_R1_001.fastq')
with open('NGS.fastq', 'wb') as outFile:
    with open('MB180423_007_S7_R1_001.fastq', 'rb') as com, open('MB180423_008_S8_R1_001.fastq', 'rb') as fort13:
        shutil.copyfileobj(com, outFile)
        shutil.copyfileobj(fort13, outFile)