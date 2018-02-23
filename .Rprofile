# R profile for interactive use.

if (interactive()) {

    .Rprofile <- new.env()
    .Rprofile$green <- "\u001b[32m"
    .Rprofile$reset <- "\u001b[0m"
    .Rprofile$lambda <- "\u03bb"
    .Rprofile$delta <- "\u03b4"
    .Rprofile$bayes <- "ℙ(θ|D)"
    .Rprofile$phi <- "\u03c6"

    .Rprofile$require_quiet <- function(pkg) {
        base::suppressPackageStartupMessages(
            base::require(pkg, character.only = TRUE)
        )
    }

    .Rprofile$require_quiet("colorout")

    # Update width when terminal resizes.
    # https://groups.google.com/forum/#!topic/vim-r-plugin/SeQCNWxEPwk
    set_width <- function(width = NULL) {
        if (is.null(width)) {
            width <- as.integer(Sys.getenv("COLUMNS"))
        }
        options(width=width)
    }
    makeActiveBinding("sw", set_width, baseenv())

    # Personal functions
    .Rprofile$require_quiet("rroba")

    # Set options
    options(max.print = 60,
            prompt = paste0(.Rprofile$green, "> ", .Rprofile$reset),
            continue = paste0(.Rprofile$green, "... ", .Rprofile$reset),
            repos = c(CRAN = "http://cran.cnr.Berkeley.edu/"),
            stringsAsFactors = FALSE,
            show.signif.stars = FALSE,
            digits = 7,
            scipen = 7,
            pdfviewer = "/usr/bin/zathura",
            menu.graphics = FALSE,
            editor = "vim",
            menu.graphics = FALSE)

    # Colorize in terminal
    colorout::setOutputColors(normal = 2,         # green
                              negnum = 1,         # red
                              zero = 3,           # bright red
                              error = c(0, 1),    # red fg
                              verbose = FALSE)


    # Autocomplete package names in require and library
    utils::rc.settings(ipck = TRUE)

    attach(.Rprofile)
}
