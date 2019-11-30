PRO gvax_data_ws_fnl_gmt

COMPILE_OPT IDL2
 
infile = 'E:\final\f_wind_sd.dat'

 n     =  FILE_LINES(infile)
print, n
yy  = lonarr(n)
dd  = lonarr(n)
hh  = lonarr(n)
ws  = fltarr(n)
jun = FLTARR(24)
jul = FLTARR(24)
aug = FLTARR(24)
sep = FLTARR(24)
oct = FLTARR(24)
nov = FLTARR(24)
dec = FLTARR(24)
jan = FLTARR(24)
feb = FLTARR(24)
mar = FLTARR(24)
time = INDGEN(24)

jun_std = FLTARR(24)
jul_std = FLTARR(24)
aug_std = FLTARR(24)
sep_std = FLTARR(24)
oct_std = FLTARR(24)
nov_std = FLTARR(24)
dec_std = FLTARR(24)
jan_std = FLTARR(24)
feb_std = FLTARR(24)
mar_std = FLTARR(24)

OPENR, lun, infile, /GET_LUN

 FOR i=0 , n-1 DO BEGIN
 READF, lun, y0, d0, h0, ws0
 yy[i] = y0
 dd[i] = d0
 hh[i] = h0
 ws[i] = ws0
 ENDFOR
FREE_LUN, lun

FOR m = 0,23 DO BEGIN 
j = WHERE(yy GT 20110531 AND yy LE 20110630 AND hh EQ m, jcount)
jun[m] = mean(ws[j])
jun_std[m]=stdev(ws[j]) 
ENDFOR 

FOR m = 0,23 DO BEGIN 
j = WHERE(yy GT 20110630 AND yy LE 20110731 AND hh EQ m, jcount)
jul[m] = mean(ws[j])
jul_std[m]=stdev(ws[j]) 
ENDFOR 

FOR m = 0,23 DO BEGIN 
j = WHERE(yy GT 20110731 AND yy LE 20110831 AND hh EQ m, jcount)
aug[m] = mean(ws[j])
aug_std[m]=stdev(ws[j]) 
ENDFOR 
print, aug_std
FOR m = 0,23 DO BEGIN 
j = WHERE(yy GT 20110831 AND yy LE 20110930 AND hh EQ m, jcount)
sep[m] = mean(ws[j])
sep_std[m]=stdev(ws[j]) 
ENDFOR 
help, j

FOR m = 0,23 DO BEGIN 
j2 = WHERE(yy GT 20110930 AND yy LE 20111031 AND hh EQ m, j2count)
oct[m] = mean(ws[j2])
oct_std[m]=stdev(ws[j2]) 
ENDFOR 
help, j2

FOR m = 0,23 DO BEGIN 
j1 = WHERE(yy GT 20111031 AND yy LE 20111130 AND hh EQ m, j1count)
nov[m] = mean(ws[j1])
nov_std[m]=stdev(ws[j1])
ENDFOR
help, j1

FOR m = 0,23 DO BEGIN 
j = WHERE(yy GT 20111130 AND yy LE 20111231 AND hh EQ m, jcount)
dec[m] = mean(ws[j])
dec_std[m]=stdev(ws[j])
ENDFOR

FOR m = 0,23 DO BEGIN 
j = WHERE(yy GT 20111231 AND yy LE 20120131 AND hh EQ m, jcount)
jan[m] = mean(ws[j])
jan_std[m]=stdev(ws[j])
ENDFOR

FOR m = 0,23 DO BEGIN 
j = WHERE(yy GT 20120131 AND yy LE 20120229 AND hh EQ m, jcount)
feb[m] = mean(ws[j])
feb_std[m]=stdev(ws[j])
ENDFOR

FOR m = 0,23 DO BEGIN 
j = WHERE(yy GT 20120229 AND yy LE 20120331 AND hh EQ m, jcount)
mar[m] = mean(ws[j])
mar_std[m]=stdev(ws[j])
ENDFOR


fout = 'E:\final\ws_hly1.dat'

OPENW, lun, fout, /GET_LUN
PRINTF, lun, 'this file contains hourly average data of the five month with std_dev'
PRINTF, lun, 'jun[i], jun_std[i], jul[i], jul_std[i], aug[i], aug_std[i], sep[i], sep_std[i], oct[i], oct_std[i]'
FOR i =0, 23 DO PRINTF, lun, jun[i], jun_std[i], jul[i], jul_std[i], aug[i], aug_std[i], sep[i], sep_std[i], oct[i], oct_std[i], FORMAT = '(10F8.3)'
FREE_LUN, lun

fout = 'E:\final\ws_hly2.dat'

OPENW, lun, fout, /GET_LUN
PRINTF, lun, 'this file contains hourly average data of the five month with std_dev Nov_dec'
PRINTF, lun, 'nov[i], nov_std[i], dec[i], dec_std[i], jan[i], jan_std[i], feb[i], feb_std[i], mar[i], mar_std[i]'
FOR i =0, 23 DO PRINTF, lun, nov[i], nov_std[i], dec[i], dec_std[i], jan[i], jan_std[i], feb[i], feb_std[i], mar[i], mar_std[i], FORMAT = '(10F8.3)'
FREE_LUN, lun

END
