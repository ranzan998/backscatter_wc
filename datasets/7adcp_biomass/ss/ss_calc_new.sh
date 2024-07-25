#!/bin/bash
cd /media/scilab/disk_ranjan/works/westcoast_adcp1/backscatternew/7adcp_biomass/graft_filled/

for file in *.nc
do
ferret -nojnl -nodisplay << eof
use $file
let ss =  biomass[z=22:118@din]/1000

save/file=ss_$file ss
plot ss
frame/file=${file::-3}.png/ypixel=2245

eof
mv ss_$file /media/scilab/disk_ranjan/works/westcoast_adcp1/backscatternew/7adcp_biomass/ss/
mv ${file::-3}.png /media/scilab/disk_ranjan/works/westcoast_adcp1/backscatternew/7adcp_biomass/ss/
done
cd /media/scilab/disk_ranjan/works/westcoast_adcp1/backscatternew/7adcp_biomass/ss/
for file in *.nc
do
mv $file ${file: 3}
done
