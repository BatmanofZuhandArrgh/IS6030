##I. Overview and EDA of the dataset
investment.df<-read.csv('/Users/MACOS/Downloads/investments_VC.csv')
#install.packages("gplots")
library(gplots)

#install packages
install.packages("RODBC")
library(RODBC)

#Establishing the connection
Local<-odbcConnect("Example", uid = "", pwd = "")

#Custom SQL Commands
investmentSQL.df<-sqlQuery(Local, "Select * from dbo.investment")

#View Data
View (investmentSQL.df)
View (investment.df)
t(t(names(investment.df)))

##############################################################
##II. Pre-processing the dataset

#a.Fixing the data type of total_funding_usd (Weird comma scheme)
#1. Pure R operation
#class(investment.df$funding_total_usd)
#TotalFunding <- rep(investment.df$funding_total_usd)
#class(TotalFunding) #=> factor
#install.packages("varhandle")
#library(varhandle)
#TotalFunding<-unfactor(TotalFunding)
#class(TotalFunding) #=> Character
#TotalFunding <-as.numeric(TotalFunding)
#class(TotalFunding) #=> Numeric
#Investment.df<- investment.df
#investment.df <- investment.df[, -c(1,3,6)]
#investment.df <- cbind(TotalFunding)

##############Note: At first I tried the previous code, it didn't work, therefore I will format the column in Excel, before importing it into R
#Deleting variables we won't have use with
class(investment.df$funding_total_usd)

#2. For SQL R Operation
investmentSQL.df<-sqlQuery(Local, "Select *, CAST(funding_total_usd as INT) as TotalFunding
                           from dbo.investment")
# I doubt this will work as well, and would still require preprocessing in Excel.

#b. For missing continuous data (Total Funding)
investment.df$funding_total_usd[is.na(investment.df$funding_total_usd)] <- median(investment.df$funding_total_usd, na.rm = TRUE)
#For SQL, do the same but with investmentSQL.df
investmentSQL.df$funding_total_usd[is.na(investmentSQL.df$funding_total_usd)] <- median(investmentSQL.df$funding_total_usd, na.rm = TRUE)

#c. Deleting all useless variables (URLs)
investment.df <- investment.df[, -c(1,3)]
investmentSQL.df <- investmentSQL.df[, -c(1,3)] #SQL function

#d. Deleting all useless variables (Rounds of funding)
#Since we will not be delving into this part, I will delete these 8 variables
investment.df <- investment.df[, -c(30:37)]
investmentSQL.df <- investmentSQL.df[, -c(30:37)] #SQL function

#e. Deleting all useless variables (Time)
#Since we will not be delving into this part, I will delete these 8 variables
investment.df <- investment.df[, -c(11:13,15,16)]
investmentSQL.df <- investmentSQL.df[, -c(11:13,15,16)] #SQL function

##############################################################
##III. EDA

#1. Counting the number of startups in each categories

investmentSQLCities.df<-sqlQuery(Local, "select city, count(name) as NumberofStartups
from dbo.investment
group by city
order by count(name) DESC
")

investmentSQLFundingRounds.df<-sqlQuery(Local, "select funding_rounds, count(name) as NumberofStartups
from dbo.investment
group by funding_rounds
order by count(name) DESC
")

investmentSQLRegions.df<-sqlQuery(Local, "select region, count(name) as NumberofStartups
from dbo.investment
group by region
order by count(name) DESC
")

investmentSQLStatus.df<-sqlQuery(Local, "select status, count(name) as NumberofStartups
from dbo.investment
group by status
order by count(name) DESC
")

investmentSQLMost.df<-sqlQuery(Local, "select top 10 name as MostFundedStartups, funding_total_usd as TotalFunding
from dbo.investment
order by funding_total_usd DESC
")

investmentSQLStatsFunding.df<-sqlQuery(Local, "select Max(funding_total_usd) as MaxFunding, Min(funding_total_usd) as MinFunding, AVG(funding_total_usd) as MeanFunding
from dbo.investment
")

#2. Graphs and Plots
hist(investment.df$funding_total_usd, xlab = "Total Funding", xlim = c(0,6000000000), ylim = c(0,100))

## IV. Analytics
#1. Creating the dummy variables for Status and Deleting all irrelevant data
investmentRegression.df<-investment.df[, -c(1:3,6:24)]
#Deleting all cells with no information
investmentRegression.df <- investmentRegression.df[!(investmentRegression.df$status==""), ]
# There's only 1314 out of 49438 observations were deleted. A loss of 2.7% is considered acceptable

#Creating dummy variables for "closed" status
dummiescol <- as.data.frame(model.matrix(~ 0 + status, data = investmentRegression.df))
t(t(names(dummiescol)))
dummiescol <- dummiescol[,-c(1,2,4)]
#Combine into a new table to do regression
investmentRegression.df<- cbind(investmentRegression.df,dummiescol)
investmentRegression.df <- investmentRegression.df[, -c(2) ]

#2. Partitioning the data
set.seed(1)
## partitioning into training (60%) and validation (40%) 
# randomly sample 60% of the row IDs for training; the remaining 40% serve as
# validation
train.rows <- sample(rownames(investmentRegression.df), nrow(investmentRegression.df)*0.6)
# collect all the columns with training row ID into training set:
train.data <- investmentRegression.df[train.rows, ]
# assign row IDs that are not already in the training set into validation
valid.rows <- setdiff(rownames(investmentRegression.df), train.rows)
valid.data <- investmentRegression.df[valid.rows, ]
t(t(names(investmentRegression.df)))

#3. Running Logistic Regression on these variables
# create the full linear model
logit.reg <- glm(dummiescol ~ funding_total_usd, data = train.data, family = "binomial")
options(scipen = 999)
summary(logit.reg)

#4. Model Fiting
# use predict() with type = "response" to compute predicted probabilities
logit.reg.pred <- predict(logit.reg, valid.data, type = "response")

data.frame(actual = valid.data$dummiescol[1:30], predicted = logit.reg.pred[1:30])

#5. Confusion matrix
library(caret)
confusionMatrix(as.factor(ifelse(logit.reg.pred >= 0.05, "1", "0")), as.factor(valid.data$dummiescol), 
                positive = "1")

#6. Performance Evaluation
# roc curve
library(pROC)
r <- roc(valid.data$dummiescol, logit.reg.pred)
plot.roc(r)
auc(r)

# creating lift charts and decile lift charts
library(gains)
gain <- gains(valid.data$dummiescol, logit.reg.pred, groups = length(logit.reg.pred))
gain

# plot lift chart
plot(c(0, gain$cume.pct.of.total * sum(valid.data$dummiescol)) ~ c(0, gain$cume.obs),
     xlab = "# of cases", ylab = "Cumulative", main = "Lift Chart", type = "l")
lines(c(0, sum(valid.data$dummiescol)) ~ c(0, nrow(valid.data)), lty = 2)






odbcCloseAll()
