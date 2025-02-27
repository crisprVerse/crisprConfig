#' @title Get paths of binaries for getCasRxRfScores on Rosalind
#' 
#' @description  Get paths of binaries for getCasRxRfScores on Rosalind
#' 
#' @return Named character vector of length 3.
#' 
#' @author Jean-Philippe Fortin
#' 
#' @export
getCasRxRfBinaries <- function(){
    out <- list()
    out$RNAfold <- system.file(package="crisprBinaries",
                               "binaries/RNAfold",
                               mustWork=TRUE)
    out$RNAplfold <- system.file(package="crisprBinaries",
                               "binaries/RNAplfold",
                               mustWork=TRUE)
    out$RNAhybrid <- system.file(package="crisprBinaries",
                               "binaries/RNAhybrid",
                               mustWork=TRUE)
    return(out)
}
