#!/usr/bin/env Rscript
# An R script to read in the exons.bed file and convert it to a simple format retaining only chromosome name, exon start, exon end and gene name

args = commandArgs(trailingOnly=TRUE)

#read in
#a <- read.table(snakemake@input[['txt']]) 
a <- read.table(args[1])

#split gene name and info to right (2nd in list of lists) away for text to left
#b <- strsplit(a[,10], "gene_name=", fixed=T) 
b <- strsplit(as.character(a[,10]), "gene_name=", fixed=T) 

#keep only gene name and info to right, discard text to left 
c <-sapply(b, "[[",2) 

#split gene name (1st in list of lists) away for 
d <- strsplit(c, ";", fixed=T) 

#keep only gene name, discard text to right
e <-sapply(d, "[[",1) 

#combine column of chromosome name, exon start, exon end with the extracted gene name
out.object <- cbind(a[1:3],e) 

#write out as file named EXONS_DNA.bed
#write.table(out.object, snakemake@output[['out']], sep = "\t", row.names = FALSE, col.names = FALSE, quote=FALSE)
write.table(out.object, args[2], sep = "\t", row.names = FALSE, col.names = FALSE, quote=FALSE)
