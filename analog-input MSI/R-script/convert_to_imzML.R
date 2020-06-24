### from RAW to imzML
library(MALDIquant)
library(MALDIquantForeign)
library(viridis)

# with MassWolf RAW to mzXML (in windows console!)
massWolf --mzXML C:\MassLynx\Example.pro\Data\file.raw C:\MassLynx\Example.pro\Data\file.mzXML

## mzXML to imzML
# Enter sample name (without spaces)
# Enter path for analog data file (*.txt)
# Enter path for TIC data file (*.txt)
# Enter path for mzXML data file (*.mzXML)
# Enter the number of rows (Y steps)(integer)
# Enter the number of columns (X steps)(integer)
# Enter the number of replicates on the plate for a single acquisition(integer)
#e.g.:
RAW_to_ImZML()
180720_NEG_imaging_plant_leaf_2_treated_0815
W:\Data_Synapt\2020\musterfrau\mzXML\180720_NEG_imaging_plant_leaf_2_treated_0815_Analog.txt
W:\Data_Synapt\2020\musterfrau\mzXML\180720_NEG_imaging_plant_leaf_2_treated_0815_TIC.txt
W:\Data_Synapt\2020\musterfrau\mzXML\180720_NEG_imaging_plant_leaf_2_treated_0815_51x26.mzXML
51
26
1

# visualizing ion maps from imzML
library(viridis)
data_treat <- importImzMl("W:/Data_Synapt/2020/musterfrau/imzML/180720_NEG_imaging_plant_leaf_2_treated_0815.imzML")
data_control <- importImzMl("W:/Data_Synapt/2020/musterfrau/imzML/180720_NEG_imaging_plant_leaf_1_cntrl_1337.imzML")

pic_treat <- plotMsiSlice(data_treat, center = 436.04, tolerance = 0.05, colorRamp(viridis(1000)), legend = FALSE)
pic_control <- plotMsiSlice(data_control, center = 436.04, tolerance = 0.05, colorRamp(viridis(1000)), legend = FALSE)

