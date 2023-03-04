#!/usr/bin/env nextflow

ch1 = Channel.of("apple", "banana", "orange")
ch2 = Channel.of(3, 2, 1)

process FRUITCOUNT {
    input:
    val fruit
    val count
    
    output:
    stdout
    
    script:
    """
    echo "There are $count $fruit(s) in the basket."
    """
}

workflow {
    fruit_ch = ch1
    count_ch = ch2
    results_ch = FRUITCOUNT(fruit_ch, count_ch)
    results_ch.view()
}
