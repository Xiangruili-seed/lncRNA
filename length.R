library(ggplot2)
library(ggpubr)
c2c12<-read.table("/data/tusers/lixiangr/lncRNA/mouse/C2C12/C2C12.read_length.txt")
cortex<-read.table("/data/tusers/lixiangr/lncRNA/mouse/cortex/cortex.read_length.txt")
forelimb_11<-read.table("/data/tusers/lixiangr/lncRNA/mouse/forelimb_11/forelimb_11.read_length.txt")
forelimb_13<-read.table("/data/tusers/lixiangr/lncRNA/mouse/forelimb_13/forelimb_13.read_length.txt")
hippocampus<-read.table("/data/tusers/lixiangr/lncRNA/mouse/hippocampus/hippocampus.read_length.txt")

colnames(c2c12)<-c("c2c12")
colnames(cortex)<-c("cortex")
colnames(forelimb_11)<-c("forelimb_11")
colnames(forelimb_13)<-c("forelimb_13")
colnames(hippocampus)<-c("hippocampus")
breaks1 <- pretty(range(c2c12$c2c12), n = nclass.FD(c2c12$c2c12), min.n = 1)
bwidth1 <- breaks1[2]-breaks1[1]
p1<-ggplot(c2c12,aes(c2c12))+
  geom_histogram(binwidth =bwidth1,fill="steelblue")+xlim(0,mean(c2c12$c2c12, na.rm = FALSE))+ #背景变为白色
  theme(axis.text.x=element_text(angle=15,hjust = 1,colour="black",family="Times",size=10))
breaks2 <- pretty(range(cortex$cortex), n = nclass.FD(cortex$cortex), min.n = 1)
bwidth2 <- breaks2[2]-breaks2[1]
p2<-ggplot(cortex,aes(cortex))+
  geom_histogram(binwidth =bwidth2,fill="#FB882C")+xlim(0,mean(cortex$cortex, na.rm = FALSE))+ #背景变为白色
  theme(axis.text.x=element_text(angle=15,hjust = 1,colour="black",family="Times",size=10))
breaks3 <- pretty(range(forelimb_11$forelimb_11), n = nclass.FD(forelimb_11$forelimb_11), min.n = 1)
bwidth3 <- breaks3[2]-breaks3[1]
p3<-ggplot(forelimb_11,aes(forelimb_11))+
  geom_histogram(binwidth =bwidth3,fill="#90EE90")+xlim(0,mean(forelimb_11$forelimb_11, na.rm = FALSE))+ #背景变为白色
  theme(axis.text.x=element_text(angle=15,hjust = 1,colour="black",family="Times",size=10))
breaks4 <- pretty(range(forelimb_13$forelimb_13), n = nclass.FD(forelimb_13$forelimb_13), min.n = 1)
bwidth4 <- breaks4[2]-breaks4[1]
p4<-ggplot(forelimb_13,aes(forelimb_13))+
  geom_histogram(binwidth =bwidth4,fill="#EE2C2C")+xlim(0,mean(forelimb_13$forelimb_13, na.rm = FALSE))+ #背景变为白色
  theme(axis.text.x=element_text(angle=15,hjust = 1,colour="black",family="Times",size=10))

breaks5 <- pretty(range(hippocampus$hippocampus), n = nclass.FD(hippocampus$hippocampus), min.n = 1)
bwidth5 <- breaks5[2]-breaks5[1]
p5<-ggplot(hippocampus,aes(hippocampus))+
  geom_histogram(binwidth =bwidth5,fill="#AB82FF")+xlim(0,mean(hippocampus$hippocampus, na.rm = FALSE))+ #背景变为白色
  theme(axis.text.x=element_text(angle=15,hjust = 1,colour="black",family="Times",size=10))
p6 <- ggarrange(p1, p2, p3, p4, p5,nrow = 2, ncol = 3, labels = c('A', 'B', 'C', 'D','E'), font.label = list(color = 'black'))
pdf("/data/tusers/lixiangr/lncRNA/mouse/read_length.pdf")
annotate_figure(p6, bottom=text_grob("Histogram of reads length", color = "black", size = 18))
dev.off()
