---
title: "Read alignment using bowtie2"
teaching: 15
exercises: 30
questions:
- "How do we perform alignment of reads, starting from a fastq file?"
objectives:
- "Understand the difference between bowtie and bowtie2, and choose the appropriate software to perform alignment."
- "Be able to align raw reads, starting from a raw fastq file." 
- "Understand the range of options available in bowtie2 for alignment." 
keypoints:
- "The choice of using bowtie or bowtie2 depends on the specifics of the data in question. bowtie2 is not simply an upgrade of bowtie."
- "Alignment using bowtie2 can be performed in two steps: generating the index file (only needs to be done once) and then perform alignment using `bowtie2`"
- "It is important to be aware of what default values for different options are when using command line tools: they are implemented to reduce the amount of options we need to explicitly specify, but occassionally needs to be modified to reflect our needs." 
---

# Read alignment using *Bowtie2* 
## Choosing between *bowtie* and *bowtie2* 
Two of the most commonly used alignment software packages are *bowtie* and *bowtie2*. Although relatively similar in usage, both software packages are used in different scenarios. This is summarized in the table below. 

|      	        |*bowtie*|*bowtie2*|
|Read length    | <50bp  |>50bp    |
|Gaps           | No     |Yes      |
|Local alignment| No     |Yes      |
|Ambiguous characters| No |Yes     |
|Max read length | 1000bp| None    |

In practical terms, *bowtie2* is preferred over *bowtie* where the read lengths are longer **or** there are insertions/deletions that are expected. On the other hand, *bowtie* is preferred when the reads are short. 

> ## Setting up 
>
> For this practical session, we will be using *bowtie2*. Install *bowtie2* on your local machines using the `apt-get` package manager. Although the version on `apt-get` might not be the latest, it will suffice for the purposes of this exercise. 

## Overview of alignment using *bowtie2* 

## Generating the *bowtie2* index files
Before we can use *bowtie2* to align the reads, we first need to provide the *index files*. These files contain information about the reference genome, such as the sequence and the coordinates. Although *bowtie2* contains some pre-compiled index files, we will walk through how to generate the index files. 

The index files are generated using a single command, `bowtie2-build`. We can find out the list of arguments and its usage as follows:

~~~
bowtie2-build -h
~~~
{: .bash}

This will yield the following:
~~~
Bowtie 2 version 2.2.5 by Ben Langmead (langmea@cs.jhu.edu, www.cs.jhu.edu/~langmea)
Usage: bowtie2-build [options]* <reference_in> <bt2_index_base>
    reference_in            comma-separated list of files with ref sequences
    bt2_index_base          write bt2 data to files with this dir/basename
*** Bowtie 2 indexes work only with v2 (not v1).  Likewise for v1 indexes. ***
Options:
    -f                      reference files are Fasta (default)
    -c                      reference sequences given on cmd line (as
                            <reference_in>)
    --large-index           force generated index to be 'large', even if ref
                            has fewer than 4 billion nucleotides
    -a/--noauto             disable automatic -p/--bmax/--dcv memory-fitting
    -p/--packed             use packed strings internally; slower, less memory
    --bmax <int>            max bucket sz for blockwise suffix-array builder
    --bmaxdivn <int>        max bucket sz as divisor of ref len (default: 4)
    --dcv <int>             diff-cover period for blockwise (default: 1024)
    --nodc                  disable diff-cover (algorithm becomes quadratic)
    -r/--noref              don't build .3/.4 index files
    -3/--justref            just build .3/.4 index files
    -o/--offrate <int>      SA is sampled every 2^<int> BWT chars (default: 5)
    -t/--ftabchars <int>    # of chars consumed in initial lookup (default: 10)
    --seed <int>            seed for random number generator
    -q/--quiet              verbose output (for debugging)
    -h/--help               print detailed description of tool and its options
    --usage                 print this usage message
    --version               print version information and quit
~~~ 
{: .output}

The usage information tells us that `bowtie2-build` requires only 2 arguments: `reference_in` and `bt2_index_base`. `reference_in` basically is the *fasta* file containing the sequence of the entire genome. This has been provided for todays' class, and should be downloaded. `bt2_index_base` is the prefix of the index file. What happens at the end of running `bowtie2-build` is that a series of files ending with `.bt2` (the index files) will be generated. 

> ## A note on index files
>
> Although *bowtie* and *bowtie2* are similar, their index files cannot be used interchangeably. *bowtie* index files end with `.bt` whilst *bowtie2* index files end with `.bt2`. 

> ## Try it
>
> Download the fasta file containing the human genome. Thereafter, create the *bowtie2* index files. This can take sometime, so be patient with it.
{: .challenge}

> ## A note on index variables
>
> In the previous class, you have been introduced to the concept of an environment variable. It happens that one can specify the location of *bowtie2* index files using the environment variable `BOWTIE2_INDEXES` (for *bowtie*, it will be `BOWTIE_INDEXES`). What is commonly done is the following:
> 1. Create a folder for storing the index files.
> 2. Create the index files in the designated folder.
> 3. Use `export BOWTIE2_INDEXES=<path>` to export the environment variable.
>
> The advantage of so-doing is that you do not need to type the whole path name when you run `bowtie2` later on. Also, it allows us to maintain a more tidy file directory structure as we can store the indexes at different folders instead of having everything in the `Downloads` folder.


## Aligning reads to the reference genome
While `bowtie2-build` works hard to build the index files (this can take up to 15 minutes), we will discuss the usage of `bowtie2` which is the workhorse of alignment. Typing `bowtie2 -h` will yield a **very long** page full of arguments that we can provide to `bowtie2` when we perform the alignment. 

~~~
jeremy@atlas:~$ bowtie2
No index, query, or output file specified!
Bowtie 2 version 2.2.5 by Ben Langmead (langmea@cs.jhu.edu, www.cs.jhu.edu/~langmea)
Usage: 
  bowtie2 [options]* -x <bt2-idx> {-1 <m1> -2 <m2> | -U <r>} [-S <sam>]

  <bt2-idx>  Index filename prefix (minus trailing .X.bt2).
             NOTE: Bowtie 1 and Bowtie 2 indexes are not compatible.
  <m1>       Files with #1 mates, paired with files in <m2>.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <m2>       Files with #2 mates, paired with files in <m1>.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <r>        Files with unpaired reads.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <sam>      File for SAM output (default: stdout)

  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be
  specified many times.  E.g. '-U file1.fq,file2.fq -U file3.fq'.

Options (defaults in parentheses):

 Input:
  -q                 query input files are FASTQ .fq/.fastq (default)
  --qseq             query input files are in Illumina's qseq format
  -f                 query input files are (multi-)FASTA .fa/.mfa
  -r                 query input files are raw one-sequence-per-line
  -c                 <m1>, <m2>, <r> are sequences themselves, not files
  -s/--skip <int>    skip the first <int> reads/pairs in the input (none)
  -u/--upto <int>    stop after first <int> reads/pairs (no limit)
  -5/--trim5 <int>   trim <int> bases from 5'/left end of reads (0)
  -3/--trim3 <int>   trim <int> bases from 3'/right end of reads (0)
  --phred33          qualities are Phred+33 (default)
  --phred64          qualities are Phred+64
  --int-quals        qualities encoded as space-delimited integers

 Presets:                 Same as:
  For --end-to-end:
   --very-fast            -D 5 -R 1 -N 0 -L 22 -i S,0,2.50
   --fast                 -D 10 -R 2 -N 0 -L 22 -i S,0,2.50
   --sensitive            -D 15 -R 2 -N 0 -L 22 -i S,1,1.15 (default)
   --very-sensitive       -D 20 -R 3 -N 0 -L 20 -i S,1,0.50

  For --local:
   --very-fast-local      -D 5 -R 1 -N 0 -L 25 -i S,1,2.00
   --fast-local           -D 10 -R 2 -N 0 -L 22 -i S,1,1.75
   --sensitive-local      -D 15 -R 2 -N 0 -L 20 -i S,1,0.75 (default)
   --very-sensitive-local -D 20 -R 3 -N 0 -L 20 -i S,1,0.50

 Alignment:
  -N <int>           max # mismatches in seed alignment; can be 0 or 1 (0)
  -L <int>           length of seed substrings; must be >3, <32 (22)
  -i <func>          interval between seed substrings w/r/t read len (S,1,1.15)
  --n-ceil <func>    func for max # non-A/C/G/Ts permitted in aln (L,0,0.15)
  --dpad <int>       include <int> extra ref chars on sides of DP table (15)
  --gbar <int>       disallow gaps within <int> nucs of read extremes (4)
  --ignore-quals     treat all quality values as 30 on Phred scale (off)
  --nofw             do not align forward (original) version of read (off)
  --norc             do not align reverse-complement version of read (off)
  --no-1mm-upfront   do not allow 1 mismatch alignments before attempting to
                     scan for the optimal seeded alignments
  --end-to-end       entire read must align; no clipping (on)
   OR
  --local            local alignment; ends might be soft clipped (off)

 Scoring:
  --ma <int>         match bonus (0 for --end-to-end, 2 for --local) 
  --mp <int>         max penalty for mismatch; lower qual = lower penalty (6)
  --np <int>         penalty for non-A/C/G/Ts in read/ref (1)
  --rdg <int>,<int>  read gap open, extend penalties (5,3)
  --rfg <int>,<int>  reference gap open, extend penalties (5,3)
  --score-min <func> min acceptable alignment score w/r/t read length
                     (G,20,8 for local, L,-0.6,-0.6 for end-to-end)

 Reporting:
  (default)          look for multiple alignments, report best, with MAPQ
   OR
  -k <int>           report up to <int> alns per read; MAPQ not meaningful
   OR
  -a/--all           report all alignments; very slow, MAPQ not meaningful

 Effort:
  -D <int>           give up extending after <int> failed extends in a row (15)
  -R <int>           for reads w/ repetitive seeds, try <int> sets of seeds (2)

 Paired-end:
  -I/--minins <int>  minimum fragment length (0)
  -X/--maxins <int>  maximum fragment length (500)
  --fr/--rf/--ff     -1, -2 mates align fw/rev, rev/fw, fw/fw (--fr)
  --no-mixed         suppress unpaired alignments for paired reads
  --no-discordant    suppress discordant alignments for paired reads
  --no-dovetail      not concordant when mates extend past each other
  --no-contain       not concordant when one mate alignment contains other
  --no-overlap       not concordant when mates overlap at all
---
 
~~~
{: .output}

Now that is some seriously long list of options! Thankfully, we will not be required to provide parameters for all the options. In fact, for most practical purposes, we use the defaults for most of the arguments. 

Lets start by looking at the usage. The usage of `bowtie2` is simple, and takes the following form: 

~~~
bowtie2 [options]* -x <bt2-idx> {-1 <m1> -2 <m2> | -U <r>} [-S <sam>]
~~~
{: .bash}

Remember the index files we generated earlier on? Here, we need to tell `bowtie2` where these files are located, and the prefix of the files. In this way, we can (in theory) have the index files of many different genomes stored in the same location. This is specified in the `-x` argument. The next set of arguments `-1 <m1> -2 <m2>| -R <r>` basically tell `bowtie2` where the fastq files are. As you will recall, NGS can yield either paired-end reads or unpaired-end reads. If we are working with paired-end reads, the results will be returned in 2 files (one for each strand). If such is the case, we will use `-1 <name> -2 <name>`. However, for unpaired end reads, we will only need to use `-U <name>`. Finally, the last option `-S <sam>` specifies the output SAM files. This needs to be specified explicitly. 

> ## Find out -- writing of results
>
> What happens if no SAM file is specified with the `-S` option? 
{: .challenge}

> ## Find out -- reporting of alignments
>
> Above, we have discussed what happens if one does not specify the output SAM file using the `-S` option. However, the minimal usage (as shown above) makes certain assumptions about what parameters will be used for the alignment. One important thing to consider is how alignments are reported. What happens if a read can be mapped to more than one location along the reference genome? Will *bowtie2* provide the coordinates of said read? And if it does, how does it decide which coordinates to provide? 
{: .challenge}

> ## Find out -- mismatches
>
> Will running *bowtie2* with default options allow for mismatches between the read and the reference genome? If so, how many mismatches are allowed? Which option controls this?
{: .challenge}

> ## Try it!
>
> Having understood some of the more critical parameters that determine the alignment result, now try to align the reads to the reference genome.
{: .challenge}