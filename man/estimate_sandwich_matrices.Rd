% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_funs.R
\name{estimate_sandwich_matrices}
\alias{estimate_sandwich_matrices}
\title{Estimate component matrices of the empirical sandwich covariance estimator}
\usage{
estimate_sandwich_matrices(.basis, .theta)
}
\arguments{
\item{.basis}{basis an object of class \code{\linkS4class{m_estimation_basis}}}

\item{.theta}{vector of parameter estimates (i.e. estimated roots)}
}
\value{
a \code{\linkS4class{sandwich_components}} object
}
\description{
For a given set of estimating equations computes the 'meat' (\eqn{B_m}{B_m}
in Stefanski and Boos notation) and 'bread' (\eqn{A_m}{A_m} in Stefanski and
 Boos notation) matrices necessary to compute the covariance matrix.
}
\details{
For a set of estimating equations (\eqn{\sum_i \psi(O_i, \theta) = 0}{sum_i \psi(O_i, \theta) = 0}),
this function computes:

\deqn{A_i =  \partial \psi(O_i, \theta)/\partial \theta}{A_i =  \partial \psi(O_i, \theta)/\partial \theta}

\deqn{A =  \sum_i A_i}{A =  \sum_i A_i}

\deqn{B_i =  \psi(O_i, \theta)\psi(O_i, \theta)^T}{B_i = outer(\psi(O_i, \theta), \psi(O_i, \theta))}

\deqn{B =  \sum_i B_i}{B =  \sum_i B_i}

where all of the above are evaluated at \eqn{\hat{\theta}}{hat(\theta)}. The partial derivatives in \eqn{A_i}{A_i}
numerically approximated by the function defined in \code{\linkS4class{deriv_control}}.

Note that \eqn{A =  \sum_i A_i}{A =  \sum_i A_i} and not \eqn{\sum_i A_i/m}{A =  \sum_i A_i/m}, and the same for \eqn{B}{B}.
}
\examples{

myee <- function(data){
  function(theta){
    c(data$Y1 - theta[1],
     (data$Y1 - theta[1])^2 - theta[2])
   }
 }

# Start with a basic basis
mybasis <- create_basis(
  estFUN = myee,
  data   = geexex)

# Now estimate sandwich matrices
estimate_sandwich_matrices(
 mybasis, c(mean(geexex$Y1), var(geexex$Y1)))
}
\references{
Stefanski, L. A., & Boos, D. D. (2002). The calculus of m-estimation. The American Statistician, 56(1), 29-38.
}
