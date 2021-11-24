wfs <- suppressMessages(emodnet_init_wfs_client(service = "human_activities"))

test_that("layer_attributes_get_names works", {
    expect_equal(layer_attributes_get_names(wfs, layer = "maritimebnds"),
                 c("objectid", "mblszotpid", "localid", "sitename", "legalfound",
                   "legalfou_1", "country", "nationalle", "nutscode", "mblsds_mbl",
                   "shape_leng", "the_geom"))
    expect_equal(suppressMessages(layer_attributes_get_names(service = "human_activities", layer = "maritimebnds")),
                 c("objectid", "mblszotpid", "localid", "sitename", "legalfound",
                   "legalfou_1", "country", "nationalle", "nutscode", "mblsds_mbl",
                   "shape_leng", "the_geom"))
})

test_that("layer_attribute_descriptions works", {
    expect_equal(layer_attribute_descriptions(wfs, layer = "maritimebnds"),
                 testthis::read_testdata("attr_desc"))
})

test_that("layer_attribute_inspect works", {
    sitename_insp <- layer_attribute_inspect(wfs, layer = "maritimebnds", attribute = "sitename")
    expect_equal(class(sitename_insp),
                 c("tabyl", "data.frame"))
    expect_equal(names(sitename_insp),
                 c(".", "n", "percent"))
    expect_true(nrow(sitename_insp) > 1)

    localid_insp <- layer_attribute_inspect(wfs, layer = "maritimebnds", attribute = "localid")
    expect_equal(class(localid_insp),
                 c("summaryDefault", "table"))
    expect_equal(names(localid_insp),
                 c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max."))
    expect_length(localid_insp, 6L)

})


test_that("layer_attributes_summarise works", {
    maritimebnds_summ <- layer_attributes_summarise(wfs, layer = "maritimebnds")
    expect_equal("table", class(maritimebnds_summ))
    expect_equal(maritimebnds_summ[ ,"  sitename"][2:3],
                 structure(c("Class :character  ", "Mode  :character  "), .Names = c("",
                                                                                     "")))
    expect_equal(maritimebnds_summ[ ,"  shape_leng"][1],
                 structure("Min.   :   0.0000  ", .Names = ""))
    expect_equal(maritimebnds_summ[ ,"   objectid"][1],
                 structure("Min.   :   1.0  ", .Names = ""))
    expect_equal(ncol(maritimebnds_summ),
                 length(layer_attributes_get_names(wfs, layer = "maritimebnds")))
})


test_that("get_default_crs works", {
    #expect_equal(get_layer_default_crs(layer = "maritimebnds", wfs, output = "crs"),
       #          testthis::read_testdata("maritime_crs"))
    expect_equal(get_layer_default_crs(layer = "maritimebnds", wfs, output = "epsg.text"),
                 "epsg:4326")
    expect_equal(get_layer_default_crs(layer = "maritimebnds", wfs, output = "epsg.num"),
                 4326)
})


