
# Software installlation

# The following software (instructions for Unbuntu linux systems) will be used for this lesson and
# future lessons.

## make sure we are up to date

sudo apt update
sudo apt upgrade -y

## wget and/or curl

# wget and curl are command line tools for accessing resources on the web. They have slightly different command line interfaces.

sudo apt install wget curl

## fastqc

# For an Ubuntu Linux system, you can install fastqc using the `apt` system on the bash command line
# because fastq is part of the standard package archive. If you need to install another way or find
# the original materials, the are
# [https://www.bioinformatics.babraham.ac.uk/projects/fastqc/](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/).

sudo apt install fastqc

## Trimmomatic

# [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) is a read trimming tool that work on the command line It can be installed with apt.

sudo apt install trimmomatic

## Picard tools

# Fastq actually uses a library called picard, which has an associated set of command line
# [tools](https://broadinstitute.github.io/picard/). We may use them later in the semester. To
# install,

sudo apt install picard-tools

## Bowtie and bowtie2

# Bowtie and bowtie2 are programs for rapid alignment of next-generation sequencing data to a
# reference. You can install [bowtie](http://bowtie-bio.sourceforge.net/index.shtml) and
# [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) on Ubuntu using apt:

sudo apt install bowtie bowtie2


### or you may prefer bwa

sudo apt install bwa

## samtools

# Samtools is also available on the ubuntu sytem in apt, so you can use

sudo apt install samtools

## bcftools

sudo apt install bcftools

## bedtools

# The amazing [bedtools](https://bedtools.readthedocs.io/) is avaiable on apt:

sudo apt install bedtools
