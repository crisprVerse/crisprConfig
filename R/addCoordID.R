#' @export
#' @importFrom GenomeInfoDb seqnames
#' @importFrom S4Vectors mcols mcols<-
#' @importFrom BiocGenerics strand
#' @importFrom methods is
addCoordID <- function(object,
                       species=c("human", "mouse"),
                       nuclease=c("SpCas9", "enAsCas12a")
){
    nuclease <- match.arg(nuclease)
    species <- match.arg(species)
    if (species=="human"){
        prefix <- "hg38"
    } else if (species=="mouse") {
        prefix <- "mm10"
    }
    nuclease <- tolower(nuclease)
    
    if (is(object, "GuideSet")){
        chr <- as.character(seqnames(object))
        pam_site <- mcols(object)$pam_site
        strand <- as.character(BiocGenerics::strand(object))
    } else {
        chr <- object$chr
        pam_site <- object$pam_site
        strand <- object$strand
    }
    coordID <- paste(prefix, nuclease,
                     chr, pam_site, strand, sep="_")
    if (is(object, "GuideSet")){
        mcols(object)$coordID <- coordID
    } else if (is(object, "DataFrame") | is(object, "data.frame")){
        object$coordID <- coordID
    }
    return(object)
}
