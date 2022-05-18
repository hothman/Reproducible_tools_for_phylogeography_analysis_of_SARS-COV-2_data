
for i in *.nwk
do
pastml --tree $i --data country_v1.csv --columns country --threads 10 --html_compressed ${i%.nwk}.html --html ${i%.fasta}.tree.mppa.html  --itol_tree_name ${i%.fasta}_itol
done


