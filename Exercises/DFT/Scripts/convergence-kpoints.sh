#!/bin/bash

# Author: Woodrow N. Wilson
# Date: 6/11/22
# Notes: Converges MP K-Point Grid

kpoints=(1 2 3 4 5 6 7)

cp2k_bin=cp2k.ssmp

template_file=cp2k.inp
input_file=cp2k.inp
output_file=cp2k.out


### SIMULATION
echo "Start: $(date)"

if [ -d simulation ]; then
    rm -r simulation
fi

for k in ${kpoints[@]}; do
    echo "MP K-point Grid Density: $k x $k x $k"
    mkdir -p simulation/$k
    sed "s/MONKHORST-PACK 1 1 1/MONKHORST-PACK $k $k $k/g" $template_file > simulation/$k/$input_file
    cd simulation/$k
    $cp2k_bin -i $input_file -o $output_file
    cd ../..

done
echo "End: $(date)"


### ANALYSIS
plot_file=kpoint_analysis.csv
echo "MP x, MP y, MP z, Energy (Ha)" > $plot_file
for k in ${kpoints[@]}; do
    E=$(grep ENERGY simulation/$k/$output_file | tail -1 | awk '{print $9}')
    echo "$k, $k, $k, $E" >> $plot_file
done


