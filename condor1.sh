
#inspired from SCARLET

if [ "$#" -le 3 ]; then
    echo """
    
    usage: condor.py [-h] [-i I] [-r R] [-v V] [-s S] [-a A] [-b B] [--ado ADO] [-k K] -o O [-t T]

optional arguments:
  -h, --help  show this help message and exit
  -i I        csv file with mutation matrix and cluster id
  -r R        csv file with total read count matrix
  -v V        csv file with variant read count matrix
  -s S        file containing list of SNPs
  -a A        false positive error rate [0.001]
  -b B        false negative error rate [0.001]
  --ado ADO   precision parameter for ADO
  -k K        maximum number of losses for an SNV
  -o O        output prefix
  -t T        time limit in seconds [1800]
    
    """
    exit 1
fi


character_matrix=$1
read_count=$2
variant_count=$3
output_prefix=$4


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#python $DIR/scarlet.py $readcount_file $cntree_file $output_prefix

python $DIR/src/condor.py -i  $character_matrix -a 0.0018 -b 0.001 -k 1 -r $read_count -v $variant_count -o $output_prefix

#python $DIR/plot_tree.py ${output_prefix}.B_ancestor $cntree_file $plotting_style $output_prefix 

dot -Tpdf ${output_prefix}_tree.dot -o ${output_prefix}_tree.pdf -v
dot -Tpdf ${output_prefix}_tree_without_cells.dot -o ${output_prefix}_tree_without_cells.pdf -v



#inspired from SCARLET
#bash code/scarlet.sh example/read_counts.csv example/tree.csv example/output ALL

#bash condor.sh data/sample/overview_character_matrix.csv data/sample/overview_read_count.csv data/sample/overview_variant_count.csv data/output