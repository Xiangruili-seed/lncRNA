tissue=$1
sample=$2
data=/data/tusers/lixiangr/lncRNA/mouse/${tissue}/
url=https://www.encodeproject.org/files/${sample}/@@download/${sample}.bam
##########
mkdir -p ${data}
cd ${data}
wget ${url}
samtools sort -@ 6 -m 4G -O bam -o ${sample}.sorted.bam ${sample}.bam
samtools view -c ${sample}.sorted.bam >reads.txt
bamToBed -i ${sample}.sorted.bam|awk '$1!~/_/{print $0}'|sort -k1,1 -k2,2n  > sorted.merged.bed
cat sorted.merged.bed| awk '{print ($3-$2)+1}'>${tissue}.read_length.txt
bedtools closest -a  sorted.merged.bed -b /data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed -d -t "first" |awk '{print $11}' >${tissue}.read_distance.txt
bedtools closest -a  sorted.merged.bed -b /data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed -d -t "first" >${tissue}.close.txt
bedtools closest -a  sorted.merged.bed -b /data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed -d  >${tissue}.close_all.txt


