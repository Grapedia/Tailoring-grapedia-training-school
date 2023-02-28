process FLYE {
    publishDir params.outdir, mode:'copy'
    scratch true

    input:
    path(filtlong_fastq)

    output:
    path("${filtlong_fastq.baseName}_flye"), emit: flye_out   
    path("${filtlong_fastq.baseName}.fasta"), emit: fasta
    path("${filtlong_fastq.baseName}.gfa"), emit: gfa

    script:
    """
    flye --nano-raw $filtlong_fastq --genome-size $params.genome_size --out-dir "${filtlong_fastq.baseName}_flye"
    cp "${filtlong_fastq.baseName}_flye/assembly.fasta" "${filtlong_fastq.baseName}.fasta"
    cp "${filtlong_fastq.baseName}_flye/assembly_graph.gfa" "${filtlong_fastq.baseName}.gfa"
    """
}

process BANDAGE {
    publishDir params.outdir, mode:'copy'
    scratch true
    
    input:
    path(gfa)


    output:
    path("${gfa.baseName}_bandage.png"), emit: png

    script:
    """
    Bandage image $gfa "${gfa.baseName}_bandage.png"
    """
}