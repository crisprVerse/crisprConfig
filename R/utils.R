#' @import crisprBinaries
NULL

compact <- function(l){
    Filter(Negate(is.null), l)
}

.whereAmI <- function(){
    info <- Sys.info()
    os   <- info[["sysname"]]
    node <- info[["nodename"]]
    user <- info[["user"]]
    if (os=="Darwin" & user=="fortinj2"){
        where <- "myLaptop"
    } 
    return(where)
}


.getCrisprIndicesPath <- function(){
    where <- .whereAmI()
    if (where=="myLaptop"){
        root <- "/Users/fortin946/crisprIndices"
    }
    return(root)
}
