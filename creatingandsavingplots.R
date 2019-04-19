#PACKAGES NEEDED
library(readxl)
library(ggplot2)
library(reshape2)
library(RColorBrewer)
library(zoo)
library(dplyr)
library(openxlsx)
library(zoo)
######################################################################
#READ THE DATA
P1 <- read_excel("App/Analysis of time spent in the app.xlsx",sheet = "Sheet2", range = "A2:K13")


#ADD NAME TO FIRST COLUMN, IS EMPTY
names(P1)[1]="reference"
#change class to factor, to keep the order on the plot
P1$reference=factor(P1$reference,levels=P1$reference)

#reshape data to plot
P1R <- melt(P1, id.vars = "reference")


#ploting

#basic plot
ggplot(P1R,aes(x=reference,y=value,fill=variable))+geom_bar(stat = "identity")+
#main title
ggtitle("Total Time Spent Weekly in The Intervention components")+
# labs x and y  
labs(y="Total Time (in minutes)", x = "Intervention Components/Total Time")+
#90 degrees for x
theme(axis.text.x = element_text(angle = 90, hjust = 1))+
#background
theme(panel.background = element_blank(), panel.grid.major.y = element_line( size=.1, color="grey" ),legend.title = element_blank()  )+
#ylims
coord_cartesian(ylim=c(0,160))+
#choosecolors
scale_fill_brewer(palette="Paired")

dev.copy(png,'plot1.png')
dev.off()
#####################################################################################

P2 <- read_excel("App/Analysis of time spent in the app.xlsx",sheet = "Sheet3", range = "A1:AE12")
names(P2)[1]="reference"
P2$reference=factor(P2$reference,levels=P2$reference)

#reshape data to plot
P2R <- melt(P2, id.vars = "reference")

#ploting
#basic plot
ggplot(P2R,aes(x=variable,y=value,fill=reference))+geom_bar(stat = "identity")+
  #main title
  ggtitle("Total Time Spent in Each Intervention Components Each Participants")+
  # labs x and y  
  labs(y="Time (in minutes)", x = "Participants/Total Time")+
  #background
  theme(panel.background = element_blank(), panel.grid.major.x = element_line( size=.1, color="grey" ),legend.title = element_blank() )+
  scale_y_continuous(limits = c(0, 50))+
  #choosecolors
  scale_fill_brewer(palette="Paired")+
  #rotate barplot
  coord_flip()

dev.copy(png,'plot2.png')
dev.off()

######################################################
#READ THE DATA
P3 <- read_excel("App/Analysis of time spent in the app.xlsx",sheet = "Sheet1", range = "A2:K32")
#ADD NAME TO FIRST COLUMN, IS EMPTY
names(P3)[1]="reference"
P3$reference=factor(P3$reference,levels=P3$reference)
#reshape data to plot
P3R <- melt(P3, id.vars = "reference")

#ploting
#basic plot
ggplot(P3R,aes(x=reference,y=value,fill=variable))+geom_bar(stat = "identity")+
  #main title
  ggtitle("Total Time Spent Weekly in the Mobile Intervention by Each Participants")+
  # labs x and y  
  labs(y="Time (in minutes)", x = "Participants/Total Time")+
  #background
  theme(panel.background = element_blank(), panel.grid.major.x = element_line( size=.1, color="grey" ),legend.title = element_blank() )+
  scale_y_continuous(limits = c(0, 50))+
  #choosecolors
  scale_fill_brewer(palette="Paired")+
  #rotate barplot
  coord_flip()
############################################################

#READ THE DATA
P4 <- read_excel("App/Analysis of time spent in the app.xlsx",sheet = "Sheet5", range = "A1:C26")
#ADD NAME TO FIRST COLUMN, IS EMPTY
names(P4)[1]="reference"

#fix problem reading dates from excel
P4=P4%>% do(na.locf(.))
x=convertToDate(P4$Date)
x=format(x, format="%b-%d")
P4$Date[!is.na(x)]=x[!is.na(x)]

###############################################################
P5 <- read_excel("App/Analysis of time spent in the app.xlsx",sheet = "Sheet5", range = "A27:C51",col_names = FALSE)
P5=P5%>% do(na.locf(.))
names(P5)=names(P4)
x=convertToDate(P5$Date)
x=format(x, format="%b-%d")
P5$Date[!is.na(x)]=x[!is.na(x)]
