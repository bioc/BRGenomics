% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_import.R
\name{import-functions}
\alias{import-functions}
\alias{import_bigWig}
\alias{import_bedGraph}
\title{Import basepair-resolution files}
\usage{
import_bigWig(
  plus_file = NULL,
  minus_file = NULL,
  genome = NULL,
  keep.X = TRUE,
  keep.Y = TRUE,
  keep.M = FALSE,
  keep.nonstandard = FALSE,
  makeBRG = TRUE,
  ncores = getOption("mc.cores", 2L)
)

import_bedGraph(
  plus_file = NULL,
  minus_file = NULL,
  genome = NULL,
  keep.X = TRUE,
  keep.Y = TRUE,
  keep.M = FALSE,
  keep.nonstandard = FALSE,
  ncores = getOption("mc.cores", 2L)
)
}
\arguments{
\item{plus_file, minus_file}{Paths for strand-specific input files, or a
vector of such paths. If vectors are given, the user should take care that
the orders match!}

\item{genome}{Optional string for UCSC reference genome, e.g. "hg38". If
given, non-standard chromosomes are trimmed, and options for sex and
mitochondrial chromosomes are applied.}

\item{keep.X, keep.Y, keep.M, keep.nonstandard}{Logicals indicating which
non-autosomes should be kept. By default, sex chromosomes are kept, but
mitochondrial and non-standard chromosomes are removed.}

\item{makeBRG}{If \code{TRUE} (the default), the output ranges are made
single-width using \code{\link[BRGenomics:makeGRangesBRG]{makeGRangesBRG}}}

\item{ncores}{Number of cores to use, if importing multiple objects
simultaneously.}
}
\value{
Imports a GRanges object containing base-pair resolution data, with
  the \code{score} metadata column indicating the number of reads represented
  by each range.
}
\description{
Import functions for plus/minus pairs of \code{bigWig} or \code{bedGraph}
files.
}
\details{
For \code{import_bigWig}, the output GRanges is formatted by
  \code{\link[BRGenomics:makeGRangesBRG]{makeGRangesBRG}}, such that all
  ranges are disjoint and have width = 1, and the \code{score} is single-base
  coverage, i.e. the number of reads for each position.

  \code{import_bedGraph} is useful for when both 5'- and 3'-end information
  is to be maintained for each sequenced molecule. For this purpose, one use
  bedGraphs to store entire reads, with the \code{score} representing the
  number of reads sharing identical 5' and 3' ends. However,
  \code{import_bedGraph} doesn't modify the information in the bedGraph
  files. If the bedGraph file represents basepair-resolution coverage data,
  then users can coerce it to a basepair-resolution GRanges object by using
  \code{\link[BRGenomics:getStrandedCoverage]{getStrandedCoverage}} followed
  by \code{\link[BRGenomics:makeGRangesBRG]{makeGRangesBRG}}.
}
\examples{
#--------------------------------------------------#
# Import PRO-seq bigWigs -> coverage of 3' bases
#--------------------------------------------------#

# get local address for included bigWig files
p.bw <- system.file("extdata", "PROseq_dm6_chr4_plus.bw",
                    package = "BRGenomics")
m.bw <- system.file("extdata", "PROseq_dm6_chr4_minus.bw",
                    package = "BRGenomics")

# import bigWigs (not supported on windows)
if (.Platform$OS.type == "unix") {
    PROseq <- import_bigWig(p.bw, m.bw, genome = "dm6")
    PROseq
}


#--------------------------------------------------#
# Import PRO-seq bedGraphs -> whole reads (matched 5' and 3' ends)
#--------------------------------------------------#

# get local address for included bedGraph files
p.bg <- system.file("extdata", "PROseq_dm6_chr4_plus.bedGraph",
                    package = "BRGenomics")
m.bg <- system.file("extdata", "PROseq_dm6_chr4_minus.bedGraph",
                    package = "BRGenomics")

# import bedGraphs
PROseq_paired <- import_bedGraph(p.bg, m.bg, genome = "dm6")
PROseq_paired
}
\seealso{
\code{\link[BRGenomics:tidyChromosomes]{tidyChromosomes}},
  \code{\link[rtracklayer:import.bw]{rtracklayer::import.bw}},
  \code{\link[rtracklayer:import.bedGraph]{rtracklayer::import.bedGraph}}
}
\author{
Mike DeBerardine
}
