#!/usr/bin/env nextflow

params.fruits_csv  = "./data/fruits_fastq/*_{1,2}.fq"

Channel 
  .fromFilePairs(params.fruits_csv) 
  .view()
