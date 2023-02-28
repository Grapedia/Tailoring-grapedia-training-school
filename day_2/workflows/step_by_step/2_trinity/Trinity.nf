nextflow.enable.dsl=2

params.short_reads = "$projectDir/../1_trimmomatic/trimmed_data/*_{1,2}.fastq.gz"
params.outdir = "$projectDir/assembled_transcripts/"

Channel
    .fromFilePairs(params.short_reads, checkIfExists: true)
    .set { read_pairs_ch }

log.info """
     Nextflow Trinity
     ===================================
     short reads  : ${params.short_reads}
     outdir       : ${params.outdir}
     """
     .stripIndent()


process trinity {
	publishDir params.outdir

	input:
		tuple val(sample), path(reads)
	output:
		path("trinity_out_dir/Trinity.tmp.fasta")
	"""
	Trinity --seqType fq --left ${reads[0]} --right ${reads[1]} --max_memory 1G --CPU 3 --output trinity_out_dir
	"""
}

workflow {
	trinity(read_pairs_ch)
}
