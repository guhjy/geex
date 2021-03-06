#------------------------------------------------------------------------------#
# grab_** description:
# Function that takes some object and "grabs" "what" "from" the object.
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
#' Grab something from an object
#'
#' @param from an object
#' @param what what to grab one of 'response', 'design_matrix', 'response_formula',
#' 'fixed_formula', 'eeFUN'
#' @param ... additional arguments passed to \code{grab_**} function
#' @seealso \code{\link{grab_response}}, \code{\link{grab_design_matrix}},
#' \code{\link{grab_response_formula}}, \code{\link{grab_fixed_formula}}
#' @export
#------------------------------------------------------------------------------#

grab <- function(from, what, ...){
  switch(what,
         "response"         = grab_response(data = from, ...),
         "design_matrix"    = grab_design_matrix(data = from, ...),
         "response_formula" = grab_response_formula(model = from),
         "fixed_formula"    = grab_fixed_formula(model = from),
         'psiFUN'           = grab_psiFUN(object = from, ...),
         stop("'what' you want to grab() is not defined"))
}

#------------------------------------------------------------------------------#
#' Grab the RHS formula from a model object
#'
#' @param model a model object such as \code{lm}, \code{glm}, \code{merMod}
#' @export
#' @examples
#' fit <- lm(Sepal.Width ~ Petal.Width, data = iris)
#' grab_fixed_formula(fit)
#------------------------------------------------------------------------------#
grab_fixed_formula <- function(model){
  stats::formula(model, fixed.only = TRUE)[-2]
}

#------------------------------------------------------------------------------#
#' Grab the LHS formula from a model object
#'
#' @param model a model object such as \code{lm}, \code{glm}, \code{merMod}
#' @export
#' @examples
#' fit <- lm(Sepal.Width ~ Petal.Width, data = iris)
#' grab_response_formula(fit)
#------------------------------------------------------------------------------#
grab_response_formula <- function(model){
  stats::formula(model)[-3]
}

#------------------------------------------------------------------------------#
#' Grab a matrix of fixed effects from a model object
#'
#' @param rhs_formula the right hand side of a model formula
#' @param data the data from which to extract the matrix
#' @export
#' @examples
#' # Create a "desigm" matrix for the first ten rows of iris data
#' fit <- lm(Sepal.Width ~ Petal.Width, data = iris)
#' grab_design_matrix(
#'   data = iris[1:10, ],
#'   grab_fixed_formula(fit))
#------------------------------------------------------------------------------#
grab_design_matrix <- function(data, rhs_formula){
  stats::model.matrix(object = rhs_formula, data = data)
}

#------------------------------------------------------------------------------#
#' Grab a vector of responses from a model object
#'
#' @param formula model formula
#' @param data data.frame from which to extract the vector of responses
#' @export
#' @examples
#' # Grab vector of responses for the first ten rows of iris data
#' fit <- lm(Sepal.Width ~ Petal.Width, data = iris)
#' grab_response(
#'   data = iris[1:10, ],
#'   formula(fit))
#------------------------------------------------------------------------------#

grab_response <- function(data, formula){
  stopifnot(class(formula) == 'formula')
  stats::model.response(stats::model.frame(formula = formula, data = data))
}
