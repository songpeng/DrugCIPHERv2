# Scatter Plot by gglot2.
# Songpeng Zu
# 2015-04-20

#--Load Package
require(ggplot2)

#-- Load Data
dt <- read.table(file=filenm,header=FALSE,sep="\t",quote="",
                     colClasses="numeric")

scatterPlot <- function(dt,param){
    #colnames(dt) <- c("Protein-basedSimilarity","Chemical Similarity")
    colnames(dt) <- c("X","Y")
    p <- ggplot(dt,aes(X,Y))
    p + geom_point(alpha = param)
}
