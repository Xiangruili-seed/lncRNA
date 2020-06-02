tissue=$1
sample=$2
sample2=$3
data=/data/tusers/lixiangr/lncRNA/mouse/${tissue}/
url=https://www.encodeproject.org/files/${sample}/@@download/${sample}.bam
url2=https://www.encodeproject.org/files/${sample2}/@@download/${sample2}.bam
##########
mkdir -p ${data}
cd ${data}
wget ${url}
wget ${url2}

samtools sort -@ 6 -m 4G -O bam -o ${sample}.sorted.bam ${sample}.bam
samtools sort -@ 6 -m 4G -O bam -o ${sample2}.sorted.bam ${sample2}.bam
samtools merge -@ 6 -c sorted.merged.bam *.sorted.bam
bamToBed -i sorted.merged.bam|awk '$1!~/_/{print $0}'|sort -k1,1 -k2,2n > sorted.merged.bed
wc -l sorted.merged.bed >reads.txt

cat sorted.merged.bed| awk '{print ($3-$2)+1"\t"}'>${tissue}.read_length.txt
bedtools closest -a  sorted.merged.bed -b /data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed -d -t "first" |awk '{print $11}' >${tissue}.read_distance.txt
bedtools closest -a  sorted.merged.bed -b /data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed -d  >${tissue}.close_all.txt
bedtools closest -a  sorted.merged.bed -b /data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed -d -t "first" >${tissue}.close.txt
