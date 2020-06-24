# Regression modelling for determination of phenylalaine LOD
library(nlme)
library(car)

setwd("C:/Users/Bensen/Desktop/R-Skripte")
regr <- read.table("190715_LOD_summary_median.txt", header = T)
View(regr)
str(regr)
attach(regr)

## linear correlation ####
plot(med_intensity ~ Concentration, pch = 20, col = as.numeric(experiment))
m1 <- lm(med_intensity ~ Concentration)
summary(m1)
abline(m1) 
par(mfrow = c (2,2))
plot(m1) 

## quadratic or similar correlation ####

plot(log(med_intensity) ~ Concentration, pch = 20, col = as.numeric(experiment)) # linearisation through log?

# sqrt-transformation = (med_intensity)^ 0.5 ####
plot((med_intensity)^ 0.5 ~ Concentration, pch = 20, col = as.numeric(experiment))
m2 <- lm((med_intensity)^0.5 ~ Concentration)
summary(m2)
abline(m2, lty = 3) 
par(mfrow = c (2,2))
plot(m2) 
# Testing for lack of fit: change continous variable (Concentration) to a factor
# followed by Anova. If Anova and regression correlate well, then the model is good
regr$fac.conc <- as.factor(regr$Concentration)
m3 <- lm((med_intensity)^0.5 ~ regr$fac.conc)
summary(m3)
anova(m2,m3) # the closer the p-Wert gets to 1 the better 

# (med_intensity)^ 0.6 ####
plot((med_intensity)^ 0.6 ~ Concentration, pch = 20, col = as.numeric(experiment))
m4 <- lm((med_intensity)^0.6 ~ Concentration)
summary(m4)
abline(m4, lty = 3)
par(mfrow = c (2,2))
plot(m4)
# Testing for lack of fit
m5 <- aov((med_intensity)^0.6 ~ regr$fac.conc)
summary(m5)
anova(m4,m5) # schon besser


# (med_intensity)^ 0.7 ####
plot((med_intensity)^ 0.7 ~ Concentration, pch = 20, col = as.numeric(experiment))
m6 <- lm((med_intensity)^0.7 ~ Concentration)
summary(m6)
abline(m6, lty = 3) 
par(mfrow = c (2,2))
plot(m6)
# Testing for lack of fit
m7 <- aov((med_intensity)^0.7 ~ regr$fac.conc)
summary(m7)
anova(m6,m7) 

# (med_intensity)^ 0.8 ####
plot((med_intensity)^ 0.8 ~ Concentration, pch = 20, col = as.numeric(experiment))
m8 <- lm((med_intensity)^0.8 ~ Concentration)
summary(m8)
abline(m8, lty = 3) 
par(mfrow = c (2,2))
plot(m8) 
# Testing for lack of fit
m9 <- aov((med_intensity)^0.8 ~ regr$fac.conc)
summary(m9)
anova(m8,m9) 


## Weighing of the residuals - GLS: generalized least squares model

v1 <- varFixed(~ Concentration) 
v2 <- varPower(form = ~ Concentration)
v3 <- varExp(form = ~ Concentration)
v4 <- varConstPower(form = ~ Concentration)

m10 <- gls((med_intensity)^0.7 ~ Concentration)
m11 <- gls((med_intensity)^0.7 ~ Concentration, weights = v1)
m12 <- gls((med_intensity)^0.7 ~ Concentration, weights = v2)
m13 <- gls((med_intensity)^0.7 ~ Concentration, weights = v3)
m14 <- gls((med_intensity)^0.7 ~ Concentration, weights = v4)

anova(m10,m11,m12,m13) #lowest AIC m11 is the best model 
summary(m13)

plot((med_intensity)^ 0.7 ~ Concentration, pch = 20, col = as.numeric(experiment))
abline(m6) # insert model without variance correction
abline(m13, lty = 3, col = 2) # model with variance correction 

# model check, insert best model with variance correction 
par(mfrow=c(2,2))
r13 <- resid(m13, type = "normalized") # residuals
f13 <- fitted(m13) # fitted values
plot(x = f13, y = r13, xlab = "fitted values", ylab = "residuals", main = "m13 - gls")
library(car)
qqPlot(r13, main = " qq-plot m13 - gls")
#qqnorm(r11 )
#qqline(r11)

# compare to model without variance correction
r6 <- resid(m6)
f6 <- fitted(m6)
plot(x = f6, y = r6, xlab = "fitted values", ylab = "residuals", main = "m6 - normal regression")
qqPlot(r6, main = " qq-plot m6 - normal regression")
#qqnorm(r6, main = " qq-plot m6 - normal regression")
#qqline(r6)

# check curve of model relative to data points, insert model with variance correction 
plot(med_intensity ~ Concentration, pch = 20, col = as.numeric(experiment))
x <- 0:500
ym13 <- (2.2355208 + 0.4396432*x)^(10/7)
lines(x,ym13)

# intercept (x=0)
ym13_0 <- 32.2355208^(10/7)
abline(h=ym13_0, col=2)
ym13_0
# 22.20197


## quadratic regression ####
m15 <- lm(med_intensity ~ Concentration + I(Concentration^2))
summary(m15) 
par(mfrow=c(2,2))
plot(m15)

# curve
plot(med_intensity ~ Concentration, pch = 20, col = as.numeric(experiment))
ym15 <- predict(m15,list(Concentration=x))
lines(x,ym15) 
# comparison to SQRT-linearized (insert here)
lines(x,ym13, lty=3) 

# Weighing of the residuals - GLS: generalized least squares model
m16 <- gls(med_intensity ~ Concentration + I(Concentration^2))
m17 <- gls(med_intensity ~ Concentration + I(Concentration^2), weights = v1)
m18 <- gls(med_intensity ~ Concentration + I(Concentration^2), weights = v2)
m19 <- gls(med_intensity ~ Concentration + I(Concentration^2), weights = v3)
m20 <- gls(med_intensity ~ Concentration + I(Concentration^2), weights = v4)

anova(m16,m17,m18,m19,m20) 
summary(m20)
# model check, insert best model with variance correction 
par(mfrow=c(2,2))

r18 <- resid(m18, type = "normalized") # residuals
f18 <- fitted(m18) # fitted values
plot(x = f18, y = r18, xlab = "fitted values", ylab = "residuals", main = "m18 - gls")
library(car)
qqPlot(r18, main = " qq-plot m18 - gls")

# compare to model without variance correction
r16 <- resid(m16, type = "pearson") # residuals
f16 <- fitted(m16) # fitted values
plot(x = f16, y = r16, xlab = "fitted values", ylab = "residuals", main = "m16 simple quadr. regression")
library(car)
qqPlot(r16, main = " qq-plot m16 einfache quadr. Regression")

## determine LOD, by finding concentration that results in threshold intensity
 # 'concentration' data to predict intensity from
  conc_data_classic_lod = data.frame(Concentration = seq(2.4, 2.5, by=0.005)) #lod intercept = 10 result: 2.445 µg/ml
  conc_data_ionchambr_lod = data.frame(Concentration = seq(0.8, 1, by=0.005)) #lod intercept = 2 result: 0.860 µg/ml
  conc_data_commerc_lod = data.frame(Concentration = seq(4.25, 4.75, by=0.005)) #lod intercept = 24 result: 4.335 µg/ml
  conc_data_coax_lod = data.frame(Concentration = seq(32, 33, by=0.01)) # lod intercept = 8 result: 32.19 µg/ml.
  
  predict(m18, conc_data_ionchambr_lod) #insert best model with variance correction and approrate sample data
  
  # guestimate CI
  # 3 median values -> 2 degrees of freedom t-quantile (t) for alpha = 0.05 in two sided test: 4.303
  # estimate concentration values from the intensity values from concentration measured closest to determined LOD with PQ formula like (equation 6 in the appendix)
  # determine standard deviation SD from concentration estimates
  # CI = +/- (SD*t)/SQRT(n)
  detach(regr)
