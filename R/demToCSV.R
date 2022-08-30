#' Convert a Raster DEM file to a Useable CSV that can be inputted into ClimateNA
#'
#' Input a TIFF file containing the DEM elevation values clipped to the area of focus. This tool will convert and produce a point featureclass shapefile with an identical name and use that shapefile's points and point coordinates to produce a CSV file. This CSV file is formatted so it can be inputted into ClimateNA.
#'
#' @param file string. A TIFF file at the desired spatial resolution.
#' @param outdir The output location for the formatted CSV file. The default is the same location as input.
#' @param srs string. A valid WKT string or SRS definition, such as "EPSG:4326" or "ESRI:102761" or NULL. If the DEM is already in lat/long projection, use NULL
#'
#' @return A CSV file representing the inputted DEM
#' @export
#' @importFrom utils write.csv
#' @importFrom data.table fwrite
#' @importFrom raster raster
#' @importFrom raster projectRaster
#' @importFrom raster as.data.frame
#'
#' @author Michael Burnett - UBC
#'
#' @examples
#' #files <- list.files(pattern='*.tif$')
#' #roiDEM <- files[3]
#' #demToCSV(roiDEM)
demToCSV <- function(file,outdir = dirname(file), srs = "EPSG:4326"){
  fileN <- basename(file)
  ras <- raster::raster(file) # Read raster
  if(is.null(srs)){r_df <- raster::as.data.frame(ras, xy = T, na.rm=  T)}
  else{
    r <- raster::projectRaster(ras,crs=sp::CRS(SRS_string = srs))
    r_df <- raster::as.data.frame(r, xy = T, na.rm=  T)
  }
  r_df$x <- r_df$x * -1 # Positive numbers required
  r_df$ID1 <- rownames(r_df)
  r_df$ID2 <- rownames(r_df) # A second ID column must be made to produce the climate variables

  csv <- r_df[c(4,5,2,1,3)]
  names(csv) <- c('ID1','ID2','lat','long','el')
  data.table::fwrite(csv,paste0(outdir,'/',substr(fileN,1,nchar(fileN)-4),'.csv'),row.names=FALSE)
}
