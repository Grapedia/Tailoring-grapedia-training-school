#!/usr/bin/env nextflow

process myTask { 
    debug true
    
    input: 
    val n
    
    output:
    stdout
    
    shell: 
    '''
    HI='I have: '
    echo $HI !{n}
    ''' 
}

workflow {
    myWord = Channel.of("Apple","Orange","Watermelon")
    myTask(myWord)
}
