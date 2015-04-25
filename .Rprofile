##################################################
## R profile

if(interactive()){

    # Add support for Vim-R-plugin
    require(colorout)
    require(setwidth)
    require(vimcom)

    require(data.table)

    # Set options
    options(max.print = 60L,
            repos = c(CRAN="http://cran.cnr.Berkeley.edu/"),
            stringsAsFactors = FALSE,
            show.signif.stars = FALSE,
            scipen = 7,
            pdfviewer = "/usr/bin/zathura")

    utils::rc.settings(ipck = TRUE)

    # Personal functions
    source("/home/dave/Scripts/R/libraria.R")

    # Alias functions that are commonly used for variable names
    transpose <- t
    data. <- utils::data
    display.str <- utils::str

    # Quit without save prompt
    q <- function(save = "no", ...) quit(save = save, ...)
}

