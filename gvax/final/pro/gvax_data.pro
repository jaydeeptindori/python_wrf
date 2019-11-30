fout = strcompress('/home/jd/GVAX_data/f_wind_sd.dat', /remove_all)

path = '/home/jd/GVAX_data/raw/met/'

len = strlen(path)

files = file_search(string(path) + 'pgh*.cdf', count = nfiles)
date = strarr(nfiles)
jdd = fltarr(nfiles)
yy = fltarr(nfiles)
dd = fltarr(nfiles)
mm = fltarr(nfiles)
id = strarr(nfiles)
filename = strarr(nfiles)
ndd = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
n = ndd
openw, lun, fout, /get_lun
printf, lun, ' date jdd    time   ws    wd'
free_lun, lun
;because block statement is not allowed in the idl programming
for i=0, nfiles-1 do begin & print, 'running =', 1+i, ' out of ', nfiles & Date[i]=STRMID(files[i], len+12, 8) & yy[i]=float(strmid(date[i], 0, 4)) & mm[i] = float(strmid(date[i], 4, 2)) & dd[i] =float(strmid(date[i], 6, 2)) & if yy[i] mod 4 eq 0 then for k = 2, 11 do ndd[k] = ndd[k] + 1 & print, ndd & jdd[i]=ndd[mm[i]-1] + dd[i] & filename[i] = files[i] & endfor

for i=0, nfiles-1 do begin & id[i] = ncdf_open(filename[i]) & ncdf_varget, id[i], 'time', time & time = time/3600.0d & ncdf_varget, id[i], 'wspd_arith_mean', ws_in & ncdf_varget, id[i], 'qc_wspd_arith_mean', qc4 & ncdf_close, id[i] & ind = where(qc4 eq 0 and ws_in ne -9999 and ws_in gt 0 and ws_in le 100) & if ind ne [-1] then begin & data = ws_in[ind] & dim = n_elements(data) & openw, lun, fout, /get_lun, /append & for q = 0, dim-1 do printf, lun, date[i], jdd[i], time[q], data[q], format = '(1a8, 1x, i3, 1x, f5.2, 1x, f7.3)' & free_lun, lun & endif & endfor

;openw, lun, fout, /get_lun, /append & for q = 0, dim-1 do printf, lun, date[i], jdd[i], time[q], data[q], format = '(1a8, 1x, i3, 1x, f5.2, 1x, f7.3)' & free_lun, lun & endfor

;ncdf_varget, id, 'atmos_pressure', pres_in
;ncdf_varget, id, 'qc_atmos_pressure', qc1

;ncdf_varget, id, 'temp_mean', temp_in
;ncdf_varget, id, 'qc_temp_mean', qc2

;ncdf_varget, id, 'rh_mean', rh_in
;ncdf_varget, id, 'qc_rh_mean', qc3

;ncdf_varget, id, 'wdir_vec_mean', wd_in
;ncdf_varget, id, 'qc_wdir_vec_mean', qc5

