# About #

This repository contains Snakefiles and configuration files mainly for
semi-automated reproduction of results from research papers of
interest in which data is available at the [Sequence Read Archive](http://www.ncbi.nlm.nih.gov/sra). I mainly use it to test new workflows to make sure they do what I expect of them.

## Requirements ##

- [snakemake](https://bitbucket.org/johanneskoester/snakemake/wiki/Home) >= 3.4
- [snakemakelib](https://github.com/percyfal/snakemakelib) >= 0.1a11
- [sra toolkit](http://www.ncbi.nlm.nih.gov/Traces/sra/?view=software)
- bioinformatics software such as GATK, picard, bowtie, star - see [snakemakelib](http://snakemakelib.readthedocs.org) for configuration instructions
- reference data, preferably installed according to the conventions of [cloudbiolinux](https://github.com/chapmanb/cloudbiolinux#biological-data)

Make sure to have enough diskspace. Also, once the SRA toolkit is
installed, double-check the default download location for SRA data
(via *vdb-config -i*); this is usually set to ~/ncbi. Either make a
symbolic link from this location to a disk with a lot of space, or set
and export the environment variable NCBI_HOME pointing to the spacy
disk location in order to make it visible to snakemakelib.

## Setup ##

Subdirectories are named after study using the convention
"author_year". Provided you have reference data installed following
the conventions of cloudbiolinux you should be able to run the
workflows out of the box. If not, you need to set the locations of
reference files manually. Some projects require extra external
datasets; see the relevant README for more information.

For running other SRA projects, the top directory contains template
files for snakemake and configuration. Copy to an analysis directory
of choice and edit where necessary.

## Running ##

**Important**: before running you obviously need the SRA project
identifier! See the respective project readmes for more information.

## Reference data organization ##

As noted above, repaper assumes reference data is organized according
to
[cloudbiolinux](https://github.com/chapmanb/cloudbiolinux#biological-data)
conventions. Basically this means that references are stored according
to ``BIODATA_HOME/genomes/ORGANISM/BUILD/seq/BUILD.fa``, and
application specific data, such as indices, are stored in sibling
folders to ``seq``. For instance, ``bwa`` indices are stored in
``BIODATA_HOME/genomes/ORGANISM/BUILD/bwa/``. If you have reference
data organized this way, by setting the environment variable
``$BIODATA_HOME`` and loading the snakemakelib module
``snakemakelib.bio.ngs.db.cloudbiolinux``, you only have to supply the
reference in the configuration setup. Missing indices will be even
generated on the fly should you only have the reference but still
choose to use the cloudbiolinux setup.

If you don't have reference data organized as described above you need
to set metadata manually (indices, annotations, etc). Hopefully, it
will be evident which configuration keys need to be set as rules fail
due to missing dependencies.

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

If you have access to a cluster that runs the queue manager SLURM, you
can submit jobs using DRMAA. For instance, the following command

	snakemake rule --drmaa " -t 12:00:00 -p core -n {threads} ..." -j 20

will submit at most 20 simultaneous core jobs, each of which runs a
number of threads governed by the parameter `{threads}`. Snakemakelib
allows you to fine-tune the value of `{threads}` for rules that have
multi-threading capacity.

Alternatively, you can fine-tune the requirements of rules via a
cluster configuration file (e.g. *cluster.yaml*) and submit using the
following command

	snakemake rule --cluster-config cluster.yaml -j 20 --cluster " sbatch -t {cluster.time} -p {cluster.partition} -A {cluster.account} -n {cluster.n}"

Some analysis folders have an sbatch.sh file for use with the SLURM
queue manager. Submitting is done as follows

	sbatch [options] sbatch.sh

