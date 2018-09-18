data1 = c(0.018, 0.012, 0.018, 0.016, 0, 0.009, 0.008, 0.009, 0.014);
data2 = c(0.00700000000000000, 0, 0.0100000000000000, 0.00500000000000000, 0.00200000000000000, 0.00200000000000000, 0.0200000000000000, 0.0130000000000000, 0.0150000000000000, 0.00300000000000000, 0.00800000000000000, 0.00800000000000000, 0.00400000000000000, 0, 0.00800000000000000, 0.00400000000000000, 0.00400000000000000, 0.004);


png(
  "Mbs_vs_WT_FourfoldVertices_18_09_2018.png",
  width     = 2.5,
  height    = 4,
  units     = "in",
  res       = 500,
  pointsize = 4
)
options <- par(
  mar      = c(5, 10, 1, 1),
  mgp      = c(7, 2.5, 0),
  cex.axis = 3.3,
  cex.lab  = 3.5,
  font.lab = 2
)
#par(options)
x <- boxplot(list(WT = data2, "Mbs-RNAi" = data1), names = c("WT", expression(italic("Mbs-RNAi")) ), ylim = c(-0.0005, 0.023), ylab = "Fourfold vertices per Cell", boxwex=0.25)
stripchart(list(WT = data2, "Mbs-RNAi" = data1), vertical = TRUE,
           method = "jitter", add = TRUE, pch=16, ps= 20, col = 'blue')
meanData <- c(mean(data2), mean(data1))

segments(c(0.88, 1.88),
         meanData,
         c(1.12, 2.12),
         meanData,
         col = c('black', 'black'),
         lty = 2);

par(xpd=TRUE)
yrange<-par("usr")[3:4]
ypos<-yrange[2]-diff(yrange)/15
segments(1,ypos,2,ypos)
text(1.5,ypos+diff(yrange)/40,"*",cex=4)
par(xpd=FALSE)

dev.off()


data1 = c(0.054096638, 0.150826754, 0.066666667, 0.127272727, 0.241666667);
data2 = c(0.016025641, 0, 0, 0.02173913, 0);

png(
  "Mbs_vs_WT_T1_Transitions_18_09_2018.png",
  width     = 3.25,
  height    = 3.25,
  units     = "in",
  res       = 500,
  pointsize = 4
)
par(options)

boxplot(list(WT = data1, "Mbs-RNAi" = data2), ylim = c(-0.005, 0.28), ylab = 'Intercalation rate (T1s/Cell/Hour)');
stripchart(list(WT = data1, "Mbs-RNAi" = data2), vertical = TRUE, 
           method = "jitter", add = TRUE, pch=16, col = 'blue')

par(xpd=TRUE)
yrange<-par("usr")[3:4]
ypos<-yrange[2]-diff(yrange)/15
segments(1,ypos,2,ypos)
text(1.5,ypos+diff(yrange)/40,"**",cex=2)
par(xpd=FALSE)

dev.off()