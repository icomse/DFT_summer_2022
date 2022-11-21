#!/bin/bash

# Author: Woodrow N. Wilson
# Date: June 22th, 2022
# Notes: Installs CP2K on either MacOS or Linux
#        Assumes apt-get is on Linux and Homebrew is on Mac
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine}

if [ $machine = Linux ]; then
	echo "Running Installation for a ${machine} OS"

	sudo apt-get update && sudo apt-get upgrade -y
	sudo apt-get install gcc gfortran g++ -y
	sudo apt-get install zsh  tcsh make cmake flex bison patch bc xorg-dev libbz2-dev wget -y
	sudo apt-get install openmpi-bin libopenmpi-dev openssh-client libomp-dev -y
	sudo apt-get install libblas-dev liblapack-dev -y
	sudo apt-get install libreadline-dev -y

	cd ~

	mkdir -p Programs/cp2k
	cd ~/Programs/cp2k
	git clone --recursive -b support/v9.1 https://github.com/cp2k/cp2k.git 9.1

    cd 9.1/arch
	mkdir original
	mv * original

	CFLAGS="-O3 -fopenmp -fopenmp-simd -ftree-vectorize -funroll-loops -g -march=native -mtune=native"

	cat << EOF > Linux-x86-64-gfortran.ssmp
CC          = gcc
FC          = gfortran
LD          = gfortran
AR          = ar -r
CFLAGS      = $CFLAGS
FCFLAGS     = $CFLAGS
FCFLAGS    += -fbacktrace
FCFLAGS    += -ffree-form
FCFLAGS    += -ffree-line-length-none
FCFLAGS    += -fno-omit-frame-pointer
FCFLAGS    += -std=f2008
LDFLAGS     = $CFLAGS
LIBS       = -llapack -lblas -ldl -lstdc++
EOF

	cd ..

	make -j$(nproc) ARCH=Linux-x86-64-gfortran VERSION=ssmp
    installdir=$(pwd)/exe/Linux-x86-64-gfortran
    echo "Success! Add the following directory to your PATH variable"
    echo $installdir
fi

if [ $machine = Mac ]; then
	echo "Running Installation for a ${machine} OS"

	brew update && brew upgrade
    brew install gcc
    brew install libomp

	cd ~
	mkdir -p Programs/cp2k
	cd ~/Programs/cp2k
	git clone --recursive -b support/v9.1 https://github.com/cp2k/cp2k.git 9.1

	cd 9.1/arch
	mkdir original
	mv * original

	CFLAGS="-O3 -fopenmp -g"
    DFLAGS="-D__NO_STATM_ACCESS -D__ACCELERATE"
	FCFLAGS="-fopenmp -funroll-loops -ftree-vectorize -ffree-form -O3 -g"
    cat << EOF > Darwin-gfortran.ssmp
CC       = gcc-11
FC       = gfortran
LD       = gfortran
AR       = ar -r
RANLIB   = ranlib
CFLAGS   = -O3 -fopenmp -g
DFLAGS   = $DFLAGS
FCFLAGS  = $FCFLAGS $DFLAGS
LDFLAGS  = $FCFLAGS $DFLAGS
LIBS     = -framework Accelerate
EOF

	cd ..

	make -j$(nproc) ARCH=Darwin-gfortran VERSION=ssmp
    installdir=$(pwd)/exe/Darwin-gfortran
    echo "Success! Add the following directory to your PATH variable"
    echo $installdir
fi

