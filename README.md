# Energy-Efficiency-Prediction

Introduction
The aim of the report is to study and analyze the Energy Efficiency Dataset. I have
performed multiple linear regression on this dataset using response variable called Heating Load. Along with this variable, 
I also performed an analysis on other variables in the dataset and studied the significance of these variables to build the 
linear regression model. I build the model using following two criterions: Ordinary Least squares and Backward Step wise selection method
using Akaike Information Criterion(AIC) values to represent the data linearly.

Data Set Information
The dataset is imported from UCI Machine Learning Repository. Energy analysis is performed using 12 different building shapes simulated in Ecotect. The buildings differ with respect to the
glazing area, the glazing area distribution, and the orientation, amongst other parameters. The dataset comprises 768 samples and 8 features,
aiming to predict two real valued responses.

Features are as follows:
1. Relative Compactness 2. Surface Area 3. Wall Area 4. Roof Area 5. Overall Height
6. Orientation 7. Glazing Area 8. Glazing Area Distribution 9. Heating Load 10. Cooling Load
From the above variables, we are considering Heating Load and Cooling Load as response variables.

Exploratory Data Analysis
As a first step, I calculated the correlation between these two response variables and other variables and, also studied the 
correlation among all the variables.

The correlation between two response variables (Heating Load and Cooling Load) was very high (i.e. 0.975).
Hence by studying one of the response variables, we can predict the value of other response variable.

Model Building with Multiple Linear Regression
Linear Regression was performed with the response variable as Heating Load and the rest of the
variables as predictors.

# Building the full model using lm() fuction
m1= lm(heating.load~relative.compactness+surface.area+wall.area+roof.area+
overall.height+factor(orientation)+
factor(glazing.area)+factor(glazing.area.distribution),data)
summary(m1)
The summary of full model shows that Roof Area does not have any relationship with the
response variable. It does not predict the value of response variable. The p-value of Orientation and Glazing Area Distribution
is also not significant. All other attributes have a significant p-value. Also, the R-squared value is very high. It is 91.62% which
implies that it fits the model data. To confirm my initial finding from the full model, I performed Stepwise Linear Regression.

Stepwise Regression
I have performed stepwise regression in the backward direction using step() function in R which is based on 
Akaike Information Criterion (AIC).
During each step the attribute with the highest AIC value is removed. The AIC of the model increases when the attribute with the
lowest p-value is removed.

Conclusion
Heating Load and Cooling Load depend on same variables because of high correlation. The variables
that plays an important part in predicting their values are Relative Compactness, Surface Area, Wall Area, 
Overall Height, and Glazing Area.
