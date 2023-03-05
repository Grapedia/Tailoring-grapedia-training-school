#!/usr/bin/env nextflow

params.outdir = "./data/fruits_csv"
params.fruits = Channel.of("apple", "banana", "orange")
params.types = Channel.of("sweet", "tart", "tropical")

process CREATE_CSV {
    publishDir params.outdir, mode: "copy", overwrite:true 

    input:
    val fruit
    val type

    output:
    path "${fruit}_${type}.csv"

    script:
    """
    echo "Fruit,Type" > ${fruit}_${type}.csv
    echo "${fruit},${type}" >> ${fruit}_${type}.csv
    """
}


/// SECOND PART 

params.fruits_csv  = "./data/fruits_csv/*.csv"

process PRINT_CSV {
    
    input:
    path fruit_file
    
    output:
    stdout

    script:
    """
    cat $fruit_file
    """
}

workflow {
    ch_fruit = channel.fromPath(params.fruits_csv)
    ch_csv = PRINT_CSV(ch_fruit)
    ch_csv.view {"File: \n$it \n\n"}
}


/// THIRD PART - 


params.fruits_csv  = "./data/fruits_csv/*sweet*.csv"

process PRINT_CSV {
    
    input:
    path fruit_file
    
    output:
    stdout

    script:
    """
    cat $fruit_file
    """
}

workflow {
    ch_fruit = channel.fromPath(params.fruits_csv)
    ch_csv = PRINT_CSV(ch_fruit)
    ch_csv.view {"File: \n$it \n\n"}
}


/// FOURTH PART - Tjis will fail unleast you add ,checkIfExists :true


params.fruits_csv  = "./data/fruits_csv/*spicy*.csv"

process PRINT_CSV {
    
    input:
    path fruit_file
    
    output:
    stdout

    script:
    """
    cat $fruit_file
    """
}

workflow {
    ch_fruit = channel.fromPath(params.fruits_csv) // try to add this: ,checkIfExists :true
    ch_csv = PRINT_CSV(ch_fruit)
    ch_csv.view {"File: \n$it \n\n"}
}
