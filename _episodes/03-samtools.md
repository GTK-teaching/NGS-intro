---
title: "Samtools"
teaching: 15
exercises: 15
questions:
- "What are Samtools?"
- "What is SAM format?"
- "How to find specific alignment?"
objectives:
- "Explain SAM and BAM format."
- "Learn basic usage of Samtools."
- "Understand the FLAG in SAM format."
keypoints:

---

The Sequence Alignment/Map (SAM) format is tab-delimited text format that describes the alignment of read sequences to a reference genome. It is simple and flexible enough to store alignment information by alignment programs.

## What is Samtools

Samtools is a powerful tools that primarily concerned with manipulating SAM files. It allow users to get suitable and desirable input for the downstream analysis.

## SAM format

Now let's take a closer look at SAM file.

SAM files consist of two types of lines: headers and alignments.

* Headers begin with @, and provide meta-data regarding the entire alignment file.

* Alignments begin with any character except @, and describe a single alignment of a sequence read against the reference genome.


Each alignment in SAM format consist of 11 fields, and may also be followed by various optional fields. Take the following alignment for example. The 11 mandatory fields are:

> SRR035022.2621862 163 16 59999 37 22S54M = 60102 179 CCAACCCAACCCTAACCCTAACCCTAACCCTAACCCTAACCCTAACCCTAACCCTAACCGACCCTCACCCTCACCC >AAA=>?AA>@@B@B?AABAB?AABAB?AAC@B?@AB@A?A>A@A?AAAAB??ABAB?79A?AAB;B?@?@<=8:8 XT:A:M XN:i:2 SM:i:37 AM:i:37 XM:i:0 XO:i:0 XG:i:0 RG:Z:SRR035022 NM:i:2 MD:Z:0N0N52 OQ:Z:CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCCCCCCBBCC@CCCCCCCCCCACCCCC;CCCBBC?CCCACCACA@

| Field name   |Description    |Example |
| ------------ |---------------|--------|
| QNAME        | Unique identifier of the read derived from the original FASTQ file. | SRR035022.2621862 |
| FLAG | A single integer value (e.g. 16), which encodes multiple elements of meta-data regarding a read and its alignment.| 163 |
| RNAME | Reference genome identifier | 16|
| POS | 	Left-most position within the reference genome where the alignment occurs.(**1-based** ) | 59999|
| MAPQ | Quality of the genome mapping. The MAPQ field uses a Phred-scaled probability value to indicate the probability that the mapping to the genome is incorrect. Higher values indicate increased confidence in the mapping. | 37|
| CIGAR | A compact string that (partially) summarizes the alignment of the raw sequence read to the reference genome. Three core abbreviations are used: M for alignment match; I for insertion; and D for Deletion.  | 22S54M|
| RNEXT | Reference genome identifier where the mate pair aligns. Only applicable when processing paired-end sequencing data. A value of * indicates that information is not available;‘=’ if RNEXT is identical RNAME| =|
| PNEXT | Position with the reference genome, where the second mate pair aligns. As with RNEXT, this field is only applicable when processing paired-end sequencing data. A value of 0 indicates that information is not available. | 60102|
| TLEN | Template Length. Only applicable for paired-end sequencing data, TLEN is the size of the original DNA or RNA fragment, determined by examining both of the paired-mates, and counting bases from the left-most aligned base to the right-most aligned base. A value of 0 indicates that TLEN information is not available. |179|
| SEQ | The raw sequence, as originally defined in the FASTQ file.| CCAACCCAACCCTAACCCTAACCCTAACCCTAACCCTAACCCTAACCCTAACCCTAACCGACCCTCACCCTCACCC|
| QUAL | The Phred quality score for each base, as originally defined in the FASTQ file. | >AAA=>?AA>@@B@B?AABAB?AABAB?AAC@B?@AB@A?A>A@A?AAAAB??ABAB?79A?AAB;B?@?@<=8:8|

> ## Optional fields
>
> SAM file also allows optional fields to be stored, which we will not cover in this practical. If you are interested, you can refer to [manual of SAM](https://samtools.github.io/hts-specs/SAMtags.pdf)
>
{: .callout}

### FLAG

The flag field in SAM in a *combination* of bitwise FLAGs. It can provide us with many useful information.

|FLAG| Description|
|---|------------|
|1 or 0x1|Template having multiple segments in sequencing|
|2 or 0x2|Each segment properly aligned according to the aligner|
|4 or 0x4|Segment unmapped|
|8 or 0x8|Next segment in the template unmapped|
|16 or 0x10|SEQ being reverse complemented|
|32 or 0x20|SEQ of the next segment in the template being reversed|
|64 or 0x40|The first segment in the template|
|128 or 0x80|The last segment in the template|
|256 or 0x100|Secondary alignment|
|512 or 0x200|Not passing quality controls|
|1024 or 0x400|PCR or optical duplicate|
|2048 or 0x800|Supplementary alignment|

> ## Single-end V.S. Paired-end
>
> If 0x1 is unset, no assumptions can be made about 0x2, 0x8, 0x20, 0x40 and 0x80.
>
{: .challenge}

Those 0x1,0x2... are hexadecimal numbers (base 16) as opposed to decimal numbers (base 10).

There are tools that can be used to interpret the flag. [Picard](https://broadinstitute.github.io/picard/explain-flags.html) is a good one.

> ## Try it
>
> If you see a alignment with a flag value of 163, what does it tell you about the alignment? What about the flag of its mate?
>
>
{: .challenge}


## Converting SAM to BAM

To do anything meaningful with alignment data from Bowtie2 or other aligners (which produce text-based SAM output), we need to first convert the SAM to its binary counterpart, BAM format. The binary format is much easier for computer programs to work with. However, it is consequently very difficult for humans to read.You can do:

~~~
samtools view -b -S -o sample.bam sample.sam
~~~
{: .bash}

* `-b`: Indicate the output to be BAM format
* `-S`: Indicate the input to be SAM format
* `-o`: Specifies the output file name

Or you can also use a pipe line:

~~~
samtools view -b -S sample.sam > sample.bam
~~~
{: .bash}

Even if BAM format is unreadable, we can use view command to display all alignments.

~~~
samtools view sample.bam | head
~~~
{: .bash}

> ## Exercise
>
> Try to converting your SAM file to BAM file
>
>
{: .challenge}

View command of Samtools also allows us to display specified alignments. As we discussed earlier, the FLAG field in the BAM format encodes several key pieces of information regarding how an alignment aligned to the reference genome. We can exploit this information to isolate specific types of alignments that we want to use in our analysis.

~~~
samtools view -f 4 sample.bam | head
~~~
{: .bash}

* `-f`: Extract those alignments that match the specified SAM flag. In the case above, we are only looking for alignments with flag value of 4(read fails to map to the reference genome.)

Now, we can also exclude alignments that match:

~~~
samtools view -F 4 sample.bam | head
~~~
{: .bash}

You can also try out `-c` option, which output number of alignments instead of alignments themselves.

~~~
samtools view -c -f 4 sample.bam | head
~~~
{: .bash}

`-q` option can perform a mapping quality score filter of the alignments.

~~~
samtools view -c -q 42 sample.bam | head
~~~
{: .bash}

This would output the number of alignments that have a mapping quality score of 42 or higher.

> ## Exercise
>
> Count the number of reversely-mapped reads with a quality score cutoff 42 in your BAM file.
>
> Hint: flag 0x10 = SEQ being reverse complemented
>
> > ## Solution
> >
> > samtools view -q 42 -F 0x4 -f 0x10 sample.bam &#124; wc -l
> >
> > or: samtools view -c -q 42 -F 0x4 -f 0x10 sample.bam
> >
> {: .solution}
{: .challenge}


## Sorting a bam file

When you align FASTQ files with all current sequence aligners, the alignments produced are in random order with respect to their position in the reference genome. In other words, the BAM file is in the order that the sequences occurred in the input FASTQ files. You can observe that using Samtools view command.

There are two options for sorting BAM files: by read name (`-n`), and by genomic location (default).

~~~
samtools sort sample.bam sample.sorted
~~~
{: .bash}

Now use the view command again to see the order.

## Indexing

Indexing a genome sorted BAM file allows one to quickly extract alignments overlapping particular genomic regions. Moreover, indexing is required by genome viewers such as IGV so that the viewers can quickly display alignments in each genomic region to which you navigate.

~~~
samtools index sample.sorted.bam
~~~
{: .bash}

This will create a BAM index file with `.bai` extension. Note that if you attempt to index a BAM file which has not been sorted, you will receive an error and indexing will fail.

After indexing, we are allowed to see all alignments with a specific loci.

~~~
samtools view sample.sorted.bam chr1:200000-500000
~~~
{: .bash}

> ## Exercise
>
> Sort your BAM file and create an index file of the sorted BAM file. Then, count the number of reversely-mapped reads between chr3:123456 and chr3:124456
>
> > ## Solution
> >
> > samtools view -F 0X4 -f 0X10 sample.sorted.bam chr3:123456-124456 &#124; wc -l
> >
> > or: samtools view -c -F 0X4 -f 0X10 sample.sorted.bam chr3:123456-124456
> >
> {: .solution}
{: .challenge}

## Flagstat

The flagstat command provides a summary statistics on a BAM file.

~~~
samtools flagstat sample.sorted.bam
~~~
{: .bahs}

It may look like this:

~~~
2000000 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
1678598 + 0 mapped (83.93%:-nan%)
2000000 + 0 paired in sequencing
1000000 + 0 read1
1000000 + 0 read2
1357268 + 0 properly paired (67.86%:-nan%)
1507166 + 0 with itself and mate mapped
171432 + 0 singletons (8.57%:-nan%)
24214 + 0 with mate mapped to a different chr
16100 + 0 with mate mapped to a different chr (mapQ>=5)
~~~
{: .output}

> ## Challenge!
>
> Print out your flagstat summary, try to find out whether the number coincide with the number you get using flag.
>
> > ## Hint.
> >
> > Refer to the [manual of Samtools](http://www.htslib.org/doc/samtools.html) on flagstat part.
> >
> {: .solution}
{: .challenge}
