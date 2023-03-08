
//1 - Input multiple channel - Poison pill
process foo {
  debug true
  input:
  val x
  val y

  script:
  """
  echo $x and $y
  """
}

workflow {
  x = Channel.of(1, 2)
  y = Channel.of('a', 'b', 'c')
  foo(x, y)
}

//2 - Input multiple channel value/of
process bar {
  debug true
  input:
  val x
  val y

  script:
  """
  echo $x and $y
  """
}

workflow {
  x = Channel.value(1)
  y = Channel.of('a', 'b', 'c')
  bar(x, y)
}