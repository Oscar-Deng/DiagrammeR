#' Cache edge attributes (based on a selection of
#' edges) in the graph
#' @description From a graph object of class
#' \code{dgr_graph}, get edge attribute properties for
#' edges available in a selection and cache those
#' values in the graph for later retrieval using
#' \code{get_cache}.
#' @param graph a graph object of class
#' \code{dgr_graph} that is created using
#' \code{create_graph}.
#' @param edge_attr the edge attribute from which to
#' obtain values.
#' @param mode a option to recast the returned vector
#' of edge attribute value as \code{numeric} or
#' \code{character}.
#' @return a graph object of class \code{dgr_graph}.
#' @examples
#' library(magrittr)
#'
#' # Set a seed
#' set.seed(25)
#'
#' # Create a graph with 10 nodes and 9 edges
#' graph <-
#'   create_graph() %>%
#'   add_n_nodes(10) %>%
#'   add_edges_w_string(
#'     "1->2 1->3 2->4 2->5 3->6 3->7 4->8 4->9 5->10") %>%
#'   set_edge_attrs(
#'     "value", rnorm(edge_count(.), 5, 2))
#'
#' # Select all edges where the edge attribute `value`
#' # is less than 5
#' graph <-
#'   graph %>%
#'   select_edges(
#'     edge_attr = "value",
#'     search = "<5.0")
#'
#' # Cache available values from the edge attribute
#' # `value` from the edges that are selected; ensure
#' # that the cached vector is numeric
#' graph <-
#'   graph %>%
#'   cache_edge_attrs_ws("value", "numeric")
#'
#' # Get the cached vector and get its
#' # difference from 5
#' graph %>% get_cache %>% {x <- .; 5 - x}
#' #> [1] 0.4236672 2.0831823 2.3066151
#' #> [4] 3.0002598 0.8910665
#' @export cache_edge_attrs_ws

cache_edge_attrs_ws <- function(graph,
                                edge_attr,
                                mode = NULL) {

  if (is.null(graph$selection$edges)) {
    stop("There is no selection of edges available.")
  }

  edges_df <-
    get_edge_df(graph)[which(get_edge_df(graph)[,1]
                             %in% graph$selection$edges$from &
                               get_edge_df(graph)[,2]
                             %in% graph$selection$edges$to),]

  if (!is.null(edge_attr)) {
    if (any(edge_attr %in%
            colnames(edges_df)[-c(1:2)])) {

      edges_attr_vector <-
        edges_df[,which(colnames(edges_df) %in%
                          edge_attr)]

      if (!is.null(mode)) {
        if (mode == "numeric") {
          edges_attr_vector <-
            as.numeric(edges_attr_vector)

          edges_attr_vector <-
            edges_attr_vector[which(!is.na(edges_attr_vector))]
        }

        if (mode == "character") {
          edges_attr_vector <-
            as.character(edges_attr_vector)
        }
      }
    }

    # Cache vector of edge attributes  in the graph
    graph$cache <- edges_attr_vector

    return(graph)
  }
}
