nextflow.enable.dsl=2

params.fasta_file = "$projectDir/../2_trinity/assembled_transcripts/trinity_out_dir/Trinity.tmp.fasta"
params.outdir = "$projectDir/iprscan_output/"

log.info """
     Nextflow Interproscan
     ===================================
     fasta_file  : ${params.fasta_file}
     outdir       : ${params.outdir}
     """
     .stripIndent()

/**
* Emboss transeq
*/	 
process transeq {
	input:
		path(fasta_nuc)
	output:
		path('proteins.fasta')
	"""
	/app/EMBOSS-6.5.7/emboss/transeq -sequence ${fasta_nuc} -outseq proteins.fasta -frame 6 -clean
	"""
}

/**
* Select sequences
*/
process select_sequences {
	input:
		path(input_fasta_file)
	output:
		path("longest_sequences.fasta")

	"""
    #!/usr/bin/python3

	sequences = {}
	_id = None
	with open("${input_fasta_file}") as fi:
		for line in fi:
			if line[0] == '>':
				_id = line.strip()
				sequences[_id] = ""
			else:
				sequences[_id] += line.strip()
	first_10 = sorted(filter(lambda x:'X' not in x[1], sequences.items()), key=lambda x:len(x[1]), reverse=True)[:5]
	with open("longest_sequences.fasta", "w") as fo:
		for _id, seq in first_10:
			fo.write(_id + "\\n" + seq + "\\n")
	"""
}

/**
* Interproscan process
*/
process iprscan {
	publishDir params.outdir

	input:
		path(fasta_prot)
	output:
		path("annotation.tsv")
	
	"""
	/app/interproscan-5.60-92.0/interproscan.sh --input ${fasta_prot} --disable-precalc --formats  tsv --outfile annotation.tsv --tempdir ${params.outdir} -iprlookup  -goterms
	"""
}

/**
* Main workflow
*/
workflow {
	prot_ch = transeq(params.fasta_file)
	seq_file = select_sequences(prot_ch)
	iprscan(seq_file)
}