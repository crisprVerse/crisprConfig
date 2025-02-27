#' @title Get conservation files for human on Rosalind
#' 
#' @description Get conservation files for human on Rosalind
#' 
#' @param species String specifying which species.
#' 
#' @return String specifying path of the BigWig file.
#' 
#' @author Jean-Philippe Fortin
#' 
#' @export
getConservationFiles <- function(species=c("human", "mouse")
){
    species <- match.arg(species)
    root <- file.path(.getCrisprIndicesPath(),
                      "conservation") 

    if (species=="human"){
        root <- file.path(root, "hg38")
        files <- c("hg38.phyloP30way.bw")
    } else {
        root <- file.path(root, "mm10")
        files <- c("mm10.60way.phyloP60way.bw")
    }
    
    out <- file.path(root, files) 
    return(out)
}





