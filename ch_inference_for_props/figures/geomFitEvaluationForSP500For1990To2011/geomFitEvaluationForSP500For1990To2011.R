library(openintro)
data(COL)
library(stockPortfolio)
gr <- getReturns("^GSPC",
                 freq = "d",
                 start = "1990-01-01",
                 end = "2011-12-31")
R  <- ifelse(gr$R[gr$R != 0] > 0, 1, 0)
CC <- table(diff(which(R == 1)))
CC[names(CC) == 7] <- sum(CC[names(CC) %in% 7:9])
CC <- CC[- which(names(CC) %in% 8:9)]
p  <- mean(R)
pr <- p * (1 - p)^(0:5)
pr <- append(pr, 1 - sum(pr))

CC <- c(CC)
C  <- rep(1:7, CC)
EE <- round(pr * sum(CC))
E  <- rep(1:7, EE)

myPDF('geomFitEvaluationForSP500For1990To2011.pdf', 7, 3.5,
      mar = c(3.2, 4.2, 0.2, 1),
      mgp = c(2.1, 0.7, 0))
histPlot(C - 0.13,
         breaks = seq(0, 8, 0.25),
         xlim = c(0.5, 7.5),
         ylim = c(0, 1600),
         xlab = 'Wait until positive day',
         ylab = '',
         axes = FALSE,
         col = COL[1])
histPlot(E + 0.13,
         breaks = seq(0, 8, 0.25),
         add = TRUE,
         col = COL[3])
axis(1, 1:7, c(1:6, "7+"))
axis(2, at = seq(0, 1200, 400))
par(las = 0)
mtext('Frequency', 2, line = 3)
legend('topright',
       fill = COL[c(1, 3)],
       legend = c('Observed', 'Expected'))
dev.off()
