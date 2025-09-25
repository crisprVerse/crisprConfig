if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "devel")

# Core crisprVerse packages:
BiocManager::install("crisprVerse") # This will install core packages
BiocManager::install("crisprShiny")
BiocManager::install("crisprRbwa")
BiocManager::install("crisprBwa")


# Genome packages:
BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")
BiocManager::install("BSgenome.Mmusculus.UCSC.mm10")
BiocManager::install("BSgenome.Mfascicularis.NCBI.5.0")
BiocManager::install("BSgenome.Mfascicularis.NCBI.6.0")
BiocManager::install("BSgenome.Dmelanogaster.UCSC.dm6")
BiocManager::install("BSgenome.Rnorvegicus.UCSC.rn6")


# Github packages:
install.packages("devtools")
devtools::install_github("crisprVerse/crisprDesignData")
devtools::install_github("crisprVerse/crisprDesignAux")
devtools::install_github("crisprVerse/crisprBinaries")
devtools::install_github("crisprVerse/crisprConfig")

# Notes:
# crisprConfig needs to be set up locally
# Then, next step is to setup the crisprIndices repo
