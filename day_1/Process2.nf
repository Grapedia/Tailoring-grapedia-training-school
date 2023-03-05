#!/usr/bin/env nextflow

process align_genome { 
    debug true

    input: 
    val genome 
    val reads
    
    output: 
    stdout
        
    script: 
    if (params.genome_aligner == 'bwa') { 
        """ 
        echo  bwa mem ${genome} ${reads} -S aligned.sam
        """ 
    } else if (params.genome_aligner == 'bowtie2') { 
        """ 
        echo  bowtie2 -x ${genome} -U ${reads} -S aligned.sam 
        """ 
    } else if (params.genome_aligner == 'hisat2') { 
        """ 
        echo  hisat2 -x ${genome} -U ${reads} -S aligned.sam
        """ 
    } else { 
        log.error "Invalid genome aligner! $params.genome_aligner"
        System.exit(1);
    } 
}


def randomElementFromList(list) {
    Random rand = new Random()
    return list[rand.nextInt(list.size())]
}

params.genome_aligner = randomElementFromList(["bwa","hisat2","minimap2","bowtie2","STAR","MyAligner"])
workflow { 
align_genome("genome.fa","sample.fq")
}
