#!/bin/bash
cd /media/scilab/disk_ranjan/works/westcoast_adcp1/backscatternew/6bs/bs/fer_regrid/merged/

for file in *.nc
do
ferret -nojnl << eof
use $file
define axis/t="03-OCT-2017":"17-DEC-2023 23:00":1/unit=hours TIME

let u1=u[gt=TIME@nrst]
let v1=v[gt=TIME@nrst]
let bs=bs1[gt=TIME@nrst]
let biomass1 = biomass[gt=TIME@nrst] 

save/file=reg_$file u1,v1,bs,biomass1
eof
mv reg_$file /media/scilab/disk_ranjan/works/westcoast_adcp1/backscatternew/7adcp_biomass/
done

cd /media/scilab/disk_ranjan/works/westcoast_adcp1/backscatternew/7adcp_biomass/
for file in *.nc
do
mv $file ${file:4}
done
