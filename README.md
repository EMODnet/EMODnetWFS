
<!-- README.md is generated from README.Rmd. Please edit that file -->

# EMODnetWFS: Access EMODnet Web Feature Service data through R

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![R build
status](https://github.com/EMODnet/EMODnetWFS/workflows/R-CMD-check/badge.svg)](https://github.com/EMODnet/EMODnetWFS/actions)
[![Codecov test
coverage](https://codecov.io/gh/EMODnet/EMODnetWFS/branch/main/graph/badge.svg)](https://app.codecov.io/gh/EMODnet/EMODnetWFS/tree/main)
<!-- badges: end -->

The goal of EMODnetWFS is to allow interrogation of and access to
[EMODnet geographic vector
data](https://emodnet.ec.europa.eu/en/emodnet-web-service-documentation#inline-nav-3)
in R though the [EMODnet Web Feature
Services](https://emodnet.ec.europa.eu/en/data). [Web Feature services
(WFS)](https://www.ogc.org/standard/wfs/) represent a change in the way
geographic information is created, modified and exchanged on the
Internet and offer direct fine-grained access to geographic information
at the feature and feature property level. EMODnetWFS aims at offering
an user-friendly interface to this rich data.

## Installation

You can install the development version of EMODnetWFS from GitHub with:

``` r
# install.packages("pak")
pak::pak("EMODnet/EMODnetWFS")
```

## Available services

All available services are contained in the tibble returned by
`emodnet_wfs()`.

| service_name                                                    | service_url                                                                   |
|:----------------------------------------------------------------|:------------------------------------------------------------------------------|
| bathymetry                                                      | <https://ows.emodnet-bathymetry.eu/wfs>                                       |
| biology                                                         | <https://geo.vliz.be/geoserver/Emodnetbio/wfs>                                |
| biology_occurrence_data                                         | <https://geo.vliz.be/geoserver/Dataportal/wfs>                                |
| chemistry_cdi_data_discovery_and_access_service                 | <https://geo-service.maris.nl/emodnet_chemistry/wfs>                          |
| chemistry_cdi_distribution_observations_per_category_and_region | <https://geo-service.maris.nl/emodnet_chemistry_p36/wfs>                      |
| chemistry_contaminants                                          | <https://nodc.ogs.trieste.it/geoserver/Contaminants/wfs>                      |
| chemistry_marine_litter                                         | <https://www.ifremer.fr/services/wfs/emodnet_chemistry2>                      |
| geology_coastal_behavior                                        | <https://drive.emodnet-geology.eu/geoserver/tno/wfs>                          |
| geology_events_and_probabilities                                | <https://drive.emodnet-geology.eu/geoserver/ispra/wfs>                        |
| geology_marine_minerals                                         | <https://drive.emodnet-geology.eu/geoserver/gsi/wfs>                          |
| geology_sea_floor_bedrock                                       | <https://drive.emodnet-geology.eu/geoserver/bgr/wfs>                          |
| geology_seabed_substrate_maps                                   | <https://drive.emodnet-geology.eu/geoserver/gtk/wfs>                          |
| geology_submerged_landscapes                                    | <https://drive.emodnet-geology.eu/geoserver/bgs/wfs>                          |
| human_activities                                                | <https://ows.emodnet-humanactivities.eu/wfs>                                  |
| physics                                                         | <https://prod-geoserver.emodnet-physics.eu/geoserver/ows>                     |
| seabed_habitats_general_datasets_and_products                   | <https://ows.emodnet-seabedhabitats.eu/geoserver/emodnet_open/wfs>            |
| seabed_habitats_individual_habitat_map_and_model_datasets       | <https://ows.emodnet-seabedhabitats.eu/geoserver/emodnet_open_maplibrary/wfs> |

To explore available services you can use:

``` r
View(emodnet_wfs())
```

## Create Service Client

Specify the service using the `service` argument.

``` r
wfs_bio <- emodnet_init_wfs_client(service = "biology")
#> Loading ISO 19139 XML schemas...
#> Loading ISO 19115 codelists...
#> ✔ WFS client created successfully
#> ℹ Service: "https://geo.vliz.be/geoserver/Emodnetbio/wfs"
#> ℹ Version: "2.0.0"

wfs_bio
#> <WFSClient>
#> ....|-- url: https://geo.vliz.be/geoserver/Emodnetbio/wfs
#> ....|-- version: 2.0.0
#> ....|-- capabilities <WFSCapabilities>
```

## Get WFS Layer info

You can get metadata about the layers available from a service.

``` r
emodnet_get_wfs_info(service = "biology")
#> ✔ WFS client created successfully
#> ℹ Service: "https://geo.vliz.be/geoserver/Emodnetbio/wfs"
#> ℹ Version: "2.0.0"
#> # A tibble: 38 × 9
#> # Rowwise: 
#>    data_source service_name service_url   layer_name title abstract class format
#>    <chr>       <chr>        <chr>         <chr>      <chr> <chr>    <chr> <chr> 
#>  1 emodnet_wfs biology      https://geo.… mediseh_c… EMOD… "Coral … WFSF… sf    
#>  2 emodnet_wfs biology      https://geo.… mediseh_c… EMOD… "Coral … WFSF… sf    
#>  3 emodnet_wfs biology      https://geo.… mediseh_c… EMOD… "Cymodo… WFSF… sf    
#>  4 emodnet_wfs biology      https://geo.… Species_g… EMOD… "This d… WFSF… sf    
#>  5 emodnet_wfs biology      https://geo.… Species_g… EMOD… "This d… WFSF… sf    
#>  6 emodnet_wfs biology      https://geo.… Species_g… EMOD… "This d… WFSF… sf    
#>  7 emodnet_wfs biology      https://geo.… Species_g… EMOD… "This d… WFSF… sf    
#>  8 emodnet_wfs biology      https://geo.… mediseh_h… EMOD… "Haloph… WFSF… sf    
#>  9 emodnet_wfs biology      https://geo.… mediseh_m… EMOD… "Maërl … WFSF… sf    
#> 10 emodnet_wfs biology      https://geo.… mediseh_m… EMOD… "Maërl … WFSF… sf    
#> # ℹ 28 more rows
#> # ℹ 1 more variable: layer_namespace <chr>
```

or you can pass a wfs client object.

``` r
emodnet_get_wfs_info(wfs_bio)
#> # A tibble: 38 × 9
#> # Rowwise: 
#>    data_source service_name service_url   layer_name title abstract class format
#>    <chr>       <chr>        <chr>         <chr>      <chr> <chr>    <chr> <chr> 
#>  1 emodnet_wfs biology      https://geo.… mediseh_c… EMOD… "Coral … WFSF… sf    
#>  2 emodnet_wfs biology      https://geo.… mediseh_c… EMOD… "Coral … WFSF… sf    
#>  3 emodnet_wfs biology      https://geo.… mediseh_c… EMOD… "Cymodo… WFSF… sf    
#>  4 emodnet_wfs biology      https://geo.… Species_g… EMOD… "This d… WFSF… sf    
#>  5 emodnet_wfs biology      https://geo.… Species_g… EMOD… "This d… WFSF… sf    
#>  6 emodnet_wfs biology      https://geo.… Species_g… EMOD… "This d… WFSF… sf    
#>  7 emodnet_wfs biology      https://geo.… Species_g… EMOD… "This d… WFSF… sf    
#>  8 emodnet_wfs biology      https://geo.… mediseh_h… EMOD… "Haloph… WFSF… sf    
#>  9 emodnet_wfs biology      https://geo.… mediseh_m… EMOD… "Maërl … WFSF… sf    
#> 10 emodnet_wfs biology      https://geo.… mediseh_m… EMOD… "Maërl … WFSF… sf    
#> # ℹ 28 more rows
#> # ℹ 1 more variable: layer_namespace <chr>
```

You can also get info for specific layers from wfs object:

``` r
layers <- c("mediseh_zostera_m_pnt", "mediseh_posidonia_nodata")

emodnet_get_layer_info(wfs = wfs_bio, layers = layers)
#> # A tibble: 2 × 9
#> # Rowwise: 
#>   data_source service_name    service_url layer_name title abstract class format
#>   <chr>       <chr>           <chr>       <chr>      <chr> <chr>    <chr> <chr> 
#> 1 emodnet_wfs https://geo.vl… biology     mediseh_p… EMOD… "Coastl… WFSF… sf    
#> 2 emodnet_wfs https://geo.vl… biology     mediseh_z… EMOD… "Zoster… WFSF… sf    
#> # ℹ 1 more variable: layer_namespace <chr>
```

Finally, you can get details on all available services and layers from
the server

``` r
emodnet_get_all_wfs_info()
```

## Get WFS layers

You can extract layers directly from a `wfs` object using layer names.
All layers are downloaded as `sf` objects and output as a list with a
named element for each layer requested.

``` r
emodnet_get_layers(wfs = wfs_bio, layers = layers)
#> $mediseh_zostera_m_pnt
#> Simple feature collection with 54 features and 3 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -4.167154 ymin: 33.07783 xmax: 15.35766 ymax: 45.72451
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>                      gml_id id country                   the_geom
#> 1   mediseh_zostera_m_pnt.1  0  Spagna  POINT (-2.61314 36.71681)
#> 2   mediseh_zostera_m_pnt.2  0  Spagna POINT (-3.846598 36.75127)
#> 3   mediseh_zostera_m_pnt.3  0  Spagna POINT (-3.957785 36.72266)
#> 4   mediseh_zostera_m_pnt.4  0  Spagna POINT (-4.039712 36.74217)
#> 5   mediseh_zostera_m_pnt.5  0  Spagna POINT (-4.100182 36.72331)
#> 6   mediseh_zostera_m_pnt.6  0  Spagna POINT (-4.167154 36.71226)
#> 7   mediseh_zostera_m_pnt.7  0  Spagna POINT (-1.268366 37.55796)
#> 8   mediseh_zostera_m_pnt.8  0 Francia   POINT (4.84864 43.37637)
#> 9   mediseh_zostera_m_pnt.9  0  Italia  POINT (13.71831 45.70017)
#> 10 mediseh_zostera_m_pnt.10  0  Italia  POINT (13.16378 45.72451)
#> 
#> $mediseh_posidonia_nodata
#> Simple feature collection with 465 features and 3 fields
#> Geometry type: MULTICURVE
#> Dimension:     XY
#> Bounding box:  xmin: -2.1798 ymin: 30.26623 xmax: 34.60767 ymax: 45.47668
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>                         gml_id id         km                       the_geom
#> 1   mediseh_posidonia_nodata.1  0 291.503233 MULTICURVE (LINESTRING (27....
#> 2   mediseh_posidonia_nodata.2  0  75.379502 MULTICURVE (LINESTRING (23....
#> 3   mediseh_posidonia_nodata.3  0  38.627764 MULTICURVE (LINESTRING (22....
#> 4   mediseh_posidonia_nodata.4  0 110.344802 MULTICURVE (LINESTRING (19....
#> 5  mediseh_posidonia_nodata.13  0  66.997461 MULTICURVE (LINESTRING (9.1...
#> 6  mediseh_posidonia_nodata.14  0  18.090640 MULTICURVE (LINESTRING (9.7...
#> 7  mediseh_posidonia_nodata.15  0  16.618978 MULTICURVE (LINESTRING (9.8...
#> 8  mediseh_posidonia_nodata.16  0   1.913773 MULTICURVE (LINESTRING (10....
#> 9  mediseh_posidonia_nodata.83  0   2.173447 MULTICURVE (LINESTRING (15....
#> 10 mediseh_posidonia_nodata.84  0   2.817453 MULTICURVE (LINESTRING (15....
```

You can change the output `crs` through the argument `crs`.

``` r
emodnet_get_layers(wfs = wfs_bio, layers = layers, crs = 3857)
#> ℹ crs transformed to 3857.
#> ℹ crs transformed to 3857.
#> $mediseh_zostera_m_pnt
#> Simple feature collection with 54 features and 3 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -463885.4 ymin: 3905639 xmax: 1709607 ymax: 5736311
#> Projected CRS: WGS 84 / Pseudo-Mercator
#> First 10 features:
#>                      gml_id id country                  the_geom
#> 1   mediseh_zostera_m_pnt.1  0  Spagna POINT (-290893.4 4399707)
#> 2   mediseh_zostera_m_pnt.2  0  Spagna POINT (-428201.3 4404494)
#> 3   mediseh_zostera_m_pnt.3  0  Spagna POINT (-440578.6 4400520)
#> 4   mediseh_zostera_m_pnt.4  0  Spagna POINT (-449698.6 4403229)
#> 5   mediseh_zostera_m_pnt.5  0  Spagna POINT (-456430.1 4400610)
#> 6   mediseh_zostera_m_pnt.6  0  Spagna POINT (-463885.4 4399075)
#> 7   mediseh_zostera_m_pnt.7  0  Spagna POINT (-141193.9 4517168)
#> 8   mediseh_zostera_m_pnt.8  0 Francia  POINT (539748.1 5369436)
#> 9   mediseh_zostera_m_pnt.9  0  Italia   POINT (1527115 5732431)
#> 10 mediseh_zostera_m_pnt.10  0  Italia   POINT (1465385 5736311)
#> 
#> $mediseh_posidonia_nodata
#> Simple feature collection with 465 features and 3 fields
#> Geometry type: MULTICURVE
#> Dimension:     XY
#> Bounding box:  xmin: -242654.3 ymin: 3537818 xmax: 3852508 ymax: 5696879
#> Projected CRS: WGS 84 / Pseudo-Mercator
#> First 10 features:
#>                         gml_id id         km                       the_geom
#> 1   mediseh_posidonia_nodata.1  0 291.503233 MULTICURVE (LINESTRING (302...
#> 2   mediseh_posidonia_nodata.2  0  75.379502 MULTICURVE (LINESTRING (257...
#> 3   mediseh_posidonia_nodata.3  0  38.627764 MULTICURVE (LINESTRING (246...
#> 4   mediseh_posidonia_nodata.4  0 110.344802 MULTICURVE (LINESTRING (221...
#> 5  mediseh_posidonia_nodata.13  0  66.997461 MULTICURVE (LINESTRING (101...
#> 6  mediseh_posidonia_nodata.14  0  18.090640 MULTICURVE (LINESTRING (108...
#> 7  mediseh_posidonia_nodata.15  0  16.618978 MULTICURVE (LINESTRING (110...
#> 8  mediseh_posidonia_nodata.16  0   1.913773 MULTICURVE (LINESTRING (121...
#> 9  mediseh_posidonia_nodata.83  0   2.173447 MULTICURVE (LINESTRING (169...
#> 10 mediseh_posidonia_nodata.84  0   2.817453 MULTICURVE (LINESTRING (169...
```

You can also extract layers using a WFS service name.

``` r
emodnet_get_layers(
  service = "biology",
  layers = c("mediseh_zostera_m_pnt", "mediseh_posidonia_nodata")
)
#> ✔ WFS client created successfully
#> ℹ Service: "https://geo.vliz.be/geoserver/Emodnetbio/wfs"
#> ℹ Version: "2.0.0"
#> $mediseh_zostera_m_pnt
#> Simple feature collection with 54 features and 3 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -4.167154 ymin: 33.07783 xmax: 15.35766 ymax: 45.72451
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>                      gml_id id country                   the_geom
#> 1   mediseh_zostera_m_pnt.1  0  Spagna  POINT (-2.61314 36.71681)
#> 2   mediseh_zostera_m_pnt.2  0  Spagna POINT (-3.846598 36.75127)
#> 3   mediseh_zostera_m_pnt.3  0  Spagna POINT (-3.957785 36.72266)
#> 4   mediseh_zostera_m_pnt.4  0  Spagna POINT (-4.039712 36.74217)
#> 5   mediseh_zostera_m_pnt.5  0  Spagna POINT (-4.100182 36.72331)
#> 6   mediseh_zostera_m_pnt.6  0  Spagna POINT (-4.167154 36.71226)
#> 7   mediseh_zostera_m_pnt.7  0  Spagna POINT (-1.268366 37.55796)
#> 8   mediseh_zostera_m_pnt.8  0 Francia   POINT (4.84864 43.37637)
#> 9   mediseh_zostera_m_pnt.9  0  Italia  POINT (13.71831 45.70017)
#> 10 mediseh_zostera_m_pnt.10  0  Italia  POINT (13.16378 45.72451)
#> 
#> $mediseh_posidonia_nodata
#> Simple feature collection with 465 features and 3 fields
#> Geometry type: MULTICURVE
#> Dimension:     XY
#> Bounding box:  xmin: -2.1798 ymin: 30.26623 xmax: 34.60767 ymax: 45.47668
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>                         gml_id id         km                       the_geom
#> 1   mediseh_posidonia_nodata.1  0 291.503233 MULTICURVE (LINESTRING (27....
#> 2   mediseh_posidonia_nodata.2  0  75.379502 MULTICURVE (LINESTRING (23....
#> 3   mediseh_posidonia_nodata.3  0  38.627764 MULTICURVE (LINESTRING (22....
#> 4   mediseh_posidonia_nodata.4  0 110.344802 MULTICURVE (LINESTRING (19....
#> 5  mediseh_posidonia_nodata.13  0  66.997461 MULTICURVE (LINESTRING (9.1...
#> 6  mediseh_posidonia_nodata.14  0  18.090640 MULTICURVE (LINESTRING (9.7...
#> 7  mediseh_posidonia_nodata.15  0  16.618978 MULTICURVE (LINESTRING (9.8...
#> 8  mediseh_posidonia_nodata.16  0   1.913773 MULTICURVE (LINESTRING (10....
#> 9  mediseh_posidonia_nodata.83  0   2.173447 MULTICURVE (LINESTRING (15....
#> 10 mediseh_posidonia_nodata.84  0   2.817453 MULTICURVE (LINESTRING (15....
```

Layers can also be returned to a single `sf` object through argument
`reduce_layers`.  
If `TRUE` the function will try to reduce all layers into a single `sf`.

If attempting to reduce fails, it will error:

``` r
emodnet_get_layers(
  wfs = wfs_bio,
  layers = layers,
  reduce_layers = TRUE
)
#> Error in `value[[3L]]()`:
#> ! Cannot reduce layers.
#> ℹ Try again with `reduce_layers = FALSE`
```

Using `reduce_layers = TRUE` is also useful for returning an `sf` object
rather than a list in single layer request.

``` r
emodnet_get_layers(
  service = "biology",
  layers = c("mediseh_posidonia_nodata"),
  reduce_layers = TRUE
)
#> ✔ WFS client created successfully
#> ℹ Service: "https://geo.vliz.be/geoserver/Emodnetbio/wfs"
#> ℹ Version: "2.0.0"
#> Simple feature collection with 465 features and 3 fields
#> Geometry type: MULTICURVE
#> Dimension:     XY
#> Bounding box:  xmin: -2.1798 ymin: 30.26623 xmax: 34.60767 ymax: 45.47668
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>                         gml_id id         km                       the_geom
#> 1   mediseh_posidonia_nodata.1  0 291.503233 MULTICURVE (LINESTRING (27....
#> 2   mediseh_posidonia_nodata.2  0  75.379502 MULTICURVE (LINESTRING (23....
#> 3   mediseh_posidonia_nodata.3  0  38.627764 MULTICURVE (LINESTRING (22....
#> 4   mediseh_posidonia_nodata.4  0 110.344802 MULTICURVE (LINESTRING (19....
#> 5  mediseh_posidonia_nodata.13  0  66.997461 MULTICURVE (LINESTRING (9.1...
#> 6  mediseh_posidonia_nodata.14  0  18.090640 MULTICURVE (LINESTRING (9.7...
#> 7  mediseh_posidonia_nodata.15  0  16.618978 MULTICURVE (LINESTRING (9.8...
#> 8  mediseh_posidonia_nodata.16  0   1.913773 MULTICURVE (LINESTRING (10....
#> 9  mediseh_posidonia_nodata.83  0   2.173447 MULTICURVE (LINESTRING (15....
#> 10 mediseh_posidonia_nodata.84  0   2.817453 MULTICURVE (LINESTRING (15....
```

## Citation

To cite EMODnetWFS, please use the output from
`citation(package = "EMODnetWFS")`.

``` r
citation(package = "EMODnetWFS")
#> 
#> To cite package 'EMODnetWFS' in publications use:
#> 
#>   Krystalli A, Fernández-Bejarano S, Salmon M (????). _EMODnetWFS:
#>   Access EMODnet Web Feature Service data through R_. R package version
#>   2.0.1.9001. Integrated data products created under the European
#>   Marine Observation Data Network (EMODnet) Biology project
#>   (EASME/EMFF/2017/1.3.1.2/02/SI2.789013), funded by the by the
#>   European Union under Regulation (EU) No 508/2014 of the European
#>   Parliament and of the Council of 15 May 2014 on the European Maritime
#>   and Fisheries Fund, <https://github.com/EMODnet/EMODnetWFS>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {{EMODnetWFS}: Access EMODnet Web Feature Service data through R},
#>     author = {Anna Krystalli and Salvador Fernández-Bejarano and Maëlle Salmon},
#>     note = {R package version 2.0.1.9001. Integrated data products created under the European Marine Observation Data Network (EMODnet) Biology project (EASME/EMFF/2017/1.3.1.2/02/SI2.789013), funded by the by the European Union under Regulation (EU) No 508/2014 of the European Parliament and of the Council of 15 May 2014 on the European Maritime and Fisheries Fund},
#>     url = {https://github.com/EMODnet/EMODnetWFS},
#>   }
```

## Acknowledgements

This package was started by the Sheffield University during the EMODnet
Biology WP4 data products workshop in June 2020. You can read the
[product story on the EMODnet-Biology
portal](https://emodnet.ec.europa.eu/geonetwork/)
