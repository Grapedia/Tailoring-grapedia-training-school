#!/usr/bin/env nextflow

params.samples_tsv = 'data/fruits_fastq/realsamples.csv' 
params.publish_dir = 'results' 
process FastQC { 
    debug true 
    tag { sampleId } 
    publishDir path: "${params.publish_dir}/Reports/${sampleId}/FastQC", mode: 'copy', overwrite: 'true' 
    input: 
    tuple path(read1), path(read2), val(sampleId) 
    output: 
    path "*.{html,zip}" 
    script: 
    """ 
    echo "Processing ${sampleId}..." 
    fastqc -t 2 -q "${read1}" "${read2}"  
    echo "Finished processing ${sampleId}" 
    """ 
} 
workflow { 
    Channel 
    .fromPath( params.samples_tsv ) 
    .splitCsv( header: true, sep: ',' ) 
    .map { row -> tuple(file(row.sample_1), file(row.sample_2), row.fruit) } 
    .set { sample_run_ch } 
    // run FastQC process on each sample 
    FastQC(sample_run_ch) 
}
