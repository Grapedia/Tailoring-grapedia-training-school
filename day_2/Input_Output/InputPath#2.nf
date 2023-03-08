// //1 - Input Path
// process topten {
//   input:
//   path query_file

//   script:
//   "head -n10 ${query_file} "
// }

// workflow {
//   def sequences = Channel.fromPath( './Data_Exp/Acc1_1.fq' )
//   topten(sequences)
// }


// //2 - Input Path
// process topten {
//   input:
//   path 'query.fq'

//   "head -n10 query.fq "
// }

// workflow {
//   def sequences = Channel.fromPath( './Data_Exp/Acc1_1.fq' )
//   topten(sequences)
// }

// // 3 - Input Path

// process foo {
//   input:
//   path x

//   script:
//   """
//   echo your_command --in $x
//   """
// }

// workflow {
//   foo('PATH/genome.fa')
// }


//4 - Input Path stageAs
process foo {
  input:
  path x, stageAs: 'data.txt'

  """
  echo your_command --in data.txt
  """
}

workflow {
  foo('PATH/genome.fa')
}