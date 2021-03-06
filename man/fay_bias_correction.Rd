% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/correct_by_funs.R
\name{fay_bias_correction}
\alias{fay_bias_correction}
\title{Correct sandwich variance estimator byFay's bias correction}
\usage{
fay_bias_correction(components, b = 0.75)
}
\arguments{
\item{components}{an object of class \code{\linkS4class{sandwich_components}}}

\item{b}{a numeric value < 1. Defaults to 0.75 as in Fay.}
}
\value{
a corrected covariance matrix
}
\description{
Computes the bias corrected sandwich covariance matrix described in Fay and
Graubard (2001). See \code{vignette("05_finite_sample_corrections", package = "geex")}
for further information.
}
\examples{
# This example demonstrates usage of the corrections, not a meaningful application
myee <- function(data){
 function(theta){
   c(data$Y1 - theta[1],
   (data$Y1 - theta[1])^2 - theta[2])
  }
}

results <- m_estimate(
   estFUN = myee,
   data = geexex,
   root_control = setup_root_control(start = c(1,1)),
   corrections  = list(
     bias_correction_.1 = correction(fay_bias_correction, b = .1),
     bias_correction_.3 = correction(fay_bias_correction, b = .3))
   )

get_corrections(results)
}
\references{
Fay, M. P., & Graubard, B. I. (2001). Small-Sample adjustments for
Wald-type tests using sandwich estimators. Biometrics, 57(4), 1198-1206
}
