PRO ws_noon_even_avg

COMPILE_OPT IDL2
 
infile = 'I:\data\GVAX_data\final\temp\temp_hrly_LST.dat'

fout1 = 'I:\data\GVAX_data\final\temp\month_avg_temp.dat'
fout2 = 'I:\data\GVAX_data\final\temp\noon_avg_temp.dat'
fout3 = 'I:\data\GVAX_data\final\temp\night_avg_temp.dat'

n     =  FILE_LINES(infile)
help, n
yy  = lonarr(n)
dd  = lonarr(n)
hh  = fltarr(n)
ws  = fltarr(n)

;average monthly value
jun = FLTARR(1)
jul = FLTARR(1)
aug = FLTARR(1)
sep = FLTARR(1)
oct = FLTARR(1)
nov = FLTARR(1)
dec = FLTARR(1)
jan = FLTARR(1)
feb = FLTARR(1)
mar = FLTARR(1)

jun_std = FLTARR(1)
jul_std = FLTARR(1)
aug_std = FLTARR(1)
sep_std = FLTARR(1)
oct_std = FLTARR(1)
nov_std = FLTARR(1)
dec_std = FLTARR(1)
jan_std = FLTARR(1)
feb_std = FLTARR(1)
mar_std = FLTARR(1)

;average noon
june = FLTARR(1)
jule = FLTARR(1)
auge = FLTARR(1)
sepe = FLTARR(1)
octe = FLTARR(1)
nove = FLTARR(1)
dece = FLTARR(1)
jane = FLTARR(1)
febe = FLTARR(1)
mare = FLTARR(1)

june_std = FLTARR(1)
jule_std = FLTARR(1)
auge_std = FLTARR(1)
sepe_std = FLTARR(1)
octe_std = FLTARR(1)
nove_std = FLTARR(1)
dece_std = FLTARR(1)
jane_std = FLTARR(1)
febe_std = FLTARR(1)
mare_std = FLTARR(1)

;night value
junn = FLTARR(1)
juln = FLTARR(1)
augn = FLTARR(1)
sepn = FLTARR(1)
octn = FLTARR(1)
novn = FLTARR(1)
decn = FLTARR(1)
jann = FLTARR(1)
febn = FLTARR(1)
marn= FLTARR(1)

junn_std = FLTARR(1)
juln_std = FLTARR(1)
augn_std = FLTARR(1)
sepn_std = FLTARR(1)
octn_std = FLTARR(1)
novn_std = FLTARR(1)
decn_std = FLTARR(1)
jann_std = FLTARR(1)
febn_std = FLTARR(1)
marn_std = FLTARR(1)

y0=0
h0=0.0
d0=0
ws0=0.0

OPENR, lun, infile, /GET_LUN
FOR i=0 , n-1 DO BEGIN
READF, lun, y0, d0, h0, ws0
 yy[i] = y0
 dd[i] = d0
 hh[i] = h0
 ws[i] = ws0
 ENDFOR
FREE_LUN, lun

j = WHERE(yy GT 20110531 AND yy LE 20110630, jcount)
jun = mean(ws[j])
jun_std=stdev(ws[j]) 

j = WHERE(yy GT 20110630 AND yy LE 20110731, jcount)
jul = mean(ws[j])
jul_std=stdev(ws[j]) 

j = WHERE(yy GT 20110731 AND yy LE 20110831, jcount)
aug = mean(ws[j])
aug_std=stdev(ws[j]) 

j = WHERE(yy GT 20110831 AND yy LE 20110930, jcount)
sep = mean(ws[j])
sep_std=stdev(ws[j]) 

j2 = WHERE(yy GT 20110930 AND yy LE 20111031, j2count)
oct = mean(ws[j2])
oct_std=stdev(ws[j2]) 

j1 = WHERE(yy GT 20111031 AND yy LE 20111130, j1count)
nov = mean(ws[j1])
nov_std =stdev(ws[j1])

j = WHERE(yy GT 20111130 AND yy LE 20111231, jcount)
dec = mean(ws[j])
dec_std = stdev(ws[j])

j = WHERE(yy GT 20111231 AND yy LE 20120131, jcount)
jan = mean(ws[j])
jan_std=stdev(ws[j])

j = WHERE(yy GT 20120131 AND yy LE 20120229, jcount)
feb = mean(ws[j])
feb_std =stdev(ws[j])

j = WHERE(yy GT 20120229 AND yy LE 20120331, jcount)
mar = mean(ws[j])
mar_std=stdev(ws[j])


OPENW, lun, fout1, /GET_LUN
PRINTF, lun, 'this file contains monthely_average data with std_dev of the 12 month with std_dev'
PRINTF, lun, 'jun, jul, aug, sep, oct, nov, dec, jan, feb, mar'
PRINTF, lun, 'jun_std, jul_std, aug_std, sep_std, oct_std, nov_std, dec_std, jan_std, feb_std, mar_std'
PRINTF, lun, jun, jul, aug, sep, oct, nov, dec, jan, feb, mar,  FORMAT = '(12F8.3)'
PRINTF, lun, jun_std, jul_std, aug_std, sep_std, oct_std, nov_std, dec_std, jan_std, feb_std, mar_std, FORMAT = '(12F8.3)' 
FREE_LUN, lun

;===================================================================================================
j = WHERE(yy GT 20110531 AND yy LE 20110630 and hh ge 11.50 and hh le 15.50,  jcount)
june = mean(ws[j])
june_std=stdev(ws[j]) 
help, j
j = WHERE(yy GT 20110630 AND yy LE 20110731 and hh ge 11.50 and hh le 15.50, jcount)
jule = mean(ws[j])
jule_std=stdev(ws[j]) 
help, j
j = WHERE(yy GT 20110731 AND yy LE 20110831 and hh ge 11.50 and hh le 15.50, jcount)
auge = mean(ws[j])
auge_std=stdev(ws[j]) 
help, j
j = WHERE(yy GT 20110831 AND yy LE 20110930 and hh ge 11.50 and hh le 15.50, jcount)
sepe = mean(ws[j])
sepe_std=stdev(ws[j]) 
help, j
j2 = WHERE(yy GT 20110930 AND yy LE 20111031 and hh ge 11.50 and hh le 15.50, j2count)
octe = mean(ws[j2])
octe_std=stdev(ws[j2]) 
help, j2
j1 = WHERE(yy GT 20111031 AND yy LE 20111130 and hh ge 11.50 and hh le 15.50, j1count)
nove = mean(ws[j1])
nove_std =stdev(ws[j1])
help, j1
j = WHERE(yy GT 20111130 AND yy LE 20111231 and hh ge 11.50 and hh le 15.50, jcount)
dece = mean(ws[j])
dece_std = stdev(ws[j])
help, j
j = WHERE(yy GT 20111231 AND yy LE 20120131 and hh ge 11.50 and hh le 15.50, jcount)
jane = mean(ws[j])
jane_std=stdev(ws[j])
help, j
j = WHERE(yy GT 20120131 AND yy LE 20120229 and hh ge 11.50 and hh le 15.50, jcount)
febe = mean(ws[j])
febe_std =stdev(ws[j])
help, j
j = WHERE(yy GT 20120229 AND yy LE 20120331 and hh ge 11.50 and hh le 15.50, jcount)
mare = mean(ws[j])
mare_std=stdev(ws[j])
help, j
OPENW, lun, fout2, /GET_LUN
PRINTF, lun, 'this file contains monthely_average of noon with std_dev of the 12 month with std_dev'
PRINTF, lun, 'jun, jul, aug, sep, oct, nov, dec, jan, feb, mar'
PRINTF, lun, 'jun_std, jul_std, aug_std, sep_std, oct_std, nov_std, dec_std, jan_std, feb_std, mar_std'
PRINTF, lun, june, jule, auge, sepe, octe, nove, dece, jane, febe, mare,  FORMAT = '(12F8.3)'
PRINTF, lun, june_std, jule_std, auge_std, sepe_std, octe_std, nove_std, dece_std, jane_std, febe_std, mare_std, FORMAT = '(12F8.3)' 
FREE_LUN, lun

;====================================================================================
j = WHERE(yy GT 20110531 AND yy LE 20110630 and hh ge 1.0 and hh le 3.00, jcount)
junn = mean(ws[j])
junn_std=stdev(ws[j]) 

j = WHERE(yy GT 20110630 AND yy LE 20110731 and hh ge 1.0 and hh le 3.00, jcount)
juln = mean(ws[j])
juln_std=stdev(ws[j]) 

j = WHERE(yy GT 20110731 AND yy LE 20110831 and hh ge 1.0 and hh le 3.00, jcount)
augn = mean(ws[j])
augn_std=stdev(ws[j]) 

j = WHERE(yy GT 20110831 AND yy LE 20110930 and hh ge 1.0 and hh le 3.00, jcount)
sepn = mean(ws[j])
sepn_std=stdev(ws[j]) 

j2 = WHERE(yy GT 20110930 AND yy LE 20111031 and hh ge 1.0 and hh le 3.00, j2count)
octn = mean(ws[j2])
octn_std=stdev(ws[j2]) 

j1 = WHERE(yy GT 20111031 AND yy LE 20111130 and hh ge 1.0 and hh le 3.00, j1count)
novn = mean(ws[j1])
novn_std =stdev(ws[j1])

j = WHERE(yy GT 20111130 AND yy LE 20111231 and hh ge 1.0 and hh le 3.00, jcount)
decn = mean(ws[j])
decn_std = stdev(ws[j])

j = WHERE(yy GT 20111231 AND yy LE 20120131 and hh ge 1.0 and hh le 3.00, jcount)
jann = mean(ws[j])
jann_std=stdev(ws[j])

j = WHERE(yy GT 20120131 AND yy LE 20120229 and hh ge 1.0 and hh le 3.00, jcount)
febn = mean(ws[j])
febn_std =stdev(ws[j])

j = WHERE(yy GT 20120229 AND yy LE 20120331 and hh ge 1.0 and hh le 3.00, jcount)
marn = mean(ws[j])
marn_std=stdev(ws[j])


OPENW, lun, fout3, /GET_LUN
PRINTF, lun, 'this file contains monthely_average data of night time between 1.00 to 3.00 with std_dev of the 12 month with std_dev'
PRINTF, lun, 'jun, jul, aug, sep, oct, nov, dec, jan, feb, mar'
PRINTF, lun, 'jun_std, jul_std, aug_std, sep_std, oct_std, nov_std, dec_std, jan_std, feb_std, mar_std'
PRINTF, lun, junn, jul, augn, sepn, octn, novn, decn, jann, febn, marn,  FORMAT = '(12F8.3)'
PRINTF, lun, junn_std, juln_std, augn_std, sepn_std, octn_std, novn_std, decn_std, jann_std, febn_std, marn_std, FORMAT = '(12F8.3)' 
FREE_LUN, lun
END
