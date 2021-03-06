% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_edge_attrs.R
\name{get_edge_attrs}
\alias{get_edge_attrs}
\title{Get edge attribute values}
\usage{
get_edge_attrs(x, edge_attr, from = NULL, to = NULL)
}
\arguments{
\item{x}{either a graph object of class
\code{dgr_graph} that is created using
\code{create_graph}, or an edge data frame.}

\item{edge_attr}{the name of the attribute for which
to get values.}

\item{from}{an optional vector of node IDs from
which the edge is outgoing for filtering the list
of edges.}

\item{to}{an optional vector of node IDs from which
the edge is incoming for filtering the list of
edges.}
}
\value{
a named vector of edge attribute values for
the attribute given by \code{edge_attr} by edge.
}
\description{
From a graph object of class
\code{dgr_graph} or an edge data frame, get edge
attribute values for one or more edges.
}
\examples{
library(magrittr)

# Create a simple graph where edges have an edge
# attribute named `value`
graph <-
  create_graph() \%>\%
  add_n_nodes(4) \%>\%
  {
    edges <-
      create_edges(
        from = c(1, 2, 1, 4),
        to = c(2, 3, 4, 3),
        rel = "rel")
    add_edge_df(., edges)
  } \%>\%
  set_edge_attrs(
    "value", 1.6, 1, 2) \%>\%
  set_edge_attrs(
    "value", 4.3, 1, 4) \%>\%
  set_edge_attrs(
    "value", 2.9, 2, 3) \%>\%
  set_edge_attrs(
    "value", 8.4, 4, 3)

# Get the values for the `value` edge attribute
graph \%>\% get_edge_attrs(edge_attr = "value")
#> 1 -> 2 2 -> 3 1 -> 4 4 -> 3
#> 1.6    2.9    4.3    8.4

# To only return edge attribute values for specified
# edges, use the `from` and `to` arguments
graph \%>\% get_edge_attrs("value", c(1, 2), c(2, 3))
#> 1 -> 2 2 -> 3
#> 1.6    2.9
}

