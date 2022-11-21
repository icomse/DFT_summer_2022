#!/bin/bash

# Author: Woodrow N. Wilson
# Date: 6/11/22
# Notes: Converges BASIS SET

basis=(SZV-GTH-PADE DZVP-GTH-PADE DZVP-GTH-PADE-CONFINED)

cp2k_bin=cp2k.ssmp

template_file=cp2k.inp
input_file=cp2k.inp
output_file=cp2k.out


### SIMULATION
echo "Start: $(date)"

if [ -d simulation ]; then
    rm -r simulation
fi

for b in ${basis[@]}; do
    echo "GTO Basis Set: $b"
    mkdir -p simulation/$b
    sed "s/BBBBB/$b/g" $template_file > simulation/$b/$input_file
    cd simulation/$b
    $cp2k_bin -i $input_file -o $output_file
    cd ../..

done
echo "End: $(date)"


### ANALYSIS
plot_file=basis-set_analysis.csv
echo "Basis Set, Energy (Ha)" > $plot_file
for b in ${basis[@]}; do
    E=$(grep ENERGY simulation/$b/$output_file | tail -1 | awk '{print $9}')
    echo "$b, $E" >> $plot_file
done


