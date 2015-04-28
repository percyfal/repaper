#!/bin/bash
#SBATCH -p node
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 48:00:00
#SBATCH -J Buenrostro

snakemake -j 16 --rerun-incomplete  atacseq_all

