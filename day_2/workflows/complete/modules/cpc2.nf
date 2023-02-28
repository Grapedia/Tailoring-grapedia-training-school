process CPC2 {
	input:
		path(fasta_nuc)
	output:
		path('cpc2_out.txt')
	"""
    python /app/CPC2_standalone/bin/CPC2_output_peptide.py -i ${fasta_nuc} -o cpc2_out --ORF
	"""
}

process SELECT_SEQUENCES {
    input:
		path(cpc2_out)
	output:
		path("proteins.fasta")

	"""
    #!/usr/bin/python
    first_line = True
    fo = open("proteins.fasta", "w")
    with open("${cpc2_out}") as fi:
	    for line in fi:
            if first_line:
                first_line = False
                continue
            s = line.strip().split("\\t")
            if s[8] == 'coding':
                fo.write(">" + s[0] + "\\n" + s[6] + "\\n")
    fo.close()
	"""
}