% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_dice_similarity.R
\name{get_dice_similarity}
\alias{get_dice_similarity}
\title{Get Dice similarity coefficient scores}
\usage{
get_dice_similarity(graph, nodes = NULL, direction = "all")
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph}.}

\item{nodes}{an optional vector of node IDs to
consider for Dice similarity scores. If notsupplied,
then similarity scores will be provided for every
pair of nodes in the graph.}

\item{direction}{using \code{all} (the default), the
function will ignore edge direction when
determining scores for neighboring nodes. With
\code{out} and \code{in}, edge direction for
neighboring nodes will be considered.}
}
\value{
a data frame with Dice similiarity values
for each pair of nodes considered.
}
\description{
Get the Dice similiarity coefficient
scores for one or more nodes in a graph.
}
\examples{
library(magrittr)

# Create a random graph
graph <-
  create_random_graph(
    10, 22, set_seed = 1)

# Get the Dice similarity values for
# nodes `5`, `6`, and `7`
get_dice_similarity(graph, 5:7)
#>   node       n_5       n_6       n_7
#> 1    5 1.0000000 0.4444444 0.6666667
#> 2    6 0.4444444 1.0000000 0.4444444
#> 3    7 0.6666667 0.4444444 1.0000000
}

