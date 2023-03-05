#!/usr/bin/env nextflow

params.samples = Channel.of('sample 1', 'sample 2')
params.aligners = Channel.of('bwa')
// params.aligners = Channel.value('bwa')

process ALIGN {
    input:
    val sample
    val aligner

    output:
    stdout

    script:
    """
    echo "Aligning $sample using $aligner"
    """
}

workflow {
    align_ch = ALIGN(sample=params.samples, aligner=params.aligners)
    align_ch.view()
}
