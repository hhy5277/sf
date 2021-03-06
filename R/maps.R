#' @export
#' @name st_as_sf
st_as_sf.map = function(x, ...) {
	if (!requireNamespace("maptools", quietly = TRUE))
		stop("package maptools required, please install it first")
	if (!requireNamespace("sp", quietly = TRUE))
		stop("package sp required, please install it first")

	ID0 = vapply(strsplit(x$names, ":"), function(y) y[1], "")
	m.sp = maptools::map2SpatialPolygons(x, IDs = ID0, 
		proj4string = sp::CRS("+init=epsg:4326"))
	m = st_as_sf(m.sp)
	m$ID = vapply(m.sp@polygons, function(x) slot(x, "ID"), "")
	m
}

#' @export
#' @name st_as_sfc
st_as_sfc.map = function(x, ...) {
	st_geometry(st_as_sf(x, ...))
}
