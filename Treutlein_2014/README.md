## About ##

The Snakefile and configuration files provide a workflow to regenerate the results of the following study:

	Reconstructing lineage hierarchies of the distal lung epithelium
	using single-cell RNA-seq.

	Treutlein B, Brownfield DG, Wu AR, Neff NF, Mantalas GL, Espinoza
	FH, Desai TJ, Krasnow MA, Quake SR.

	Nature. 2014 May 15;509(7500):371-5. doi: 10.1038/nature13173. Epub
	2014 Apr 13.

	PMID: 24739965

## Requirements ##

Running the commands as is may run into a few stumbling blocks. For
instance, the quantification script
[rpkmforgenes.py](http://sandberg.cmb.ki.se/media/data/rnaseq/instructions-rpkmforgenes.html)
requires mappability estimates from the tool
[MULTo](http://sandberg.cmb.ki.se/multo/). To automate the generation
of MULTo files, set the following configuration:

    workflows.bio.scrnaseq:
	  db:
	    do_multo: True



## Running ##

Issue

	snakemake data/SRP033209_info.csv

to get the project information. First run

	snakemake -n -p scrnaseq_all

to list the commands that will be run. There are 201 samples, so it
will take some time for snakemake to calculate all rule depenencies.

Then run

	snakemake scrnaseq_all

to run the entire pipeline. To try it out on samples GSM1271862 and
GSM1271863 run

	snakemake scrnaseq_all --config samples=["GSM1271862","GSM1271863"]

For more general hints, see the main [README](../README.md)

## Rulegraph ##

![Rulegraph](./scrnaseq_all_rulegraph.png)
