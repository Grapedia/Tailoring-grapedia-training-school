//21 - Input each
process alignSequences {
  input:
  path seq
  each mode

  """
  t_coffee -in $seq -mode $mode
  """
}

workflow {
  sequences = Channel.fromPath('./Data_Exp/genome.fa')
  methods = ['regular', 'expresso', 'psicoffee']

  alignSequences(sequences, methods)
}