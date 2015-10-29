## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~~~~~~~~~~~~~~~~~~~~ Interactive R profile ~~~~~~~~~~~~~~~~~~~~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

if (interactive()) {

    # Add support for Vim-R-plugin
    require(colorout)
    require(setwidth)
    require(vimcom)

    .Rprofile <- new.env()

    # Personal functions
    if (file.exists("~/bin/libraria.R")) {
        sys.source("~/bin/libraria.R", envir = .Rprofile)
        .Last <- function() {
            try({ savepkgs() }, silent = TRUE)
        }
    }

    .Rprofile$green <- "\u001b[32m"
    .Rprofile$reset <- "\u001b[0m"
    .Rprofile$lambda <- "\u03bb"
    .Rprofile$delta <- "\u03b4"
    .Rprofile$bayes <- "ℙ(θ|D)"
    .Rprofile$phi <- "\u03c6"

    # Set options
    options(max.print = 60L,
            prompt = paste0(.Rprofile$green, .Rprofile$phi, " > ", .Rprofile$reset),
            continue = paste0(.Rprofile$green, "... ", .Rprofile$reset),
            repos = c(CRAN = "http://cran.cnr.Berkeley.edu/"),
            stringsAsFactors = FALSE,
            show.signif.stars = FALSE,
            scipen = 7,
            pdfviewer = "/usr/bin/zathura",

            # Warn on partial matches
            warnPartialMatchAttr = TRUE,
            warnPartialMatchDollar = TRUE,
            warnPartialMatchArgs = TRUE)

    # Autocomplete package names in require and library
    utils::rc.settings(ipck = TRUE)

    # Alias functions that are commonly used for variable names
    transpose <- t
    data. <- utils::data
    display.str <- utils::str

    # Quit without save prompt
    .Rprofile$q <- function(save = "no", ...) quit(save = save, ...)

    attach(.Rprofile)
}

