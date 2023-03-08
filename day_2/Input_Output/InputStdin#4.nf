// 1 - Stdin
process videogames {
  input:
  stdin str

  """
  cat -
  """
}

workflow {
  Channel.of('Fallout', 'GTA', 'Hogwarts Legacy', 'Skyrim','Elden Ring')
     | map { it + '\n' }
    | videogames
}
