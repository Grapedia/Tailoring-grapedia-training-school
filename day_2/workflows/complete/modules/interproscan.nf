process INTERPROSCAN {
	publishDir params.outdir

	input:
		path(fasta_prot)
	output:
		path("annotation.tsv")
	
	"""
	/app/interproscan-5.60-92.0/interproscan.sh --input ${fasta_prot} --disable-precalc --formats  tsv --outfile annotation.tsv --tempdir ${params.outdir} -iprlookup  -goterms
	"""
}