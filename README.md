# climatenaR
![license](https://img.shields.io/badge/License-R--package-green) 
![license](https://img.shields.io/badge/Topic-Climatology-yellowgreen) 

R package for accessing and processing climate data from ClimateNA.
The **climatenaR** package provides functions to prepare Digital Elevation Models (DEM) as TIFF files into CSV files, access historical and future projected climate data,and reproject it. This package is very similar to my other package as part of the Silva21 Project **silvR21** available on my [Silva21 Github Page](https://github.com/Silva21-irss/silvR21).

## Key Features
#### Historical Climate Access
As an alternative to using the desktop application, `histClimateNA` permits the user to access historical means for monthly, seasonal, and annual mean data over 30 years, 10 years, and annual periods. These functions have the advantage of using DEM files located anywhere on your computer.
#### Future Climate Projections Access
The `projClimateNA` tool enhances the access abilities with ClimateNA as it is easier to select GCM models, SSP scenarios, and date ranges by adjusting a few parameters. The DEM file used to access projected data must be located within the same directory as the ClimateNA application.
#### Converting DEM file to CSV ready for use
The guidelines for preparing a DEM file so that it can be correctly formatted for use with ClimateNA can be difficult to make properly. Errors are common and it is not always obvious how to correct them. The `demToCSV` tool is specifically designed to prepare any DEM TIFF file in the correct CSV format so that it can be inputted into either `histClimateNA` or `projClimateNA`.
#### Reprojecting ASCII Files
After using the ASCII DEM file format as input within the ClimateNA desktop application, the resulting outputs are often not projected properly, so they would not appear in the correct location once inputted into ArcGIS. `reprojectASCII` will automatically reproject these images.

## About
**climatenaR** is developed openly at [UBC](https://www.ubc.ca/).
* Development of the **climatenaR** package started in 2022.

## Install **climatenaR** Package
* First, you will need to install the `devtools` package.
* Install the **climatenaR** package through GitHub with `devtools::install_github("burnett-m/climatenaR",build_vignettes = TRUE)`
