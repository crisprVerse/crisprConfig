#' @title Get chromatin files for human on Rosalind
#' 
#' @description Get chromatin files for human on Rosalind
#' 
#' @param species String specifying which species.
#'     Only human can be provided at the moment. 
#' 
#' @return Named character vector of length 3.
#' 
#' @author Jean-Philippe Fortin
#' 
#' @export
getChromatinFiles <- function(species=c("human", "mouse")
){
    species <- match.arg(species)
    root <- file.path(.getCrisprIndicesPath(),
                      "chromatin") 

    if (species!="human"){
        stop("Only available for human at the moment.")
    }

    
    if (species=="human"){
        root <- file.path(root, "hg38")
        files <- c("crispria_dnase_human_K562_hg38.bigWig",
                   "crispria_faire_human_K562_hg38.bigWig",
                   "crispria_mnase_human_K562_hg38.bigWig")
    } 
    
    out <- file.path(root, files) 
    names(out) <- c("dnase", "faire", "mnase")
    return(out)
}





