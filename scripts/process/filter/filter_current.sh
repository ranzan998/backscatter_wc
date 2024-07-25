#!bin/bash
for file in *.nc
do
ferret -nojnl -nodisplay << eof
use $file
let bmd2 = U1[l=1:54408:24@ave]

LET allowed_gap1 = 14      !gap for time axis
LET gap_size1 = bmd2[l=@cia] + bmd2[l=@cib]
LET gap_mask1 = IF gap_size1 LE allowed_gap1 THEN 1
LET bmd1 = bmd2[l=@fln] * gap_mask1
let bmd = bmd1[k=1:51] - bmd1[l=@ave,k=1:51]

let intsn = lanczos(bmd,1/90,1/30,181) !intra seasonal

let intan = lanczos(bmd,1/250,1/100,351) !intra (semi) annual

let annual = lanczos(bmd,1/400,1/300,551) !annual

let subann = lsl_lowpass(bmd,500,551)  !sub annual

let ls300 = lsl_lowpass(bmd,300,451)
let ls400 = lsl_lowpass(bmd,400,451)
let annual_lsl = ls300 - ls400

set win/aspect=0.65 1
set view ul
fill/lev=(-inf)(-50,50,5)(inf)/pal=rnb2/vlims=20:140:-10 bmd
set view ur
fill/lev=(-inf)(-20,20,2)(inf)/pal=rnb2/vlims=20:140:-10 intsn

set view ll
fill/lev=(-inf)(-10,10,1)(inf)/pal=rnb2/vlims=20:140:-10 intan
set view lr
fill/lev=(-inf)(-10,10,1)(inf)/pal=rnb2/vlims=20:140:-10 subann
frame/file=${file::-3}_variability.png/ypixel=2245

set win/aspect=0.65 2
set view upper
fill/lev=(-inf)(-10,20,2)(inf)/pal=rnb2/vlims=20:140:-10 annual
set view lower
fill/lev=(-inf)(-10,20,2)(inf)/pal=rnb2/vlims=20:140:-10 annual_lsl
frame/file=${file::-3}_lancos_lsl_comparison.png/ypixel=2245

save/file=${file::-3}_variability.nc bmd,intsn,intan,annual,subann,annual_lsl

sp mv ${file::-3}_variability.png ${file::-3}_lancos_lsl_comparison.png ${file::-3}_variability.nc ./intraseasonal_currents

eof
done

