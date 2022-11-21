#!/bin/bash

cp ../1_Setup/system_mod.parm7 ./system.parm7
cp ../1_Setup/system.rst7 ./system.rst7

cat <<EOF > min.in
Minimisation of system
 &cntrl
  imin=1,        ! Perform an energy minimization.
  maxcyc=4000,   ! The maximum number of cycles of minimization.
  ncyc=2000,     ! The method will be switched from steepest descent to conjugate gradient after NCYC cycles.
 /
EOF

cat <<EOF > heat.in
Heating ramp from 0K to 298K
 &cntrl
  imin=0,                   ! Run molecular dynamics.
  ntx=1,                    ! Initial file contains coordinates, but no velocities.
  irest=0,                  ! Do not restart the simulation, (only read coordinates from the coordinates file)
  nstlim=15000,             ! Number of MD-steps to be performed.
  dt=0.002,                 ! Time step (ps)
  ntf=2, ntc=2,             ! Constrain lengths of bonds having hydrogen atoms (SHAKE)
  tempi=0.0, temp0=298.0,   ! Initial and final temperature
  ntpr=500, ntwx=500,       ! Output options
  cut=8.0,                  ! non-bond cut off
  ntb=1,                    ! Periodic conditiond at constant volume
  ntp=0,                    ! No pressure scaling
  ntt=3, gamma_ln=2.0,      ! Temperature scaling using Langevin dynamics with the collision frequency in gamma_ln (ps−1)
  ig=-1,                    ! seed for the pseudo-random number generator will be based on the current date and time.
  nmropt=1,                 ! NMR options to give the temperature ramp.
 /
&wt type='TEMP0', istep1=0, istep2=12000, value1=0.0, value2=298.0 /
&wt type='TEMP0', istep1=12001, istep2=15000, value1=298.0, value2=298.0 /
&wt type='END' /
EOF

cat <<EOF > equil.in
Density equilibration
&cntrl
  imin= 0,                       ! Run molecular dynamics.
  nstlim=30000,                  ! Number of MD-steps to be performed.
  dt=0.002,                      ! Time step (ps)
  irest=1,                       ! Restart the simulation and read coordinates and velocities from the restart file provided in -c
  ntx=5,                         ! Initial file contains coordinates and velocities.
  ntpr=500, ntwx=500, ntwr=500,  ! Output options
  cut=8.0,                       ! non-bond cut off
  temp0=298,                     ! Temperature
  ntt=3, gamma_ln=3.0,           ! Temperature scaling using Langevin dynamics with the collision frequency in gamma_ln (ps−1)
  ntb=2,                         ! Periodic conditiond at constant pressure
  ntc=2, ntf=2,                  ! Constrain lengths of bonds having hydrogen atoms (SHAKE)
  ntp=1, taup=2.0,               ! Pressure scaling
  iwrap=1, ioutfm=1,             ! Output trajectory options
/
EOF


cat << EOF > cpptraj.in
trajin equil.rst7
autoimage
trajout system.equil.rst7 inpcrd
go
quit
EOF


date
echo "Minimisation"
sander.OMP -O -i min.in -o min.out -p system.parm7 -c system.rst7 -r min.rst7 -x min.nc
date

echo "Thermalisation"
sander.OMP -O -i heat.in -o heat.out -p system.parm7 -c min.rst7 -r heat.rst7 -x heat.nc
date

echo "Pressure equilibration"
sander.OMP -O -i equil.in -o equil.out -p system.parm7 -c heat.rst7 -r equil.rst7 -x equil.nc
date

cpptraj -i cpptraj.in -p system.parm7
