# clear workspace, set seed, and set wd
#rm(list=ls())
#set.seed(19)
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

### Load Libraries
library(ergm)
library(ergm.count)


### Read in data
load("main_cov.Rdata")
load("main_net.Rdata")
load("main_network_results_RR.RData")
fits.dep <- ergms
load("main_independent_results_RR.RData")
fits.ind <- ergms

# Matrix to store results
BICMat <- matrix(0,length(fits.dep),2)

# Row labels for fit matrix

rowLabels <- c("02","03","04","05","06","07","08","09","10","11","12")
rownames(BICMat) <- rowLabels
colnames(BICMat) <- c("Independent","Network")

# Loop 
for(i in 1:length(fits.ind)){
	# Store results
	BICMat[i,1] <- BIC(fits.ind[[i]])
    BICMat[i,2] <- BIC(fits.dep[[i]])
}

pdf("figures/BICdiff.pdf",height=4,width=6.5)
par(las=1)
barplot(BICMat[,1]-BICMat[,2],ylab="BIC Difference (Ind-Net)",xlab="Year")
dev.off()



