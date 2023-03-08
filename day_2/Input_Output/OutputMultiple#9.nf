//28 - Multiple Output
process splitLetters {
    output:
    path 'chunk_*'

    '''
    printf 'Hola, me llamo Tomàs!' | split -b 5 - chunk_
    '''
}

workflow {
    splitLetters
        | flatten
        | view { "File: ${it.name} => ${it.text}" }
}



// //29 - Dinamic Output
// process align {
//   publishDir './results'
//   debug true
//   input:
//   val species

//   output:
//   path "${species}.aln"

//   """
//   mkdir -p results
//   echo t_coffee -in SEQ > ${species}.aln
//   """
// }

// workflow {
//     species_ch = Channel.of("cow","human","cat") | align | flatten | view { "File: ${it.name} => ${it.text}" }

// }