nextflow.enable.dsl=2

params.ont_reads = "$projectDir/data/*.fastq.gz"
params.reference= "$projectDir/data/MT916288_VvxVvShenhua.fasta"
params.outdir = "results"
params.percent = "95"
params.assembler = "flye"
params.iterations = "3"
params.genome_size = "160000"
params.min_length = "1000"
params.target_bases = "4000000"
params.medaka_model = "r941_min_hac_g507"

include { FILTLONG; NANOPLOT } from "./modules/preprocess-task"
include { FLYE; BANDAGE } from "./modules/assemble-task"
include { MEDAKA } from "./modules/polish-task"
include { INSPECTOR } from "./modules/qc-task"

Channel
    .fromPath(params.ont_reads , checkIfExists: true)
    .set { ont_reads_ch }

log.info """
     Assembly de novo Nextflow Pipeline
     ===================================
     long reads files   : ${params.ont_reads}
     outpur dir         : ${params.outdir}
     assembler          : ${params.assembler}
     """.stripIndent()

workflow {
    NANOPLOT(ont_reads_ch)
    FILTLONG(ont_reads_ch)
    FLYE(FILTLONG.out)
    BANDAGE(FLYE.out.gfa)
    MEDAKA(FILTLONG.out, FLYE.out.fasta)
    INSPECTOR(params.reference, ont_reads_ch, MEDAKA.out)
}
