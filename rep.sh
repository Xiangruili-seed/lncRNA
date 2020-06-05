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
bamToBed -i sorted.merged.bam|awk '$1!~/_/{print $0}'|sort -k1,1 -k2,2n  > sorted.bed
wc -l sorted.bed> reads.txt
cat sorted.bed| awk '{print ($3-$2)+1"\t"}'>${tissue}.read_length.txt
cat sorted.bed|awk '{if ($6=="+") print $1"\t"$2"\t"$2+1"\t.\t.\t"$6; else if ($6=="-") print $1"\t"$3-1"\t"$3"\t.\t.\t"$6}'|sort -k1,1 -k2,2n -u >sorted.merged.bed

bedtools closest -a  sorted.merged.bed -b /data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed -d -s |awk '{print $9}' >${tissue}.read_distance.txt
bedtools closest -a  sorted.merged.bed -b /data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed -d  -s >${tissue}.close_all.txt
