---
title: Setup
---

# File system

Create a directory for this lesson somewhere on your computer. Inside that directory, create three directories: `data`, `src`, and `results`.  These will be the starting organisation of a project for this lesson.


# Software 

The following software (instructions for Unbuntu linux systems) will be used for this lesson and future lessons.

## Curl

`curl` is a command line tool (and library) for getting files from remote sites. It is available on apt.

~~~
sudo apt-get install curl
~~~
{: .language-bash}



## fastqc

For an Ubuntu Linux system, you can install fastqc using the `apt` system on the bash command line because fastq is part of the standard package archive. If you need to install another way or find the original materials, the are  [https://www.bioinformatics.babraham.ac.uk/projects/fastqc/](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/). 

~~~
sudo apt-get install fastqc
~~~
{: .language-bash}


## Trimmomatic

[Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) is a read trimming tool that work on the command line It can be installed with apt.

~~~
sudo apt-get install trimmomatic
~~~
{: .language-bash}

## Picard tools

Fastq actually uses a library called picard, which has an associated set of command line [tools](https://broadinstitute.github.io/picard/). We may use them later in the semester. To install, 

~~~
sudo apt-get install picard-tools
~~~
{: .language-bash}

## Bowtie and bowtie2

Bowtie and bowtie2 are programs for rapid alignment of next-generation sequencing data to a reference. You can install [bowtie](http://bowtie-bio.sourceforge.net/index.shtml) and [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) on Ubuntu using apt:

~~~
sudo apt-get install bowtie bowtie2
~~~
{: .language-bash}

## samtools

Samtools is also available on the ubuntu sytem in apt, so you can use

~~~
sudo apt-get install samtools
~~~
{: .language-bash}

to install version Samtools version 1.7. To install the more recent samtools requires more work, and on my machine this worked

~~~
sudo apt-get install libbz2-dev
sudo apt-get install zlib1g-dev
sudo apt-get install libncurses5-dev 
sudo apt-get install libncursesw5-dev
sudo apt-get install liblzma-dev
wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
tar -vxjf samtools-1.9.tar.bz2
cd samtools-1.9
make
sudo make install
~~~
{: .language-bash}

## bedtools

The amazing [bedtools](https://bedtools.readthedocs.io/) is avaiable on apt:

~~~
sudo apt-get install bedtools
~~~
{: .language-bash}



{% include links.md %}
