#!/usr/bin/env nextflow

params.greeting = 'Why am I here? What’s my purpose in life?' 

process Whale { 
    input: 
    val x 

    output: 
    stdout

    script:
    """
    cowsay $x
    """
} 


workflow { 
    Channel
        .of(params.greeting)
        .set { text }
    whale_ch = Whale(text) 
    whale_ch.view{ it } 
} 