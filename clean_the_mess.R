x <- list.files(pattern = "tar.gz", full.names = TRUE)
lapply(x, unlink)
