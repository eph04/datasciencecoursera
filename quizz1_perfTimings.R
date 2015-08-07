compare.mean <- function(x = 1) {  # time each pollutantmean version x times
  meanF <- function() {mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)}
  once.each <- function(y) {
    c(  # system.time()[[1]] is user time, aka cpu time
      Solution_1 = system.time(tapply(DT$pwgtp15,DT$SEX,mean))[[3]], 
      Solution_2 = system.time(meanF())[[3]], 
      Solution_3 = system.time(mean(DT$pwgtp15,by=DT$SEX))[[3]],
      Solution_5 = system.time(DT[,mean(pwgtp15),by=SEX])[[3]], 
      Solution_6 = system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))[[3]]
    )
  }
  sapply(1:x, once.each)  # sapply simplifies the list of 7-element vectors to a 7 by x matrix
}

times <- compare.mean(1000)
data.frame(Mean.CPU.Time = a <- rowMeans(times) )#, Compared.to.Solution.2 = a/a[2])


#meanF2 <- function() {rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]} #error
#system.time(meanF2())
