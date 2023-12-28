---
title: Setup
---


# 1. Organise your file system

Create a directory for this lesson somewhere on your computer. Inside that directory, create three directories: `data`, `src`, and `results`.  These will be the starting organisation of a project for this lesson.

# 2. Install the software you will need

You can run the software installation part (described in detail below) by running [./data/wsl-install.sh](./data/wsl-install.sh). MacOSX users may have to run brew instead of sudo apt

The following software (instructions for Unbuntu linux systems) will be used for this lesson and future lessons.

## wget and/or curl

wget and curl are command line tools for accessing resources on the web. They have slightly different command line interfaces.

~~~
sudo apt install wget curl
~~~
{: .language-bash}


## fastqc

For an Ubuntu Linux system, you can install fastqc using the `apt` system on the bash command line because fastq is part of the standard package archive. If you need to install another way or find the original materials, the are  [https://www.bioinformatics.babraham.ac.uk/projects/fastqc/](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/). 

~~~
sudo apt install fastqc
~~~
{: .language-bash}


## Trimmomatic

[Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) is a read trimming tool that work on the command line It can be installed with apt.

~~~
sudo apt install trimmomatic
~~~
{: .language-bash}

## Picard tools

Fastq actually uses a library called picard, which has an associated set of command line [tools](https://broadinstitute.github.io/picard/). We may use them later in the semester. To install, 

~~~
sudo apt install picard-tools
~~~
{: .language-bash}

## Bowtie and bowtie2

Bowtie and bowtie2 are programs for rapid alignment of next-generation sequencing data to a reference. You can install [bowtie](http://bowtie-bio.sourceforge.net/index.shtml) and [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) on Ubuntu using apt:

~~~
sudo apt install bowtie bowtie2
~~~
{: .language-bash}

## samtools

Samtools is also available on the ubuntu sytem in apt, so you can use

~~~
sudo apt install samtools
~~~
{: .language-bash}


## bcftools

~~~
sudo apt install bcftools
~~~
{: .language-bash}

## bedtools

The amazing [bedtools](https://bedtools.readthedocs.io/) is avaiable on apt:

~~~
sudo apt install bedtools
~~~
{: .language-bash}

# 3. Download the data you will need

Let's go get the data we'll need using wget and curl.  BE SURE TO HAVE CREATED THE CORRECT DIRECTORIES FIRST

The steps below can be run by running [./data/get-data.sh](./data/get-data.sh) when in the correct directory.

## metadata

`curl` normally places whatever it retrieves in the standard output. To place it in a file of the same name as the remote file, you can use the "-O" option.

~~~
cd data
curl -O https://raw.githubusercontent.com/data-lessons/wrangling-genomics/gh-pages/files/Ecoli_metadata_composite.csv

~~~
{: .language-bash}

`wget` places output in a file by default, much like `curl -O` does.

## fastq data 
~~~
cd data
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/004/SRR2589044/SRR2589044_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/004/SRR2589044/SRR2589044_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/003/SRR2584863/SRR2584863_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/003/SRR2584863/SRR2584863_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/006/SRR2584866/SRR2584866_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/006/SRR2584866/SRR2584866_2.fastq.gz 
~~~
{: .language-bash}

{% include links.md %}
