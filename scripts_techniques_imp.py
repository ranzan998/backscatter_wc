import os
os.system('terminal command')

# to list all the files in this directory
file_name = os.listdir('path to directory')

#change the NREC value in tira1m.ctl for the next run
def inplace_change(filename, old_string, new_string):
    with open(filename) as file:
        s = file.read()
        if old_string not in s:
            print('"{old_string}" not found in {filename}.'.format(**locals()))
            return

    with open(filename, 'w') as file:
        print('Changing "{old_string}" to "{new_string}" in {filename}'.format(**locals()))
        s = s.replace(old_string, new_string)
        file.write(s)

#to rewrite as a new file
def copy(old_name, new_name):
    with open(old_name) as file:
        s = file.read()
    with open(new_name, 'w') as file:
        file.write(s)
        file.close()


#loading from txt file, columns using np
U_RAW = np.loadtxt("tide1.out")[:, 5]

#creating dataset using xarray
ds = xr.Dataset({
    'U_RAW': xr.DataArray(
     data=U_RAW,  # enter data here
     dims=['time'],
     coords={'time': data["TAXIS"].values},
     attrs={'long_name': 'u raw', 'units': 'cm/s'}
     ),
    'V_RAW': xr.DataArray(
            data=V_RAW,  # enter data here
            dims=['time'],
            coords={'time': data["TAXIS"].values},
            attrs={'long_name': 'v raw', 'units': 'cm/s'}
        )},
        attrs={'author': 'ranjan'}
    )

#xarray mean, no worries about missing values, if it is np.nan
mean = ds.u.mean()

xr.Dataset.mean(ds.a)

#replace values from zero to nan, or anything
xr.where(a!=0,a,np.nan)             #where a is dataset
         #read it as, whereever a is not equal to zero, keep it as it is, others is changed to np.nan
         
#############run something piped in terminal, {} is fed by .format values, which can be easily replaced in python
os.system("printf '%s\n' {} {} {} {} {} {} | bash backscatter.sh".format(filename,astfilename,er['bm1'][c],er['bm2'][c],er['bm3'][c],er['bm4'][c]))


######################################
#wavelet analysis, adjust the scales and everything

from pycwt import cwt,xwt,wct,wct_significance,wavelet,significance
wave_u, scales_u, freqs_u, coi_u, fft, fftfreqs = cwt(sl.sealevel.values, dt=1, dj=0.25, s0=12, J=28, wavelet='morlet')
periods = 1/freqs_u
levs = np.arange(5,12,0.5)
plt.contourf(sl.datetime.values,np.log2(periods*.5),np.log2(abs(wave_u)),levs,extend='both',cmap="RdBu_r")
plt.colorbar()

#########cmap best##################
import matplotlib.colors as mcolors
colors = [
    (0, 0, 0.5),   # Dark Blue (Low values)
    (0, 0, 1.0),   # Blue
    (0, 1.0, 1.0), # Cyan
    (1.0, 1.0, 0), # Yellow
    (1.0, 0.5, 0), # Orange
    (1.0, 0, 0)    # Red (High values)
]

# Number of bins or segments in the colormap
n_bins = 100

# Create a custom colormap
cmap_name = "WaveletColormap"
custom_cmap = mcolors.LinearSegmentedColormap.from_list(cmap_name, colors, N=n_bins)


####################


















