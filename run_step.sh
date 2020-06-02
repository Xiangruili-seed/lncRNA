####step1
###remove chr*_random and chrUn_* in gtf

cat /data/tusers/lixiangr/lncRNA/mouse/ref/gencode.vM21.primary_assembly.annotation_UCSC_names.gtf|awk '{if ($3=="gene") print $0}'|awk '{if ($7=="+") print $1"\t"$4-500"\t"$4+500"\t"$7; else if ($7=="-") print $1"\t"$5-500"\t"$5+500"\t"$7}'|awk '{if ($2<0) print $1"\t"0"\t"$3"\t"$4; else print $0}'|awk '$1!~/_/{print $0}' |sort -k1,1 -k2,2n -u >/data/tusers/lixiangr/lncRNA/mouse/ref/sorted_gene.bed

############step2 download bam and get reads length, reads distance
nohup bash /data/tusers/lixiangr/lncRNA/mouse/un.sh forelimb_13 ENCFF062GDW &
nohup bash /data/tusers/lixiangr/lncRNA/mouse/un.sh forelimb_11 ENCFF518UCU &
nohup bash /data/tusers/lixiangr/lncRNA/mouse/rep.sh hippocampus ENCFF623FYU ENCFF817KLD &
nohup bash /data/tusers/lixiangr/lncRNA/mouse/rep.sh cortex ENCFF050KJW ENCFF296JQE &
nohup bash /data/tusers/lixiangr/lncRNA/mouse/rep.sh C2C12 ENCFF116XKI ENCFF200LKU &

############step3 Rcodes for Histogram
 nohup Rscript dis.R &
 nohup Rscript length.R &



