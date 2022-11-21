#!/bin/bash

# Author: Woodrow N. Wilson
# Date: 6/7/22
# Notes: Performs a manual cell optimization for a
# Primitive FCC Unit Cell

standard_length=2.94954603

lengths=($standard_length 2.7 2.8 2.9 3.0 3.1 3.2 )

cp2k_bin=cp2k.ssmp

template_file=cp2k.inp
input_file=cp2k.inp
output_file=cp2k.out


if [ -d simulation ]; then
    rm -r simulation
fi

echo "Start: $(date)"
for l in ${lengths[@]}; do
    echo "SPE with Lattice Length: $l Angstrom"
    mkdir -p simulation/$l
    sed "s/$standard_length/$l/g" $template_file > simulation/$l/$input_file
    cd simulation/$l
    $cp2k_bin -i $input_file -o $output_file
    cd ../..
done
echo "End: $(date)"

plot_file=lattice_analysis.csv
echo "Length (Angstrom), Energy (Ha)" > $plot_file
for l in ${lengths[@]}; do
    E=$(grep "ENERGY" simulation/$l/$output_file | tail -1 | awk '{print $9}')
    echo $l , $E >> $plot_file
done

