process TRIMMOMATIC {
	input:
		tuple val(sample), path(reads)
	output:
		path("${sample}_trimmed_1.fastq.gz")
		path("${sample}_trimmed_2.fastq.gz")
	"""
	java -jar /app/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 ${reads[0]} ${reads[1]} ${sample}_trimmed_1.fastq.gz ${sample}_trimmed_forward_unpaired.fq.gz ${sample}_trimmed_2.fastq.gz ${sample}_trimmed_reverse_unpaired.fq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
	"""
}