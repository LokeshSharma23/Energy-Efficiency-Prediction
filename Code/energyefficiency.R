# Data Science Individual Project
# Title: Energy Efficiency Data Analysis
# Author: Lokesh Sharma

rm(list=ls())

# Loading the csv file of data set
data=read.csv(file.choose())

# Exploratory Data Analysis

dim(data)
# data has 768 observations and 10 columns
attach(data)
names(data)
str(data)
summary(data)

# Creating boxplots of quantitative predictors to explore the data
par(mfrow=c(1,5))
boxplot(relative.compactness, main="Relative Compactness")
boxplot(surface.area, main="Surface Area")
boxplot(wall.area, main="Wall Area")
boxplot(roof.area, main="Roof Area")
boxplot(overall.height, main="Overall Height")

# It is clear from the Boxplots that there is no outlier in the predictors
# Thus, we can go ahead with further analysis


# Finding Correlation among response and predicting variables
cor(data)

# Creating Pairwise Scatterplot of the variables in the dataset
plot(data)

# Creating correlation matrix and saving it as csv file
data1=data.frame(cor(data))
write.csv(data1,"correlation.matrix.csv")

# From the plot it is clear that Heating Load and Cooling Load are highly correlated
# Extrating the Pearson's Correlation coefficient for the two response variables

cor(heating.load,cooling.load)
plot(heating.load,cooling.load)

# Heating Load and Cooling Load are highly correlated wtih correlation coefficient of 0.9758
# Hence by studying one of the response variables, 
# we can predict the value of other response variable
# That is, we are fitting linear model with Heating Load as the response variable

# Further, Overall height is highly correlated with Heating load and have
# correlation coefficient of 0.88. Also, Relative Compactness has a good correlation
# with response variable. Hence, we can say that they 
# are good predictor of Heating load


# Building a linear model to predict the Heating Load requirements of building

# Orientation, Glazing Area and Glazing Area Distribution are categorial variables
# Thus, converting them into factors by using as.factor() function
data$orientation=as.factor(data$orientation)
data$glazing.area=as.factor(data$glazing.area)
data$glazing.area.distribution=as.factor(data$glazing.area.distribution)
levels(data$orientation)=c("North","East","South","West")
levels(data$glazing.area)=c("0%", "10%", "25%", "40%")
levels(data$glazing.area.distribution)=c("UnKnown", "Uniform", "North", "East", "South", "West")
summary(data)

# Building the full model using lm() fuction

m1=lm(heating.load~relative.compactness+surface.area+wall.area+roof.area+
        overall.height+factor(orientation)+
        factor(glazing.area)+factor(glazing.area.distribution),data)
summary(m1)
plot(m1)

# During linear regression we analyzed the model based
# on hypothesis that: All regression coefficients are 0. So,
# Null Hypothesis=All regression coefficients are zero.
# Alternate Hypothesis=Atleast one coefficient is not zero.
# Since the p-value for the model is less than alpha i.e. 2.2e-16 
# we can reject the Null Hypothesis.
# Also, from the summary, we found that R square value is very high i.e. 0.9239
# Thus, this model fits the data very well
# However, the p value for Orientation and Glazing Area Distribution are 
# very high and insignificant. And Roof area is not related to the response variable

# Using Backward Stepwise Selection to reduce the number of predictors
# Using step(m1) to select the significant number of predictors 
# by comparing their AIC values 

step(m1)

# Roof Area is found to be insignificant with highest AIC value
# Removing Roof area and building the model m2

m2=lm(heating.load~relative.compactness+surface.area+wall.area+
           overall.height+factor(orientation)+
           factor(glazing.area)+factor(glazing.area.distribution),data)
summary(m2)

# By comparing m1 and m2 on the basis of R square and Residual Standard Error,
# it is found that m2 is better model with one less predictor than m1

# Again, by using step function results
# Glazing Area Distribution is found to be insignificant with highest AIC value
# among all other predictors
# Thus, removing Glazing Distribution Area and building the model m3

m3=lm(heating.load~relative.compactness+surface.area+wall.area+
        overall.height+factor(orientation)+
        factor(glazing.area),data)
summary(m3)

# By comparing m2 and m3 on the basis of R square and Residual Standard Error,
# it is found that m3 is better model with one less predictor than m2

# Again, by using step function results
# Orientation is found to be insignificant with highest AIC value
# among all other predictors
# Thus, removing Orientation and building the model m4

m4=lm(heating.load~relative.compactness+surface.area+wall.area+
        overall.height+
        factor(glazing.area),data)
summary(m4)

# By comparing m3 and m4 on the basis of R square and Residual Standard Error,
# it is found that m4 is better model with one less predictor than m3


# Overall by comparing all the models m1, m2, m3, and m4 on the basis 
# of R squared value and Residual Standard Error, m4 is found to be the best model
# Adjusted R square value continuously increased from model m1 to m4
# Moreover, in the m4 model all predictors are significant on the basis of their p value
# Thus, m4 is the best model with 3 predictors less than the full model m1


# Testing the significance of removed predictors(Roof Area, Glazing Area Distribution,
# and Orientation) by using anova function
# Hypothesis Test
# Null Hypothesis: Removal was correct
# Alternative Hypothesis: Removal was incorrect

anova(m1,m4)

# p value is 0.4355, thus we fail to reject the null hypothesis
# Thus, there is insufficient evidence, at 5 % level of significance
# to conclude that removed was incorrect. That is, removal was correct.

summary(m4)

# Model m4 has a very high R square value of 92.39% 
# and it has very less Residual Standard Error of 2.796
# Hence reduced m4 model is best for the given data set
# And can be used for future prediction


# Predicting the values of Heating Load at mean and median value of quantitative 
# variable and by changing glazing area percentage arbitrarily

# Predicting Heating load at mean value of quantitative predictors and 10% glazing area
pred.data <- data.frame(relative.compactness=mean(relative.compactness), 
                        surface.area=mean(surface.area),
                        wall.area=mean(wall.area),overall.height=mean(overall.height),
                        glazing.area="10%")
pred.data
predict(m4, pred.data, type="response",interval="confidence")
# Heating Load is predicted to be 20.35

# Predicting Heating load at median value of quantitative predictors and 25% glazing area
pred.data1 <- data.frame(relative.compactness=mean(relative.compactness), 
                        surface.area=mean(surface.area),
                        wall.area=mean(wall.area),overall.height=mean(overall.height),
                        glazing.area="25%")
pred.data1
predict(m4, pred.data1, type="response",interval="confidence")
# Heating Load is predicted to be 22.75

########################################################################################

