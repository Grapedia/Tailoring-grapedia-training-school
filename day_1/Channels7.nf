#!/usr/bin/env nextflow

// Closure

def result = { x -> x * x }

println result(5)


// Closure 2

count=1 
Channel 
  .fromPath('data/rand*.txt') 
  .splitText() 
  .view { "${count++}: ${it.toUpperCase().trim()}" }

// Closure 3

count=0 
Channel 
  .fromPath('data/rand*.txt') 
  .splitText(by:5) 
  .view { "\n${count = count + 5 }: ${it.toUpperCase().trim()}\n" }

