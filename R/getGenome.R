#' @title Shortcut to get a default BSGenome object
#' 
#' @description Shortcut to get a default BSGenome object
#' 
#' @param species String specifying which species.
#'     Must be either human (default), mouse, rat, fly or cyno. 
#' 
#' @return BSgenome object.
#' 
#' @author Jean-Philippe Fortin
#' 
#' @export
#' @importFrom BSgenome.Hsapiens.UCSC.hg38 BSgenome.Hsapiens.UCSC.hg38
#' @importFrom BSgenome.Mmusculus.UCSC.mm10 BSgenome.Mmusculus.UCSC.mm10
#' @importFrom BSgenome.Rnorvegicus.UCSC.rn6 BSgenome.Rnorvegicus.UCSC.rn6
#' @importFrom BSgenome.Dmelanogaster.UCSC.dm6 BSgenome.Dmelanogaster.UCSC.dm6
#' @importFrom BSgenome.Mfascicularis.NCBI.6.0 BSgenome.Mfascicularis.NCBI.6.0
#' @importFrom BSgenome.Mfascicularis.NCBI.5.0 BSgenome.Mfascicularis.NCBI.5.0
getGenomePackage <- function(species=c("human",
                                       "mouse",
                                       "rat",
                                       "fly",
                                       "cyno5",
                                       "cyno6")
){
    species <- match.arg(species)
    if (species=="human"){
        bsgenome <- BSgenome.Hsapiens.UCSC.hg38
    } else if (species=="mouse"){
        bsgenome <- BSgenome.Mmusculus.UCSC.mm10
    } else if (species=="rat"){
        bsgenome <- BSgenome.Rnorvegicus.UCSC.rn6
    } else if (species=="fly"){
        bsgenome <- BSgenome.Dmelanogaster.UCSC.dm6
    } else if (species=="cyno5"){
        bsgenome <- BSgenome.Mfascicularis.NCBI.5.0
        bsgenome <- .fixCyno5BSgenome(bsgenome)
    } else if (species=="cyno6"){
        bsgenome <- BSgenome.Mfascicularis.NCBI.6.0
    }
    return(bsgenome)
}



#' @importFrom GenomeInfoDb seqinfo seqinfo<- 
#' @importFrom GenomeInfoDb seqnames seqnames<-
.fixCyno5BSgenome <- function(x){
    seq <- seqinfo(x)
    wh <- which(grepl("MFA", seqnames(seq)))
    seqnames(seq)[wh] <- gsub("MFA","", seqnames(seq)[wh])
    seqinfo(x,
            new2old=seq_along(seqinfo(x))) <- seq
    return(x)
}





#' @title Get path to fasta file on Rosalind
#' 
#' @description Get path to fasta file on Rosalind
#' 
#' @param species String specifying which species.
#'     Must be either human (default), mouse, rat or fly.
#' @param allele String specifying which allele should be
#'     used for human DNA. Either "ref" (default),
#'     "major" or "minor".
#' 
#' @return String specifying path to a fasta file
#' 
#' @author Jean-Philippe Fortin
#' 
#' @export
getGenomeFasta <- function(species=c("human", "mouse"),
                           allele=c("ref", "maj", "min")
){
    species <- match.arg(species)
    allele  <- match.arg(allele)
    root <- file.path(.getCrisprIndicesPath(),
                      "genomes") 

    if (species!="human" & allele!="ref"){
        stop("Non-ref allele can only be used with human.")
    }

    
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
    } 
    
    out <- file.path(root, suffix) 
    out <- paste0(out, ".fa")
    return(out)
}



