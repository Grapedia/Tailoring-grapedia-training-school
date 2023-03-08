// //16 - Multiple Input
// process checkEmAll {
//     input:
//     path 'seq'

//     "echo seq*"
// }

// workflow {
//     def fastq = Channel.fromPath( "PATH/Data_Exp/*.fq" ).buffer(size: 3)
//     checkEmAll(fastq)
// }

//17 - Multiple Input wildcards
process checkEmAll {
    input:
    path 'seq?.fq'

    "cat seq1.fq seq2.fq seq3.fq"
}

workflow {
    def fastq = Channel.fromPath( "PATH/Data_Exp/*.fq" ).buffer(size: 3)
    checkEmAll(fastq)
}


