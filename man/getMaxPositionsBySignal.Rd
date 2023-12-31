% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/roi_functions.R
\name{getMaxPositionsBySignal}
\alias{getMaxPositionsBySignal}
\title{Find sites with max signal in regions of interest}
\usage{
getMaxPositionsBySignal(
  dataset.gr,
  regions.gr,
  binsize = 1L,
  bin.centers = FALSE,
  field = "score",
  keep.signal = FALSE,
  expand_ranges = FALSE
)
}
\arguments{
\item{dataset.gr}{A GRanges object in which signal is contained in metadata
(typically in the "score" field).}

\item{regions.gr}{A GRanges object containing regions of interest.}

\item{binsize}{The size of bin in which to calculate signal scores.}

\item{bin.centers}{Logical indicating if the centers of bins are returned, as
opposed to the entire bin. By default, entire bins are returned.}

\item{field}{The metadata field of \code{dataset.gr} to be counted.}

\item{keep.signal}{Logical indicating if the signal value at the max site
should be reported. If set to \code{TRUE}, the values are kept as a new
\code{MaxSiteSignal} metadata column in the output GRanges.}

\item{expand_ranges}{Logical indicating if ranges in \code{dataset.gr} should
be treated as descriptions of single molecules (\code{FALSE}), or if ranges
should be treated as representing multiple adjacent positions with the same
signal (\code{TRUE}). See \code{\link[BRGenomics:getCountsByRegions]{
getCountsByRegions}}.}
}
\value{
Output is a GRanges object with regions.gr metadata, but each range
  only contains the site within each \code{regions.gr} range that had the
  most signal. If \code{binsize > 1}, the entire bin is returned, unless
  \code{bin.centers = TRUE}, in which case a single-base site is returned.
  The site is set to the center of the bin, and if the binsize is even, the
  site is rounded to be closer to the beginning of the range.

  The output may not be the same length as \code{regions.gr}, as regions
  without signal are not returned. If no regions have signal (e.g. as could
  happen if running this function on single regions), the function will
  return an empty GRanges object with intact metadata columns.

  If \code{keep.signal = TRUE}, the output will also contain metadata for the
  signal at the max site, named \code{MaxSiteSignal}.
}
\description{
For each signal-containing region of interest, find the single site with the
most signal. Sites can be found at base-pair resolution, or defined for
larger bins.
}
\examples{
data("PROseq") # load included PROseq data
data("txs_dm6_chr4") # load included transcripts

#--------------------------------------------------#
# first 50 bases of transcripts
#--------------------------------------------------#

pr <- promoters(txs_dm6_chr4, 0, 50)
pr[1:3]

#--------------------------------------------------#
# max sites
#--------------------------------------------------#

getMaxPositionsBySignal(PROseq, pr[1:3], keep.signal = TRUE)

#--------------------------------------------------#
# max sites in 5 bp bins
#--------------------------------------------------#

getMaxPositionsBySignal(PROseq, pr[1:3], binsize = 5, keep.signal = TRUE)
}
\seealso{
\code{\link[BRGenomics:getCountsByPositions]{getCountsByPositions}}
}
\author{
Mike DeBerardine
}
