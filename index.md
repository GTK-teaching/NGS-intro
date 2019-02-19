---
layout: lesson
root: .  # Is the only page that doesn't follow the pattern /:path/index.html
permalink: index.html  # Is the only page that doesn't follow the pattern /:path/index.html
---

As we saw in the bash introductory lesson, the Linux shell is a powerful system for interacting
with genomic data. Because NGS data files are so large and are often processed end-to-end, the Unix
tool/pipe metaphor works particularly well for high-throughput sequencing experiments.

> ## What does the command line approach offer over GUIs?
>
> Repetition
> : You will often need to repeat the same tasks with multiple input files. As the number of input
>   files grows, the advantages of a command-line interface over a graphical user interface (GUI)
>   also grow.
>
> Reproducibility
> : Command-line tools provide greater reproducibility than GUIs: if you need to change the
>   parameters, you can do so and regenerate all of the downstream results.
>
> Project organisation
> : As you work with more data, you will generate more results. It's not uncommon for a single
>   project to generate hundreds of data files. If you are working at a command line interface, you
>   can think about how you want to organise those files and do so in a consistent way.
>
> Scaling from desktops to servers
> : GUIs are great for interactive use on an individual computer, but if you need the power of a
>   server there is likely no GUI application to meet your needs. Command line interfaces scale well
>   to server-baed computing.
{: .callout}

**This lesson will take you through an example genomic analysis of high-throughput (NGS) sequencing data and and will help you build the skills for reproducible research.**


> ## Prerequisites
> 
> A working understanding of the bash shell, as introduced earlier in the module, is assumed. R or Python programming skills may at times be useful, but are not required.
>
> This lesson also assumes some familiarity with biological concepts, including the structure of DNA, nucleotide abbreviations, and the concept of genomic variation within a population.
{: .prereq}

{% include links.md %}
