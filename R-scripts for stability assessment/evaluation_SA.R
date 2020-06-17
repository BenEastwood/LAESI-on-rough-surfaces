#### 03.06.19
## Benjamin Bartels
## Stability Assesment Experiments
#  libraries
   library(Hmisc)
   library(lsr)
   library(RColorBrewer)
   library(ggpubr)
   
## Processing raw data
   exp_list <- c("classic", "commercial", "mini", "coaxial")
   exp_data <- c("classic_LAESI/Stability/190523_SA_summary.csv", "commercial_LAESI/stability/200212_SA_summary.csv","old_LAESI/Stability/190717_SA_summary.csv","new_LAESI/Stability/190822_SA_summary.csv")
   exp_type <- c("a", "b", "c", "d", "e", "f", "g", "h")
   i  <-  1
   for(exp in exp_list){
     #  Loading data raw data
     data_loaded <- read.csv(paste("F:/Dokumente/Daten/Stability_Assessment/",exp_data[i], sep =""))
     data_loaded[2] <- as.factor(data_loaded$Rep_Exp)
     data_loaded[3] <- as.factor(data_loaded$Rep_Phe)
     
     #  Processing Phe intensity data
     data_Phe <- subset.data.frame(x = data_loaded, select = -Current)
     data_Phe_p <- aggregate(Phe_Int ~ Experiment + Rep_Exp, data = data_Phe, mean)
     data_Phe_p$SD_Phe <- aggregate(Phe_Int ~ Experiment + Rep_Exp, data = data_Phe, sd, simplify = TRUE)$Phe_Int
     
     for (rep in 1:nrow(data_Phe_p)){
       data_Phe_p$coeff_var[rep] <- data_Phe_p$SD_Phe[rep]/data_Phe_p$Phe_Int[rep]  
     }
     
     assign(paste("data", exp, sep = "_"), data_Phe_p)
     
     # Processing ESI current data
     data_current <- subset.data.frame(x = data_loaded, select = -Phe_Int)
     data_current_p <- aggregate(Current ~ Experiment + Rep_Exp, data = data_current, mean)
     a <- 1
     for (exprep in 1:10){
       data_range <- subset(data_current, Rep_Exp == exprep)
       for(expi in 1:8){
         data_range_sub <- subset(data_range, Experiment == exp_type[expi], select = Current)
         range <- max(data_range_sub$Current) - min(data_range_sub$Current)
         data_current_p$Range_Cur[a] <- range
         a = a + 1
       }
     }
     
     for (rep in 1:nrow(data_current_p)){
       data_current_p$Current[rep] <- data_current_p$Current[rep]*100
       data_current_p$Range_Cur[rep] <- data_current_p$Range_Cur[rep]*100
       }
     
     # Merge and safe data by source type
     data_p <- merge(x = data_Phe_p, y = data_current_p, sort = TRUE)
     data_p$source <- exp_list[i]
     assign(paste("data", exp, sep = "_"), data_p)
     
     i = i + 1
   }
   
## creating report 
   report <- rbind(data_classic, data_commercial, data_mini, data_coaxial)
   write.csv(report, file = "F:/Dokumente/Daten/Stability_Assessment/report.csv", row.names = FALSE)
   rm(data_current, data_current_p, data_loaded, data_Phe, data_Phe_p, data_p, data_classic, data_commercial, data_coaxial, data_mini, data_range, data_range_sub)
   rm(exp, exp_data, exp_list, exp_type, i, rep, range, exprep, expi, a)
   
## Plotting
   # report <- read.csv(insert address here)
   results <- subset.data.frame(x = report, Experiment == "g")
   current_plot_data <- subset.data.frame(report, Experiment == "g" | Experiment == "e", select = c(-Phe_Int, -SD_Phe, -coeff_var))
 
 # Boxplot
   # stability of response
   compare_means(coeff_var~source, data = results, method = "t.test")
   source_comparisons <- list(c("classic", "commercial"), c("coaxial", "mini"), c("coaxial", "commercial"), c("commercial", "mini"))
   coeff_plot <- ggplot(results, aes(source, y = coeff_var))+
          geom_boxplot(alpha = 1, shape = 1, size = 2) +
          stat_compare_means(comparisons = source_comparisons, size = 8)+
          scale_x_discrete("Ion source geometry", label = c("classic", "coaxial", "DP-1000","chamber")) + 
          scale_y_continuous("Coefficient of variation", expand = c(0.025,0), limits = c(0,1.3))+
          theme_classic(base_size = 40)+
          theme(axis.text = element_text(color = "black"))+
          theme(legend.position = "bottom")
   ggsave("coefficient_stat_source.tiff",plot = coeff_plot, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)
   
   # Current Range
   # compare means between ablation
   range_plot <- ggplot(current_plot_data, aes(source, y = Range_Cur, col = Experiment))+
          geom_boxplot(alpha = 1, shape = 1, size = 2) +
          stat_compare_means(aes(group = Experiment), label = "p.signif", size = 12)+
          scale_color_brewer(palette = "Set1",label = c("No Ablation","Ablation"))+
          scale_x_discrete("Ion source geometry", label = c("classic", "coaxial", "DP-1000","chamber")) + 
          scale_y_continuous("Electrospray current range [nA]", limits = c(0,22),expand = c(0.025,0))+
          theme_classic(base_size = 40)+
          theme(axis.text = element_text(color = "black"))+
          theme(legend.position = "none")
   ggsave("current_range_stat_ablation.tiff",plot = range_plot, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)
   
   # compare means between sources
   range_plot <- ggplot(current_plot_data, aes(source, y = Range_Cur))+
     geom_boxplot(alpha = 1, shape = 1, size = 2) +
     stat_compare_means(method = "anova", label.y = 10, size = 12)+
     stat_compare_means(label = "p.signif", method = "t.test", ref.group = "classic", size = 12)+
     scale_color_brewer(palette = "Set1",label = c("No Ablation","Ablation"))+
     scale_x_discrete("Ion source geometry", label = c("classic", "coaxial", "DP-1000","chamber")) + 
     scale_y_continuous("Electrospray current range [nA]", limits = c(0,22),expand = c(0.025,0))+
     theme_classic(base_size = 40)+
     theme(axis.text = element_text(color = "black"))+
     theme(legend.position = "none")
   ggsave("current_range_stat_source.tiff",plot = range_plot, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)
   
   # Current mean
   mean_plot <- ggplot(current_plot_data, aes(source, y = Current, col = Experiment))+
          geom_boxplot(alpha = 1, shape = 1, size = 2) +
          scale_color_brewer(palette = "Set1",label = c("No Ablation","Ablation"))+
          scale_x_discrete("Ion source geometry", label = c("classic", "coaxial", "DP-1000","chamber")) + 
          scale_y_continuous("Electrospray current [nA]", expand = c(0.025,0))+
          theme_classic(base_size = 40)+
          theme(axis.text = element_text(color = "black"))+
          theme(legend.position = "none")
   ggsave("current_mean.tiff",plot = mean_plot, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)
  
   #compare means between ablation
   mean_plot <- ggplot(current_plot_data, aes(source, y = Current, col = Experiment))+
     geom_boxplot(alpha = 1, shape = 1, size = 2) +
     stat_compare_means(aes(group = Experiment), label = "p.signif", label.y = 120, size = 12)+
     scale_color_brewer(palette = "Set1",label = c("No Ablation","Ablation"))+
     scale_x_discrete("Ion source geometry", label = c("classic", "coaxial", "DP-1000","chamber")) + 
     scale_y_continuous("Electrospray current [nA]", expand = c(0.025,0), limits = c(50, 175))+
     theme_classic(base_size = 40)+
     theme(axis.text = element_text(color = "black"))+
     theme(legend.position = "none")
   ggsave("current_mean_stat_ablation.tiff",plot = mean_plot, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)
   
   #compare means between source
   mean_plot <- ggplot(current_plot_data, aes(source, y = Current))+
     geom_boxplot(alpha = 1, shape = 1, size = 2) +
     stat_compare_means(method = "anova", label.y = 80, size = 12)+
     stat_compare_means(label = "p.signif", method = "t.test", ref.group = "classic", label.y = 100, size = 12)+
     scale_color_brewer(palette = "Set1",label = c("No Ablation","Ablation"))+
     scale_x_discrete("Ion source geometry", label = c("classic", "coaxial", "DP-1000","chamber")) + 
     scale_y_continuous("Electrospray current [nA]", expand = c(0.025,0), limits = c(50,175))+
     theme_classic(base_size = 40)+
     theme(axis.text = element_text(color = "black"))+
     theme(legend.position = "none")
   ggsave("current_mean_stat_source.tiff",plot = mean_plot, device = "tiff",width = 12, height = 10, units = "in", dpi = 300)
   