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


// Closure 4

String isValidPath(String filePath) {
    File file = new File(filePath)
    if (!file.exists()) {
        log.error("Input file does not exist: {}", file);
        System.exit(1);
    }
    if (!file.canRead()) {
        log.error("Cannot read input file: {}", file);
        System.exit(1);
    }
    if (file.length() == 0) {
        log.error("Input file is empty: {}", file);
        System.exit(1);
    }
    return filePath
}

int count = 0;

Channel
   .fromPath(isValidPath('data/randomFacts.txt'))
   .splitText()
   .view { "${count += 1}: ${it.toUpperCase().trim()}" };
