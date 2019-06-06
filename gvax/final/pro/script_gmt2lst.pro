fin1= '$MEDIA/Seagate/data/GVAX_data/final/press/press_hrly_gmt.dat'
fout= '$MEDIA/Seagate/data/GVAX_data/final/press/press_hrly_lst.dat'
n   = file_lines(fin1)
date  = lonarr(n)
jdd  = lonarr(n)
hh = fltarr(n)
ws   = fltarr(n)

print, n

x0=0
y0=0
z0= 0.0
z1=0.0

OPENR, lun, fin1, /GET_LUN
for i = 0, n-1 Do Begin & READF, lun, x0, y0, z0, z1 & date[i]=x0 & jdd[i]=y0 & hh[i]= z0 & ws[i]=z1 & endfor 
free_lun, lun

for i = 0, n-1 do hh[i] = hh[i] + 5.5 & j= where(hh gt 24.00, jcount) & hh[j] = hh[j]-24
for i = 0, n-1 do k = where(hh gt 0.0 and hh le 5.5) & jdd[k] = jdd[k]+1 & date[k] = date[k] + 1 & k = where(jdd ge 366) & jdd[k] =1 & date[k] = date[k+6]



;;;;if date[i+1] ne date[i] and hh[i] ge 0.0 and hh[i] le 6 then date[i] = date[i+ 1]
;;;;help, i
;;;;for i = 0, n_elements(date)-1 do print, date[i], hh[i] 

openw, lun, fout, /get_lun
printf, lun, 'Date	jdd    lhh    rh'
for i = 0, n-1 do printf, lun, date[i], jdd[i], hh[i], ws[i], format = '(I8, 1x, I4, 1x, F5.2, 1x, f8.2)
free_lun, lun

end
