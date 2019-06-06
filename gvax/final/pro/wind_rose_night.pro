;PRO wind_rose

COMPILE_OPT IDL2
 
fin1 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/wind_ws_LST.dat'
fin2 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/wind_wd_LST.dat'
fout1 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_jun.dat'
fout2 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_jul.dat'
fout3 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_aug.dat'
fout4 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_sep.dat'
fout5 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_oct.dat'
fout6 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_nov.dat'
fout7 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_dec.dat'
fout8 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_jan.dat'
fout9 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_feb.dat'
fout10 = '$MEDIA/Seagate/data/GVAX_data/final/wind/data/nwindrose_mar.dat'


n1     =  FILE_LINES(fin1)
n2     =  FILE_LINES(fin2)

print, n1, n2

yy1  = lonarr(n1)
dd1  = lonarr(n1)
hh1  = fltarr(n1)
ws  = fltarr(n1)

yy2  = lonarr(n2)
dd2  = lonarr(n2)
hh2  = fltarr(n2)
wd  = fltarr(n2)

OPENR, lun, fin1, /GET_LUN
FOR i=0 , n1-1 DO BEGIN &  READF, lun, y0, d0, h0, ws0 & yy1[i] = y0 & dd1[i] = d0 & hh1[i] = h0 & ws[i] = ws0 & ENDFOR & FREE_LUN, lun 

OPENR, lun, fin2, /GET_LUN
FOR i=0 , n2-1 DO BEGIN &  READF, lun, y0, d0, h0, wd0 & yy2[i] = y0 & dd2[i] = d0 & hh2[i] = h0 & wd[i] = wd0 & ENDFOR & FREE_LUN, lun 

j1 = WHERE(yy1 gt 20110531 and yy2 GT 20110531 AND yy1 LE 20110630 and yy2 LE 20110630 AND hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j1count)
jun_ws = FLTARR(j1count)
jun_wd = FLTARR(j1count)
jun_ws = ws[j1]
jun_wd = wd[j1]
OPENW, lun, fout1, /GET_LUN
for i = 0, j1count-1 do PRINTF, lun, jun_wd[i], jun_ws[i]
FREE_LUN, lun


j2 = WHERE(dd1 ge 182 and dd2 ge 182 and dd1 le 212 and dd2 le 212 AND hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j2count)  
jul_ws = FLTARR(j2count)
jul_wd = FLTARR(j2count)
jul_ws = ws[j2]
jul_wd = wd[j2]
OPENW, lun, fout2, /GET_LUN
for i = 0, j2count-1 do PRINTF, lun, jul_wd[i], jul_ws[i]
FREE_LUN, lun


j3 = WHERE(yy1 gt 20110731 and yy2 GT 20110731 AND yy1 LE 20110831 and yy2 LE 20110831 AND hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j3count)  
aug_ws = FLTARR(j3count)
aug_wd = FLTARR(j3count)
aug_ws = ws[j3]
aug_wd = wd[j3]
OPENW, lun, fout3, /GET_LUN
for i = 0, j3count-1 do PRINTF, lun, aug_wd[i], aug_ws[i]
FREE_LUN, lun


j4 = WHERE(dd1 gt 243 and dd2 gt 243 and dd1 le 273 and dd2 le 273 AND hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j4count)  
sep_ws = FLTARR(j4count)
sep_wd = FLTARR(j4count)
sep_ws = ws[j4]
sep_wd = wd[j4]
OPENW, lun, fout4, /GET_LUN
for i = 0, j4count-1 do PRINTF, lun, sep_wd[i], sep_ws[i]
FREE_LUN, lun

j5 = WHERE(dd1 gt 273 and dd2 gt 273 and dd1 le 304 and dd2 le 304 AND hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j5count)  
oct_ws = FLTARR(j5count)
oct_wd = FLTARR(j5count)
oct_ws = ws[j5]
oct_wd = wd[j5]
OPENW, lun, fout5, /GET_LUN
for i = 0, j5count-1 do PRINTF, lun, oct_wd[i], oct_ws[i]
FREE_LUN, lun

j6 = WHERE(dd1 gt 304 and dd2 gt 304 and dd1 le 334 and dd2 le 334 AND hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j6count)  
nov_ws = FLTARR(j6count)
nov_wd = FLTARR(j6count)
nov_ws = ws[j6]
nov_wd = wd[j6]
OPENW, lun, fout6, /GET_LUN
for i = 0, j6count-1 do PRINTF, lun, nov_wd[i], nov_ws[i]
FREE_LUN, lun

j7 = WHERE(dd1 gt 334 and dd2 gt 334 and dd1 le 365 and dd2 le 365 AND hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j7count)  
dec_ws = FLTARR(j7count)
dec_wd = FLTARR(j7count)
dec_ws = ws[j7]
dec_wd = wd[j7]
OPENW, lun, fout7, /GET_LUN
for i = 0, j7count-1 do PRINTF, lun, dec_wd[i], dec_ws[i]
FREE_LUN, lun

j8 = WHERE(yy1 ge 20111232 and yy1 le 20120131 and hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j8count)
jan_ws = FLTARR(j8count)
jan_wd = FLTARR(j8count)
jan_ws = ws[j8]
jan_wd = wd[j8]
OPENW, lun, fout8, /GET_LUN
for i = 0, j8count-1 do PRINTF, lun, jan_wd[i], jan_ws[i]
FREE_LUN, lun


j9 = WHERE(dd1 gt 31 and dd2 gt 31 and dd1 le 60 and dd2 le 60 AND hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j9count)  
feb_ws = FLTARR(j9count)
feb_wd = FLTARR(j9count)
feb_ws = ws[j9]
feb_wd = wd[j9]
OPENW, lun, fout9, /GET_LUN
for i = 0, j9count-1 do PRINTF, lun, feb_wd[i], feb_ws[i]
FREE_LUN, lun
 

j10 = WHERE(yy1 gt 20120229 and dd2 gt 60 and dd2 le 91 and hh1 eq hh2 and hh1 ge 1.0 and hh1 le 3.00, j10count)  
mar_ws = FLTARR(j10count)
mar_wd = FLTARR(j10count)
mar_ws = ws[j10]
mar_wd = wd[j10]
OPENW, lun, fout10, /GET_LUN
for i = 0, j10count-1 do PRINTF, lun, mar_wd[i], mar_ws[i]
FREE_LUN, lun

help, j1, j2, j3, j4, j5, j6,j7, j8, j9, j10
;OPENW, lun, fout, /GET_LUN
;PRINTF, lun, 'this file contains hourly average data of the five month with std_dev Nov_dec'
;PRINTF, lun, 'nov[i], nov_std[i], dec[i], dec_std[i], jan[i], jan_std[i], feb[i], feb_std[i], mar[i], mar_std[i]'
;FOR i =0, 23 DO PRINTF, lun, nov[i], nov_std[i], dec[i], dec_std[i], jan[i], jan_std[i], feb[i], feb_std[i], mar[i], mar_std[i], FORMAT = '(10F8.3)'
;FREE_LUN, lun
;end
