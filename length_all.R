library(ggplot2)
library(ggpubr)
library (plotrix)
library(grid)
c2c12<-read.table("/data/tusers/lixiangr/lncRNA/mouse/C2C12/C2C12.read_length.txt")
cortex<-read.table("/data/tusers/lixiangr/lncRNA/mouse/cortex/cortex.read_length.txt")
forelimb_11<-read.table("/data/tusers/lixiangr/lncRNA/mouse/forelimb_11/forelimb_11.read_length.txt")
forelimb_13<-read.table("/data/tusers/lixiangr/lncRNA/mouse/forelimb_13/forelimb_13.read_length.txt")
hippocampus<-read.table("/data/tusers/lixiangr/lncRNA/mouse/hippocampus/hippocampus.read_length.txt")


for (q in c("c2c12","cortex","forelimb_11","forelimb_13","hippocampus")){
#x<-read.table("/data/tusers/lixiangr/lncRNA/mouse/",x"/",x".read_length.txt")

x<-as.data.frame(get(q))
colnames(x)<-c("reads_length")
breaks1 <- pretty(range(x$reads_length), n = nclass.FD(x$reads_length), min.n = 1)
bwidth1 <- breaks1[2]-breaks1[1]
p1<-ggplot(x,aes(reads_length))+geom_histogram(binwidth =bwidth1,fill="steelblue")+theme(axis.text.x=element_text(angle=15,hjust = 1,colour="black",family="Times",size=10), plot.background=element_rect(I(0),linetype=0),panel.background=element_rect(I(0)),panel.grid.major=element_line(colour=NA),axis.line = element_line(size=0.5, colour = 'black'),panel.grid.minor=element_line(colour=NA),plot.title = element_text(hjust = 0.5,size = 20))+labs(title=paste("All reads length of ",q,sep=""))
p1_mean<-ggplot(x,aes(reads_length))+geom_histogram(binwidth =bwidth1,fill="steelblue")+theme(axis.text.x=element_text(angle=15,hjust = 1,colour="black",family="Times",size=10), plot.background=element_rect(I(0),linetype=0),panel.background=element_rect(I(0)),panel.grid.major=element_line(colour=NA),axis.line = element_line(size=0.5, colour = 'black'),panel.grid.minor=element_line(colour=NA),plot.title = element_text(hjust = 0.5,size = 10))+labs(title=paste("Reads length of ",q," within\nthe scope of mean value",sep=""))+xlim(0,mean(x$reads_length, na.rm = FALSE))

vp <- viewport(width = 0.5, height = 0.5, x=0.9, y=0.9,just=c("right","top"))


pdf(paste("/data/tusers/lixiangr/lncRNA/mouse/",q,"_read_length.pdf",sep=""))
print(p1)
print(p1_mean,vp=vp)

#p(c2c12)
#p(cortex)
#p(forelimb_11)
#p(forelimb_13)
#p(hippocampus)
dev.off()


}
