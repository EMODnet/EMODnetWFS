#' Get WFS available layer information
#'
#' @param wfs A `WFSClient` R6 object with methods for interfacing an OGC Web Feature Service.
#' @inheritParams emodnet_init_wfs_client
#' @importFrom rlang .data
#' @return a tibble containg metadata on each layer available from the service.
#' @export
#' @describeIn emodnet_get_wfs_info Get info on all layers from am EMODnet WFS service.
#' @examples
#' # Query the default service
#' emodnet_get_wfs_info()
#' # Query a service
#' emodnet_get_wfs_info(service = "bathymetry")
#' # Query a wfs object
#' wfs_cml <- emodnet_init_wfs_client("chemistry_marine_litter")
#' emodnet_get_wfs_info(wfs_cml)
#' # Get info for specific layers from wfs object
#' layers <- c("bl_fishing_monitoring",
#'            "bl_beacheslocations_monitoring")
#' emodnet_get_layer_info(wfs = wfs_cml, layers = layers)
emodnet_get_wfs_info <- function(wfs = NULL,
                                 service = "seabed_habitats_individual_habitat_map_and_model_datasets",
                                 service_version = "2.0.0") {
    if(is.null(wfs)){
        wfs <- emodnet_init_wfs_client(service, service_version)
    }else{check_wfs(wfs)}

    caps <- wfs$getCapabilities()

    tibble::tibble(
        data_source = "emodnet_wfs",
        service_name = service,
        service_url = get_service_url(service),
        layer_name = purrr::map_chr(caps$getFeatureTypes(), ~.x$getName()),
        title = purrr::map_chr(caps$getFeatureTypes(), ~.x$getTitle()),
        abstract = purrr::map_chr(caps$getFeatureTypes(), ~getAbstractNull(.x)),
        class = purrr::map_chr(caps$getFeatureTypes(), ~.x$getClassName()),
        format = "sf"
    ) %>%
        tidyr::separate(.data$layer_name, into = c("layer_namespace", "layer_name"),
                        sep = ":")

}

#' @describeIn emodnet_get_wfs_info Get metadata for specific layers. Requires a
#' `wfs` object as input.
#' @inheritParams emodnet_get_layers
#' @export
emodnet_get_layer_info <- function(wfs, layers) {
    check_wfs(wfs)
    layers  <- match.arg(layers, choices = emodnet_get_wfs_info(wfs)$layer_name,
                         several.ok = TRUE)

    caps <- wfs$getCapabilities()

    wfs_layers <- purrr::map(layers,
                             ~caps$findFeatureTypeByName(.x))

    tibble::tibble(
        data_source = "emodnet_wfs",
        service_name = wfs$getUrl(),
        service_url = get_service_name(wfs$getUrl()),
        layer_name = purrr::map_chr(wfs_layers, ~.x$getName()),
        title = purrr::map_chr(wfs_layers, ~.x$getTitle()),
        abstract = purrr::map_chr(wfs_layers, ~getAbstractNull(.x)),
        class = purrr::map_chr(wfs_layers, ~.x$getClassName()),
        format = "sf"
    ) %>%
        tidyr::separate(.data$layer_name,
                        into = c("layer_namespace", "layer_name"),
                        sep = ":")
}

#' @describeIn emodnet_get_wfs_info Get metadata on all layers and all available
#' services from server.
#' @export
emodnet_get_all_wfs_info <- function() {
    purrr::map_df(emodnet_wfs$service_name,
               ~suppressMessages(emodnet_get_wfs_info(service = .x)))
}


getAbstractNull <- function(x){
    abstract <- x$getAbstract()
    ifelse(is.null(abstract), "", abstract)
}
