file1 = '~/GVAX_data/final/wind_wd_gmt.dat'
file2 = '~/GVAX_data/final/f_wind_sd_GMT.dat'

n1= file_lines(file1)
n2= file_lines(file2)

print, n1, n2

date1  = lonarr(n1)
hh1 = fltarr(n1)
jdd1  = lonarr(n1)
wd   = fltarr(n1)

date2  = lonarr(n2)
hh2 = fltarr(n2)
jdd2  = lonarr(n2)
ws   = fltarr(n2)

help, n1, n2

x0=0
y0=0
z0= 0.0
z1=0.0

OPENR, lun, file1, /GET_LUN
for i = 0, n1-1 Do Begin & READF, lun, x0, y0, z0, z1 & date1[i]=x0 & hh1[i]=y0 & jdd1[i]= z0 & wd[i]=z1 & endfor 
free_lun, lun

OPENR, lun, file2, /GET_LUN
for i = 0, n2-1 Do Begin & READF, lun, x0, y0, z0, z1 & date2[i]=x0 & hh2[i]=y0 & jdd2[i]= z0 & ws[i]=z1 & endfor
free_lun, lun

