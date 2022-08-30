#' Rasterize Climate data from ClimateNA
#'
#' This function uses a CSV input to produce a raster file from a desired climate column based on the longitude and latitude of that point.
#'
#' @param Longitude The data frame column including the Longitudinal data
#' @param Latitude The data frame column including the Latitudinal data
#' @param Value numeric. The data frame column including the raster pixel values
#' @param filename character. Output file name. Must include file type (example ".tif")
#' @param crsref 	character. Description of the Coordinate Reference System (map projection) in PROJ.4, WKT or authority:code notation
#' @param outdir character. Output directory for the raster file
#'
#' @return A raster representative of the climate data acquired through ClimateNA
#' @export
#'
#' @importFrom terra rast
#'
#' @author Michael Burnett - UBC
#'
#' @examples
#' #data <- read.csv('climateNA_monthlyDataOutput.csv')
#' #CSVtoTIFF(data$Longitude,data$Latitude,data$Tmin,'annual_Tmin.tif')
#'
CSVtoTIFF <- function(Longitude, Latitude, Value, filename, crsref = "+proj=longlat +datum=WGS84", outdir = getwd()){
  pts <- data.frame(Longitude, Latitude, Value) # Use the three relevant columns for raster creation
  r <- terra::rast(pts,crs=crsref)
  terra::writeRaster(r,paste0(outdir,'/',filename),overwrite=TRUE)
}
