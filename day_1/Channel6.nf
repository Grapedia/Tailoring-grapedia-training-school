#!/usr/bin/env nextflow

Channel 
  .fromPath('data/randomFacts.txt')  
  .splitText()                       
  .view()

Channel 
  .fromPath('data/randomFacts.txt')  
  .splitText(by:5)                       
  .view{"Five Fruits:\n$it"}


Channel 
  .fromPath('data/randomFacts.txt') 
  .splitText() 
  .subscribe { 
    print "--- Next Fruit ---\n" 
    print it; 
  }

Channel 
  .fromFilePairs('**_{1,2}.fq',size:2,checkIfExists:true) 
  .subscribe { pair -> 
    // pair is a tuple containing two files 
    group = pair[0] 
    file1 = pair[1][0] 
    file2 = pair[1][1]
    print "\n--- Next Fruit ---\n"  
    println "Processing ${group}: ${file1} and ${file2}" 
    // your processing code here 
  }
