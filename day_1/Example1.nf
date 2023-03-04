#!/usr/bin/env nextflow

process MULTIPLY {
    input:
    val y

    output:
    path "product.txt"

    script:
    """
    echo "\$(($y*2))" > product.txt
    """
}

process DISPLAY {
    input:
    path x

    output:
    stdout

    script:
    """
    echo "The product is: \$(cat $x)"
    """
}

workflow {
    number_ch = Channel.of(5,10,15)
    results_ch = MULTIPLY(number_ch)
    ch_display = DISPLAY(results_ch)
    ch_display.view()
}
