#' @importFrom crisprBase spacerLength
#' @importFrom crisprBase getProtospacerRanges
#' @importFrom crisprBase getCutSiteFromPamSite
#' @export
tabify <- function(df,
                   outfile=NULL,
                   nuclease=c("SpCas9", "enAsCas12a"),
                   genome=c("GRCh38", "GRCm38"),
                   keep.extra.columns=FALSE

){  
    nuclease <- match.arg(nuclease)
    genome <- match.arg(genome)
    if (.whereAmI()=="rosalind"){
        htslib.bin <- "/pathToBin/htslib-1.9/"
    } else if (.whereAmI()=="myLaptop"){
        htslib.bin <- ""
    } 

    cols.core <- c("chr", "pam_site", "strand", "spacer","pam", "ID")
    if (!all(cols.core %in% colnames(df))){
        stop("The following columns must be provided: chr, ",
             "pam_site, strand, spacer, pam, and ID")
    }
    df$pam_site <- as.integer(df$pam_site)
    df <- df[!is.na(df$pam_site),]
    df$start <- df$pam_site
    df$end   <- df$pam_site
    cols.core <- c("chr", "start", "end", "pam_site",
                   "strand", "spacer","pam", "ID")

    # New columns
    cols.new <- c("nuclease", "genome", "cut_site")
    df$nuclease <- nuclease
    df$genome <- genome

    # Loading nucleases
    if (nuclease=="SpCas9"){
        data(SpCas9,
             package="crisprBase",
             envir=environment())
        nuclease <- SpCas9
    } else {
         data(enAsCas12a,
             package="crisprBase",
             envir=environment())
         nuclease <- enAsCas12a
    }

    # Transforming start and end:
    spacer_len <- crisprBase::spacerLength(nuclease)
    ranges <- crisprBase::getProtospacerRanges(pam_site=df$pam_site,
                                               strand=df$strand,
                                               nuclease=nuclease,,
                                               seqnames=df$chr)
    df$start <- as.integer(BiocGenerics::start(ranges))
    df$end   <- as.integer(BiocGenerics::end(ranges))


    # Adding cut site:
    df$cut_site <- crisprBase::getCutSiteFromPamSite(pam_site=df$pam_site,
                                                       strand=df$strand,
                                                       nuclease=nuclease)
    
    
    # Checking all columns
    cols.gene <- c("ensembl_id","tss_id", "gene_symbol")
    cols.gene <- intersect(cols.gene, colnames(df))
    cols <- c(cols.core, cols.new, cols.gene)
    if (keep.extra.columns){
        cols.more <- setdiff(colnames(df), cols)
        cols <- c(cols, cols.more)
    }


    df <- df[,cols,drop=FALSE]
    df <- df[order(df$chr, df$start),,drop=FALSE]


    write.table(df,
                file=outfile,
                sep="\t",
                row.names=FALSE,
                quote=FALSE) 
    system(paste0(htslib.bin,
                  "bgzip -f ",
                  outfile))
    gzFile <- paste0(outfile, ".gz")
    system(paste0(htslib.bin,
                  "tabix -s 1 -b 2 -e 3 -S 1 -f ",
                  gzFile))
}




