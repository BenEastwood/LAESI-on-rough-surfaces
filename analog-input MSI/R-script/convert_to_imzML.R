### from RAW to imzML
library(MALDIquant)
library(MALDIquantForeign)
library(viridis)
library(RmsiGUI)

# with MassWolf RAW to mzXML (in windows console!)
massWolf --mzXML C:\MassLynx\Default.pro\Data\file.raw C:\MassLynx\Default.pro\Data\file.mzXML

## mzXML to imzML
# Enter sample name (without spaces, example: HylemonellaMono)
# Enter path for analog data file (*.txt)
# Enter path for TIC data file (*.txt)
# Enter path for mzXML data file (*.mzXML)
# Enter the number of rows (Y steps)(integer)
# Enter the number of columns (X steps)(integer)
# Enter the number of replicates on the plate for a single acquisition(integer)

RAW_to_ImZML()
180720_NEG_Thaliana_Leaf_bottom_2_Pierced_1249
W:\Data_Synapt\2018\zzhaoyu\mzXML\180720_NEG_Thaliana_Leaf_bottom_2_Pierced_1249_Analog.txt
W:\Data_Synapt\2018\zzhaoyu\mzXML\180720_NEG_Thaliana_Leaf_bottom_2_Pierced_1249_TIC.txt
W:\Data_Synapt\2018\zzhaoyu\mzXML\180720_NEG_Thaliana_Leaf_bottom_2_Pierced_1249_51x26.mzXML
51
26
1

# visualizing ion maps from imzML
library(viridis)
data_treat <- importImzMl("F:/Dokumente/Daten/Arabidopsis/imzML/180810_NEG_Thaliana_Leaf_bottom_4_Pierced_1543.imzML")
data_control <- importImzMl("F:/Dokumente/Daten/Arabidopsis/imzML/180810_NEG_Thaliana_Leaf_bottom_3_1419.imzML")
data_cotton <- importImzMl("F:/Dokumente/Daten/Cotton/180418_NEG_Cotton_Leaf_1//180418_NEG_Cotton_wrong.imzML")
data_cotton_alt <- importImzMl("W:/Data_Synapt/2018/bbartels/mzXML/imzML/180418_NEG_Cotton_Leaf_new.imzML")

pic_treat <- plotMsiSlice(data_treat, center = 436.04, tolerance = 0.05, colorRamp(viridis(1000)), legend = FALSE)
pic_control <- plotMsiSlice(data_control, center = 436.04, tolerance = 0.05, colorRamp(viridis(1000)), legend = FALSE)
pic_test <- plotMsiSlice(data_cotton, center = c(273.09), tolerance = 0.01, colorRamp(viridis(100)), legend = TRUE)

## alternatively RmsiGUI from Dr. Robert Winkler
library(RmsiGUI)
launch()

