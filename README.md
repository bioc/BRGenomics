
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BRGenomics

<!-- badges: start -->

<!-- badges: end -->

Efficient tools for the analysis of high-resolution genomics data in R.

Explore the documentation: <https://mdeber.github.io/>

## Installation

Install development version from
[GitHub](https://github.com/mdeber/BRGenomics):

``` r
# install.packages("devtools")
devtools::install_github("mdeber/BRGenomics")
```

If you’re using Windows, [Rtools for
Windows](https://cran.rstudio.com/bin/windows/Rtools/) is required.

## Features

See the [documentation website](https://mdeber.github.io/), which
includes a draft version of the introductory vignette, as well as the
documentation for currently implemented functions, complete with
demonstrative example code. The package currently includes example
PRO-seq data<sup>\[1\]</sup>.

## Known issues and limitations

  - `import_bam` can sometimes return an error when `paired_end = NULL`.
    If this occurs, make `paired_end` argument explicit by setting to
    `TRUE` or `FALSE`
  - Currently no support for multicore processing on Windows
  - No support for importing bigWig files on Windows
  - Certain gene names can cause `getDESeqDataSet` to return an error
      - Systematic naming schemes work (e.g. ensembl IDs) while some
        lists of conventional gene names, i.e. “symbols”, will cause
        failure
  - Most multicore support is robust to the use of alternative BLAS
    libraries, with the exception of `getDESeqResults`. Users opting to
    use alternative, concurrent BLAS libraries may have to set `ncores
    = 1`.

-----

1.  Hojoong Kwak, Nicholas J. Fuda, Leighton J. Core, John T. Lis
    (2013). Precise Maps of RNA Polymerase Reveal How Promoters Direct
    Initiation and Pausing. *Science* **339**(6122): 950–953.
    <https://doi.org/10.1126/science.1229386>
