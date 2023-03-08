// //1 Output Value
// process Analysis {
//   input:
//   each x

//   output:
//   val x

//   """
//   echo $x > file
//   """
// }

// workflow {
//   methods = ['protein', 'dna', 'rna']

//   receiver = Analysis(methods)
//   receiver.view { "Received: $it" }
// }

// 2 Output Value 
process foo {
  input:
  path infile

  output:
  val x
  val "${infile.baseName}.out"

  script:
  x = infile.name
  """
  cat $x > file
  """
}

workflow {
  ch_dummy = Channel.fromPath('./Data_Exp/*_{1,2}.fq')
  foo(ch_dummy)
}
