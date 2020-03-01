#Install packages
install.packages("RODBC")
install.packages("sqldf")
install.packages ("ggplot2")

#http://www.burns-stat.com/translating-r-sql-basics/

library(sqldf)
library(RODBC)
library(ggplot2)


print(Films)
colnames(Films)

#Create connection - Note if you leave uid and pwd blank it works with your existing Windows credentials
Local <- odbcConnect("Example", uid = "", pwd = "")


#Selecting columns With sqldf
subFilmSQL <- sqldf("SELECT FilmName
                           ,FilmReleaseDate
                           ,FilmOscarNominations
                           ,FilmOscarWins
                           ,FilmBudgetDollars
                           ,FilmBoxOfficeDollars
                     FROM Films
                       ")

head(subFilmSQL)
str(subFilmSQL)
class(subFilmSQL)

#With R commands
subFilmR <- Films[, c("FilmName"
                      ,"FilmReleaseDate"
                      ,"FilmOscarNominations"
                      ,"FilmOscarWins"
                      ,"FilmBudgetDollars"
                      ,"FilmBoxOfficeDollars")]
head (subFilmR)
str(subFilmR)
colnames(subFilmR )
class(subFilmR)


#Are they equivalent?  Yes.
all.equal(subFilmSQL,subFilmR)



# Plotting

qplot(subFilmSQL$FilmBudgetDollars, data=subFilmSQL,geom="histogram")


#Best practice - don't leave the connection open and ensures you get the latest data
odbcCloseAll()

