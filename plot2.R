######### Exploratory Data Analysis - Assignment 1
#2
#this script:
#creates a temporary working dir "temp_2" where to download the data
#downloads, unzip and reads the data
#create plot 2 required by the assigned and
#saves it as a png file in temp_2

#create a directory where to download the assgnment material
dir.create("temp_2")
setwd("temp_2")

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "data.zip")
#unzip 
unzip("data.zip")


#read data - it takes a while
x<- read.table(file = "household_power_consumption.txt", head = TRUE, sep=";", na.strings = "?")
#cancell na
x<-na.omit(x)
#str(x)#2049280 obs. of  9 variables

#set local to US (to have defoult week days in English)
Sys.setlocale("LC_TIME", "en_US.UTF-8")


#create a new variable summarizing date and time in a useful format
x$newdate<-strptime(paste(x$Date,x$Time), format = "%d/%m/%Y %H:%M:%S")

#We will only be using data from the dates 
#2007-02-01 and 2007-02-02

#change class to Date col, it makes easier to extract only the days that we need
x$Date<-as.Date(x$Date,"%d/%m/%Y")
#extract data of days we are interested in
x1<-subset(x, x$Date>=as.Date("2007-02-01") & x$Date<= as.Date("2007-02-02"))
#str(x1)#2880 obs. of  9 variables

#plot
png("plot2.png", width = 480, height = 480)

plot(x1$newdate, x1$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab="" )

dev.off()
