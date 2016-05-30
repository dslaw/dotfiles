# R profile for interactive use ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if (interactive()) {

    .Rprofile <- new.env()
    .Rprofile$green <- "\u001b[32m"
    .Rprofile$reset <- "\u001b[0m"
    .Rprofile$lambda <- "\u03bb"
    .Rprofile$delta <- "\u03b4"
    .Rprofile$bayes <- "ℙ(θ|D)"
    .Rprofile$phi <- "\u03c6"

    .Rprofile$stazitta <- function(pkg) {
        base::suppressPackageStartupMessages(
            base::require(pkg, character.only = TRUE)
        )
    }

    .Rprofile$stazitta("colorout")
    .Rprofile$stazitta("setwidth")

    # Personal functions
    .Rprofile$stazitta("rroba")

    # Set options
    options(max.print = 60L,
            prompt = paste0(.Rprofile$green, .Rprofile$phi, " > ", .Rprofile$reset),
            continue = paste0(.Rprofile$green, "... ", .Rprofile$reset),
            repos = c(CRAN = "http://cran.cnr.Berkeley.edu/"),
            stringsAsFactors = FALSE,
            show.signif.stars = FALSE,
            digits = 7,
            scipen = 7,
            pdfviewer = "/usr/bin/zathura",
            menu.graphics = FALSE,
            editor = "vim",
            menu.graphics = FALSE,

            # Warn on partial matches
            warnPartialMatchAttr = TRUE,
            warnPartialMatchDollar = TRUE,
            warnPartialMatchArgs = TRUE)

    # Colorout
    # Use terminal colors instead of 256
    setOutputColors(normal = 2, # green
                    negnum = 1, # red
                    zero = 3, # bright red
                    error = c(0, 1), # red fg
                    verbose = FALSE)


    # Autocomplete package names in require and library
    utils::rc.settings(ipck = TRUE)

    # Alias functions that are commonly used for variable names
    .Rprofile$transpose <- base::t
    .Rprofile$data. <- utils::data
    .Rprofile$display.str <- utils::str

    attach(.Rprofile)
}

