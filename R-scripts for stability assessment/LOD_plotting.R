### plotting of phenylalanine LOD determination data
library(ggplot2)

## classic LAESI geometry
 data_loaded <- read.csv("F:/Dokumente/Daten/Stability_Assessment/classic_LAESI/Limit_of_detection/190514_LOD_summary.csv")

 # plot measured intensity vs concentration
  data_int <- subset.data.frame(x = data_loaded, select = -StN)
  data_int_p <- aggregate(intensity_mz126_11 ~ experiment + Concentration, data = data_int, mean)
  data_int_p$SD_int <- aggregate(intensity_mz126_11 ~ experiment + Concentration, data = data_int, sd, simplify = TRUE)$intensity_mz126_11 

  classic_lod_int <- ggplot(data_int_p, aes(x = Concentration, y = intensity_mz126_11))+ 
    geom_point(alpha = 0.4, shape = 16, size = 6)+
    stat_summary(fun.data = mean_sdl, geom = "pointrange", size = 2, shape = 18)+
    scale_x_continuous("concentration in µg/ml", expand = c(0.025,0), limits = c(0,100)) + 
    scale_y_continuous("intensity in AU", expand = c(0.025,0), limits = c(0,750))+
    geom_abline(slope = 0, intercept = 10, color = "Red", lwd = 2)+
    theme_classic(base_size = 40)+
    theme(axis.text = element_text(color = "black"))
  ggsave("classic_lod_int.tiff",plot = classic_lod_int, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)

 # plot S/N vs concentration
  data_stn <- subset.data.frame(x = data_loaded, select = -intensity_mz126_11)
  data_stn_p <- aggregate(StN ~ experiment + Concentration, data = data_stn, mean)
  data_stn_p$SD_stn <- aggregate(StN ~ experiment + Concentration, data = data_stn, sd, simplify = TRUE)$StN

  classic_lod_stn <- ggplot(data_stn_p, aes(x = Concentration, y = StN))+ 
    geom_point(alpha = 0.4, shape = 16, size = 6)+
    stat_summary(fun.data = mean_sdl, geom = "pointrange", size = 2, shape = 18)+
    scale_x_continuous("concentration in µg/ml", expand = c(0.025,0), limits = c(0,100)) + 
    scale_y_continuous("signal to noise ratio", expand = c(0.025,0), limits = c(0,200))+
    geom_abline(slope = 0, intercept = 4, color = "Red", lwd = 2)+
    theme_classic(base_size = 40)+
    theme(axis.text = element_text(color = "black"))+
    theme(legend.position = "bottom")
  ggsave("classic_lod_stn.tiff",plot = classic_lod_stn, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)


## DP-1000 LAESI source
 data_loaded <- read.csv("F:/Dokumente/Daten/Stability_Assessment/commercial_LAESI/Limit_of_detection/200210_LOD_summary.csv")

 # plot measured intensity vs concentration
  data_int <- subset.data.frame(x = data_loaded, select = -StN)
  data_int_p <- aggregate(intensity_mz126_11 ~ experiment + Concentration, data = data_int, mean)
  data_int_p$SD_int <- aggregate(intensity_mz126_11 ~ experiment + Concentration, data = data_int, sd, simplify = TRUE)$intensity_mz126_11 

  commercial_lod_int <- ggplot(data_int_p, aes(x = Concentration, y = intensity_mz126_11))+ 
    geom_point(alpha = 0.4, shape = 16, size = 6)+
    stat_summary(fun.data = mean_sdl, geom = "pointrange", size = 2, shape = 18)+
    scale_x_continuous("concentration in µg/ml", expand = c(0.025,0), limits = c(0,100)) + 
    scale_y_continuous("intensity in AU", expand = c(0.025,0), limits = c(0,300))+
    geom_abline(slope = 0, intercept = 24, color = "Red", lwd = 2)+
    theme_classic(base_size = 40)+
    theme(axis.text = element_text(color = "black"))
    #theme(legend.position = "bottom")
  ggsave("commercial_lod_int_b.tiff",plot = commercial_lod_int, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)

 # plot S/N vs concentration
  data_stn <- subset.data.frame(x = data_loaded, select = -intensity_mz126_11)
  data_stn_p <- aggregate(StN ~ experiment + Concentration, data = data_stn, mean)
  data_stn_p$SD_stn <- aggregate(StN ~ experiment + Concentration, data = data_stn, sd, simplify = TRUE)$StN

  commercial_lod_stn <- ggplot(data_stn_p, aes(x = Concentration, y = StN))+ 
    geom_point(alpha = 0.4, shape = 16, size = 6)+
    stat_summary(fun.data = mean_sdl, geom = "pointrange", size = 2, shape = 18)+
    scale_x_continuous("concentration in µg/ml", expand = c(0.025,0), limits = c(0,100)) + 
    scale_y_continuous("signal to noise ratio", expand = c(0.025,0), limits = c(0,100))+
    geom_abline(slope = 0, intercept = 4, color = "Red", lwd = 2)+
    theme_classic(base_size = 40)+
    theme(axis.text = element_text(color = "black"))
    #theme(legend.position = "bottom")
  ggsave("commercial_lod_stn_b.tiff",plot = commercial_lod_stn, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)


## Ionisation chamber geometry
 data_loaded <- read.csv("F:/Dokumente/Daten/Stability_Assessment/old_LAESI/Limit_of_detection/190715_LOD_summary.csv")

 # plot measured intensity vs concentration
  data_int <- subset.data.frame(x = data_loaded, select = -StN)
  data_int_p <- aggregate(intensity_mz126_11 ~ experiment + Concentration, data = data_int, mean)
  data_int_p$SD_int <- aggregate(intensity_mz126_11 ~ experiment + Concentration, data = data_int, sd, simplify = TRUE)$intensity_mz126_11 

  old_lod_int <- ggplot(data_int_p, aes(x = Concentration, y = intensity_mz126_11))+ 
    geom_point(alpha = 0.4, shape = 16, size = 6)+
    stat_summary(fun.data = mean_sdl, geom = "pointrange", size = 2, shape = 18)+
    scale_x_continuous("concentration in µg/ml", expand = c(0.025,0), limits = c(0,100)) + 
    scale_y_continuous("intensity in AU", expand = c(0.025,0), limits = c(0,400))+
    geom_abline(slope = 0, intercept = 2, color = "Red", lwd = 2)+
    theme_classic(base_size = 40)+
    theme(axis.text = element_text(color = "black"))
    #theme(legend.position = "bottom")
  ggsave("chamber_lod_int_b.tiff",plot = old_lod_int, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)

 # plot S/N vs concentration
  data_stn <- subset.data.frame(x = data_loaded, select = -intensity_mz126_11)
  data_stn_p <- aggregate(StN ~ experiment + Concentration, data = data_stn, mean)
  data_stn_p$SD_stn <- aggregate(StN ~ experiment + Concentration, data = data_stn, sd, simplify = TRUE)$StN

  old_lod_stn <- ggplot(data_stn_p, aes(x = Concentration, y = StN))+ 
    geom_point(alpha = 0.4, shape = 16, size = 6)+
    stat_summary(fun.data = mean_sdl, geom = "pointrange", size = 2, shape = 18)+
    scale_x_continuous("concentration in µg/ml", expand = c(0.025,0), limits = c(0,100)) + 
    scale_y_continuous("signal to noise ratio", expand = c(0.025,0), limits = c(0,1000))+
    geom_abline(slope = 0, intercept = 4, color = "Red", lwd = 2)+
    theme_classic(base_size = 40)+
    theme(axis.text = element_text(color = "black"))
    #theme(legend.position = "bottom")
  ggsave("chamber_lod_stn_b.tiff",plot = old_lod_stn, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)


## Coaxial ionisation geometry
 data_loaded <- read.csv("F:/Dokumente/Daten/Stability_Assessment/new_LAESI/Limit_of_detection/190815_LOD_summary.csv")

 # plot measured intensity vs concentration
  data_int <- subset.data.frame(x = data_loaded, select = -StN)
  data_int_p <- aggregate(intensity_mz126_11 ~ experiment + Concentration, data = data_int, mean)
  data_int_p$SD_int <- aggregate(intensity_mz126_11 ~ experiment + Concentration, data = data_int, sd, simplify = TRUE)$intensity_mz126_11 

  new_lod_int <- ggplot(data_int_p, aes(x = Concentration, y = intensity_mz126_11))+ 
    geom_point(alpha = 0.4, shape = 16, size = 6)+
    stat_summary(fun.data = mean_sdl, geom = "pointrange", size = 2, shape = 18)+
    scale_x_continuous("concentration in µg/ml", expand = c(0.025,0), limits = c(0,100)) + 
    scale_y_continuous("intensity in AU", expand = c(0.025,0), limits = c(0,30))+
    geom_abline(slope = 0, intercept = 8, color = "Red", lwd = 2)+
    theme_classic(base_size = 40)+
    theme(axis.text = element_text(color = "black"))
    #theme(legend.position = "bottom")
  ggsave("coaxial_lod_int_b.tiff",plot = new_lod_int, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)

 # plot S/N vs concentration
  data_stn <- subset.data.frame(x = data_loaded, select = -intensity_mz126_11)
  data_stn_p <- aggregate(StN ~ experiment + Concentration, data = data_stn, mean)
  data_stn_p$SD_stn <- aggregate(StN ~ experiment + Concentration, data = data_stn, sd, simplify = TRUE)$StN

  new_lod_lod <- ggplot(data_stn_p, aes(x = Concentration, y = StN))+ 
    geom_point(alpha = 0.4, shape = 16, size = 6)+
    stat_summary(fun.data = mean_sdl, geom = "pointrange", size = 2, shape = 18)+
    scale_x_continuous("concentration in µg/ml", expand = c(0.025,0), limits = c(0,100)) + 
    scale_y_continuous("signal to noise ratio", expand = c(0.025,0), limits = c(0,25))+
    geom_abline(slope = 0, intercept = 4, color = "Red", lwd = 2)+
    theme_classic(base_size = 40)+
    theme(axis.text = element_text(color = "black"))
    #theme(legend.position = "bottom")
  ggsave("coaxial_lod_lod_b.tiff",plot = new_lod_lod, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)
