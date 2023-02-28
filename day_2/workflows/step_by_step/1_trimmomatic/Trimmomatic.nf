nextflow.enable.dsl=2

params.short_reads = "$projectDir/../../../data/*_{1,2}.fastq.gz"
params.outdir = "$projectDir/trimmed_data/"

Channel
    .fromFilePairs(params.short_reads, checkIfExists: true)
    .set { read_pairs_ch }

log.info """
     Nextflow Trimmomatic
     ===================================
     short reads  : ${params.short_reads}
     outdir       : ${params.outdir}
     """
     .stripIndent()

process trimmomatic {
	publishDir params.outdir

	input:
		tuple val(sample), path(reads)
	output:
		path("${sample}_trimmed_1.fastq.gz")
		path("${sample}_trimmed_2.fastq.gz")
	"""
	java -jar /app/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 ${reads[0]} ${reads[1]} ${sample}_trimmed_1.fastq.gz ${sample}_trimmed_forward_unpaired.fq.gz ${sample}_trimmed_2.fastq.gz ${sample}_trimmed_reverse_unpaired.fq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
	"""
}

workflow {
	trimmomatic(read_pairs_ch)
}
