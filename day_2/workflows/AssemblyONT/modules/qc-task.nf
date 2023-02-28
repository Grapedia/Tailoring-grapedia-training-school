process INSPECTOR {
    publishDir params.outdir, mode:'copy'
    scratch true

    input:
    path(reference)
    path(long_reads)
    path(reads)

    output:
    path("${reads.baseName}_inspector"), emit: inspector_out

    script:
    """
    inspector.py -t ${task.cpus} -c $reads \
    --ref $reference \
    -r $long_reads \
    -o "${reads.baseName}_inspector" --datatype nanopore
    """
}
