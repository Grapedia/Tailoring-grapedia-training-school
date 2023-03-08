//Example 1 - Input type VAL
process speaker {
  debug true
  input:
  val x

 script:
  "echo Right now, $x is presenting!"
}
workflow {
  //def trainers = Channel.of("Santiago", "MarcoM", "Paolo", "MDM")
  //speaker(trainers)
  Channel.of("Santiago", "MarcoM", "Paolo", "MDM") | speaker
}

