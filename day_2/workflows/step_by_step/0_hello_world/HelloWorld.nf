params.str = "Hello World!"

process sayHello {
	output:
		stdout
	"""
	echo ${params.str}
	"""
}

process blastp {
	output:
		stdout
	"""
	blastp
	"""
}

workflow {
	sayHello | view
}
