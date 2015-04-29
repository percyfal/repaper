#!/bin/bash
#SBATCH -p node
#SBATCH -N 1
#SBATCH -t 24:00:00
#SBATCH -J Treutlein

snakemake -j 16 scrnaseq_all --rerun-incomplete

