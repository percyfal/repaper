# About #

This repository contains Snakefiles and configuration files mainly for
semi-automated reproduction of results from research papers of
interest in which data is available at the [Sequence Read Archive](http://www.ncbi.nlm.nih.gov/sra). I mainly use it to test new workflows to make sure they do what I expect of them.

## Requirements ##

- [snakemake](https://bitbucket.org/johanneskoester/snakemake/wiki/Home)
- [snakemakelib](https://github.com/percyfal/snakemakelib)
- [sra toolkit](http://www.ncbi.nlm.nih.gov/Traces/sra/?view=software)
- bioinformatics software such as GATK, picard, bowtie, star - see [snakemakelib](https://github.com/percyfal/snakemakelib) for configuration instructions

Make sure to have enough diskspace. Also, once the SRA toolkit is
installed, double-check the default download location for SRA data
(via *vdb-config -i*); this is usually set to ~/ncbi. Either make a
symbolic link from this location to a disk with a lot of space, or set
and export the environment variable NCBI_HOME pointing to the spacy
disk location in order to make it visible to snakemakelib.

## Setup ##

The top directory contains template files for snakemake and
configuration. Copy to an analysis directory of choice and edit where
necessary. The application will read the configuration file
*smlconf.yaml* by default if present.

## Running ##

**Important**: before running you obviously need the SRA project
identifier!

Issue

	snakemake

to run the default rule.

## Hints ##

You can limit the workflow to specific samples, either via the command line option

	snakemake --config samples=["SAMPLE1", "SAMPLE2", etc]

or in the configuration file (see template example).

Run a rule in dry mode first to see what it does:

	snakemake -n -p rule

You can also visualize the entire workflow or the rulegraph:

	snakemake rule --dag | dot | display
	snakemake rule --rulegraph | dot | display

### Working on a cluster ###

If you have access to a cluster that runs the queue manager, you can
submit jobs using DRMAA. For instance, the following command

	snakemake rule --drmaa " -t 12:00:00 -p core -n {threads} ..." -j 20

will submit at most 20 simultaneous core jobs, each of which runs a
number of threads governed by the parameter `{threads}`. Snakemakelib
allows you to fine-tune the value of `{threads}` for rules that have
multi-threading capacity.

Some analysis folders have an sbatch.sh file for use with the SLURM
queue manager. Submitting is done as follows

	sbatch [options] sbatch.sh

