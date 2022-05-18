
for i in *.fasta
do
    mafft --quiet $i > ${i%.fasta}.aligned.fasta
done




