process MEDAKA {
    publishDir params.outdir, mode:'copy'
    scratch true
    
    input:
    path(filtlong_fastq)
    path(draft_fasta)

    output:
    path("${filtlong_fastq.baseName}_consensus.fasta"), emit: fasta

    script:

    """
    medaka_consensus -t ${task.cpus} -m $params.medaka_model -i $filtlong_fastq -d $draft_fasta -o .
    cp ./consensus.fasta "${filtlong_fastq.baseName}_consensus.fasta"
    """
}
