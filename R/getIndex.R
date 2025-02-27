#' @title Get path to bowtie index on Rosalind
#' 
#' @description Get path to bowtie index on Rosalind
#' 
#' @param species String specifying which species.
#'     Must be either human (default), mouse, rat, fly or cyno.
#' @param what String specifying what type of index should
#'     be returned. Either "dna" (default) or "rna".
#'     For "dna", this corresponds to the reference genome.
#'     For "rna", this corresponds to a transcriptome.
#' @param allele String specifying which allele should be
#'     used for human DNA. Either "ref" (default),
#'     "major" or "minor".
#' 
#' @return String specifying path to a bowtie index
#' 
#' @author Jean-Philippe Fortin
#' 
#' @export
getBowtieIndex <- function(species=c("human",
                                     "mouse",
                                     "rat",
                                     "fly",
                                     "cyno5",
                                     "cyno6"),
                           what=c("dna", "rna"),
                           allele=c("ref", "maj", "min")
){
    species <- match.arg(species)
    what    <- match.arg(what)
    allele  <- match.arg(allele)
    root <- file.path(.getCrisprIndicesPath(),
                      "bowtie") 

    if (species!="human" & allele!="ref"){
        stop("Non-ref allele can only be used with human.")
    }

    if (what=="dna"){
       if (species=="human"){
           if (allele=="ref"){
               suffix <- "hg38/hg38"
           } else if (allele=="maj"){
               suffix <- "hg38_major/hg38_major"
           } else {
               suffix <- "hg38_minor/hg38_minor"
           }
       } else if (species=="mouse"){
           suffix <- "mm10/mm10"
       } else if (species=="rat"){
           suffix <- "Rnor6/mm10"
       } else if (species=="fly"){
          suffix <- "Rnor6/mm10"
       } else if (species=="cyno5"){
          suffix <- "cyno5/cyno5"
       } else if (species=="cyno6"){
          suffix <- "cyno6/cyno6"
       }

    } else if (what=="rna"){
        if (species=="human"){
            suffix <- "ensembl_human_104/ensembl_human_104"
        } else if (species=="mouse"){
            suffix <- "ensembl_mouse_102/ensembl_mouse_102"
        } else if (species=="cyno"){
            suffix <- "ensembl_cyno_108/ensembl_cyno_108"
        } else {
            stop("RNA index is currently only available ",
                 "for mouse, human or cyno.")
        }
    }
   
    out <- file.path(root, suffix) 
    return(out)
}


#' @title Get path to BWA index on Rosalind
#' 
#' @description Get path to BWA index on Rosalind
#' 
#' @param species String specifying which species.
#'     Must be either human (default), mouse, rat, fly or cyno.
#' @param what String specifying what type of index should
#'     be returned. Either "dna" (default) or "rna".
#'     For "dna", this corresponds to the reference genome.
#'     For "rna", this corresponds to a transcriptome.
#' @param allele String specifying which allele should be
#'     used for human DNA. Either "ref" (default),
#'     "major" or "minor".
#' 
#' @return String specifying path to a BWA index
#' 
#' @author Jean-Philippe Fortin
#' 
#' @export
getBwaIndex <- function(species=c("human",
                                  "mouse",
                                  "rat",
                                  "fly",
                                  "cyno"),
                        what=c("dna", "rna"),
                        allele=c("ref", "maj", "min")
){
    species <- match.arg(species)
    what    <- match.arg(what)
    allele  <- match.arg(allele)
    root <- file.path(.getCrisprIndicesPath(),
                      "bwa") 

    if (species!="human" & allele!="ref"){
        stop("Non-ref allele can only be used with human.")
    }

    if (what=="dna"){
       if (species=="human"){
           if (allele=="ref"){
               suffix <- "hg38/hg38"
           } else if (allele=="maj"){
               suffix <- "hg38_major/hg38_major"
           } else {
               suffix <- "hg38_minor/hg38_minor"
           }
       } else if (species=="mouse"){
           suffix <- "mm10/mm10"
       } else if (species=="rat"){
           suffix <- "Rnor6/mm10"
       } else if (species=="fly"){
          suffix <- "Rnor6/mm10"
       } else if (species=="cyno"){
          suffix <- "cyno6/cyno6"
       }
    } else if (what=="rna"){
        if (species=="human"){
            suffix <- "ensembl_human_104/ensembl_human_104"
        } else if (species=="mouse"){
            suffix <- "ensembl_mouse_102/ensembl_mouse_102"
        } else if (species=="cyno"){
            suffix <- "ensembl_cyno_108/ensembl_cyno_108"
        }else {
            stop("RNA index is currently only available",
                 " for mouse, human or cyno.")
        }
    }
   
    out <- file.path(root, suffix) 
    return(out)
}

















