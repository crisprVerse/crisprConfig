#' @title Get path to SNP VCF file
#' 
#' @description Get path to SNP VCF file
#' 
#' @return String specifying File Spath
#' 
#' @author Jean-Philippe Fortin
#' 
#' @export
getSNPFile <- function(){
    root <- file.path(.getCrisprIndicesPath(),
                      "snps/dbsnp151.grch38") 
    out <- file.path(root, "00-common_all.vcf.gz")
    return(out)
}
