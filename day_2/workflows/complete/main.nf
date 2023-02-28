nextflow.enable.dsl=2

params.short_reads = "$projectDir/../../data/*_{1,2}.fastq.gz"
params.outdir = "$projectDir/transcripts/"

Channel
    .fromFilePairs(params.short_reads, checkIfExists: true)
    .set { read_pairs_ch }

include { TRIMMOMATIC } from "./modules/trimmomatic"
include { TRINITY } from "./modules/trinity"
include { CPC2;SELECT_SEQUENCES } from "./modules/cpc2"
include { INTERPROSCAN } from "./modules/interproscan"

log.info """
     Nextflow RNA de novo assembly and annotation pipeline
     =====================================================
     short reads  : ${params.short_reads}
     outdir       : ${params.outdir}
     """
     .stripIndent()

workflow{
    TRIMMOMATIC(read_pairs_ch)
    TRINITY(TRIMMOMATIC.out)
    CPC2(TRINITY.out)
    SELECT_SEQUENCES(CPC2.out)
    INTERPROSCAN(SELECT_SEQUENCES.out)
}