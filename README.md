## SeasonalWet

This repository contains the data processing and analysis workflow for analyzing carbon dynamics in seasonal wetlands in the Cerrado. This work is part of the NSF DEB-NERC project: Spatial and temporal tradeoffs in CO2 and CH4 emissions in tropical wetlands.

------------------------------------------------------------------------

## Project structure

#### SeasonalWet

-   Data \# Input data (some files not included, see below)

    -   FluxProcessed \# Soil CO2 and CH4 flux along 6 months

    -   Hand \# Height above nearest drainage for each sampled point

    -   Moisture \# Raw data from TOSMT sensors, processed data from sensors (`tms_data.csv`) and graviometric moisture (`Umidade_grv.csv`, incomplete)

    -   Precipitation \# Precipitation data from CHIRPS and WorldClim

    -   Soil \# C, N and texture data for points; input data for clustering soils; and classified soils to VWC calculation.

-   Scripts \# R scripts and R Markdown files

    -   PreliminarAnalyses \# Preliminary data exploration. May need adaptations in dataframe name and path to run.

    -   MoistureSoilClasses \# Soils classification to generate input to TOMST processing. It creates the file `Data_SoilClasses.csv`

    -   TOMSTMoistureProcessing \# Processing sensors raw data. It need the output `Data_SoilClasses.csv`

    -   TOMSTMoistureAnalyses \# Correlating time series moisture data to flux. Analysis in development.

    -   ModelSEM \# Piecewise Structural Equation Model to explain fluxes. Main analysis for now.

-   Plots \# Generated outputs

-   SeasonalWet.Rproj \# RStudio project file

------------------------------------------------------------------------

## Data availability

The soil moisture data (`tms_data.csv`) used in this project are generated using the script `TOMSTMoistureProcessing.Rmd`.

Due to their large size, these data are not included in this repository.

You can download the processed dataset here:\
<https://drive.google.com/file/d/1--GgRlHxu_I2oiT_HL_feh3D9u9p3fWD/view?usp=drive_link>

After downloading, place the file in:

Data/Moisture/tms_data.csv

------------------------------------------------------------------------
