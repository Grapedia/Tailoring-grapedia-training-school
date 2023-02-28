process TRINITY {
	input:
		path(reads_forward)
        path(reads_reverse)
	output:
		path("trinity_out_dir/Trinity.tmp.fasta")
	"""
	Trinity --seqType fq --left ${reads_forward} --right ${reads_reverse} --max_memory 1G --CPU 3 --output trinity_out_dir
	"""
}