pro sonde_fmt_interpol

path = '/run/media/jd/Seagate/data/GVAX_data/raw/sonde/'

files = file_search(path + 'pgh*.cdf', count = nfiles)

len = strlen(path+'pghsondewnpnM1.b1.') + 9
tt = strmid(files, len, 4)
hh = float(strmid(tt, 0, 2))
minut = float(strmid(tt, 2, 2))

ltime = fltarr(nfiles)
id = strarr(nfiles)
filename=strarr(nfiles)


for i = 0, nfiles-1 do ltime[i] = hh[i] + minut[i]/60.0 


;ind = where(ltime ge 5.0 and ltime le 13.0)
; selected files for 6 and 12 gmt for all data 
;files = files(ind)
;tt  = tt(ind)
;nfiles = n_elements(files)
;dates = strmid(files, len-9, 8)
;.r '/home/jd/itt/idl/lib/readcol.pro'
;.r '/home/jd/itt/idl/lib/coyoteprograms/coyote/cgerrormsg.pro'
;.r '/home/jd/Desktop/idl_library/strsplit.pro'
;defining the standard altitude array of 65 levels


.r '/home/jd/Desktop/idl_library/gettok.pro'
.r '/home/jd/Desktop/idl_library/strnumber.pro'
readcol, '/run/media/jd/Seagate/data/GVAX_data/final/sonde/altitude.dat', alt_out

dim = n_elements(alt_out)

; for diff files
;for i = 0, nfiles-1 do begin &  & endfor

for i = 0, nfiles-1 do begin
filename[i] = files[i] 
& print, 'running =', 1+i, ' out of ', nfiles & id[i] = ncdf_open(filename[i]) & ncdf_varget, id[i], 'tdry', tdry & ncdf_varget, id[i], 'rh', rh  & ncdf_varget, id[i], 'alt', alt &  ncdf_varget, id[i], 'wspd', wspd & ncdf_varget, id[i], 'qc_tdry', qc1 & ncdf_varget, id[i], 'qc_rh', qc2 & ncdf_varget, id[i], 'qc_wspd', qc3  & ncdf_close, id[i] & endfor

 ind1 = where(qc1 eq 0 and tdry ne -9999 and tdry ge -90.0 and tdry le 50.0) & alt1 = alt(ind1) & tdry = tdry(ind1)









rh_in=rh
ind2 = where(qc2 eq 0 and rh ne -9999 and rh ge 0.0 and rh le 100.0)
alt2 = alt(ind2)
rh = rh(ind2)

wspd_in=wspd
ind3 = where(qc3 eq 0 and wspd ne -9999 and wspd gt 0 and wspd le 100)
alt3=atl(ind3)
wspd = wspd(ind3) 








