process NANOPLOT {
    publishDir params.outdir, mode:'copy'
    scratch true

    input:
    path(ont_reads)

    output:
    path("${ont_reads.baseName.replaceAll(".fastq","")}_nanoplot"), emit: nanoplot_out

    script:
    """
    NanoPlot -t $task.cpus --fastq $ont_reads  --plots hex dot -o "${ont_reads.baseName.replaceAll(".fastq","")}_nanoplot" 
    """
}

process FILTLONG {
    publishDir params.outdir, mode:'copy'
    scratch true

    input:
    path(ont_reads)

    output:
    path("${ont_reads.baseName.replaceAll(".fastq","")}_filtered.fastq"), emit: fastq

    script: 
    """
    filtlong --min_length $params.min_length \
    --target_bases $params.target_bases \
    --keep_percent $params.percent \
    $ont_reads > "${ont_reads.baseName.replaceAll(".fastq","")}_filtered.fastq"
    """
}

