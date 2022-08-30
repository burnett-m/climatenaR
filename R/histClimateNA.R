#' Access Historical ClimateNA Data
#'
#' This is a specialty function that has several preliminary requirements. The output produces the  historical climate variables for the provided CSV file.
#' In order to properly use this function, you must prepare the CSV file so that it is compatible with the ClimateNA requirements (using the demToCSV tool).
#' The working directory must be set to the location which the ClimateNA app is located.
#'
#' @param file string. The prepared DEM as a CSV file.
#' @param dateR string. The historical year (or time frame) for the climate data. If annual data is desired, make sure it is in the number format of 'XXXX'. If decadal or 30 years normals are desired, make sure it is in the 10 years format of 'XXX1_XXX0'. Underscore is necessary, as opposed to dash.
#' @param tFrame string. The averaged time frame of each climate variable. Use 'M' for monthly, 'Y' for annual, and 'S' for seasonal.
#' @param exe string. Full name of the ClimateNA exe file. The working directory must be the location of this file.
#' @param outdir The output directory for the climate data. As a default, it will be outputted to the same location as the input CSV file.
#'
#' @return A CSV file with historical climate data
#' @export
#' @author Michael Burnett - UBC
#'
#' @examples
#' ## Annual climate data
#' #setwd("E:/Climatena_v721");getwd() # Set up location for the application
#' #exe <- "E:/Climatena_v721/ClimateNA_v7.21.exe"
#' #files <- list.files(pattern = '*.csv$')
#' #histClimateNA(files[1],'1981','M',exe)
#'
#' ## Decadal climate data
#' #setwd("E:/Climatena_v721");getwd() # Set up location for the application
#' #exe <- "E:/Climatena_v721/ClimateNA_v7.21.exe"
#' #files <- list.files(pattern = '*.csv$')
#' #histClimateNA(files[1],'1981_1990','M',exe)
#'
#' ## 30 years normals
#' #setwd("E:/Climatena_v721");getwd() # Set up location for the application
#' #exe <- "E:/Climatena_v721/ClimateNA_v7.21.exe"
#' #files <- list.files(pattern = '*.csv$')
#' #histClimateNA(files[1],'1991_2020','M',exe)
histClimateNA <- function(file,dateR,tFrame,exe,outdir = dirname(file)){
  fileN <- basename(file)
  if(nchar(dateR) == 4){yearPeriod <- paste0('/Year_',dateR,'.ann')}
  if(nchar(dateR) == 9){
    n1 <- as.numeric(substr(dateR,1,4))
    n2 <- as.numeric(substr(dateR,6,9))
    if((n2 - n1) == 9){yearPeriod <- paste0('/Decade_',dateR,'.dcd')}
    else if((n2 - n1) == 29){yearPeriod <- paste0('/Normal_',dateR,'.nrm')}
    else{stop('Only decadal and 30 years normals are available. First year must end with a 1, followed by an underscore, and the last year must end with a zero.')}
  }
  if(is.numeric(dateR)){stop('Use strings to define years.')}
  inputFile <- paste0('/',gsub('/','\\\\',dirname(file)),'\\',fileN)
  outputFile <- paste0('/',gsub('/','\\\\',outdir),'\\',substr(fileN,1,nchar(fileN)-4),'_',dateR,'.csv')
  system2(exe,args= c(paste0('/',tFrame), yearPeriod, inputFile, outputFile))
}
