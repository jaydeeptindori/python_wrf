fout = strcompress('/home/jd/GVAX_data/wind_wd.dat', /remove_all)

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
openw, lun, fout, /get_lun
printf, lun, ' date jdd    time   wd'
free_lun, lun

;because block statement is not allowed in the idl programming
for i=0, nfiles-1 do begin & print, 'running =', 1+i, ' out of ', nfiles & Date[i]=STRMID(files[i], len+12, 8) & yy[i]=float(strmid(date[i], 0, 4)) & mm[i] = float(strmid(date[i], 4, 2)) & dd[i] =float(strmid(date[i], 6, 2)) & filename[i] = files[i] & jdd[i] = ndd[mm[i]-1] + dd[i] & endfor 

j= where(date gt 20120229, jcount) & jdd[j] = jdd[j]+1

for i=0, nfiles-1 do begin & id[i] = ncdf_open(filename[i]) & ncdf_varget, id[i], 'time', time & time = time/3600.0d & ncdf_varget, id[i], 'wdir_vec_mean', wd_in & ncdf_varget, id[i], 'qc_wdir_vec_mean', qc5 & ncdf_close, id[i] & ind = where(qc5 eq 0 and wd_in ne -9999 and wd_in gt 0 and wd_in le 361) & if ind ne [-1] then begin & data = wd_in[ind] & dim = n_elements(data) & openw, lun, fout, /get_lun, /append & for q = 0, dim-1 do printf, lun, date[i], jdd[i], time[q], data[q], format = '(1a8, 1x, i3, 1x, f5.2, 1x, f7.3)' & free_lun, lun & endif & endfor


;ncdf_varget, id, 'atmos_pressure', pres_in
;ncdf_varget, id, 'qc_atmos_pressure', qc1

;ncdf_varget, id, 'temp_mean', temp_in
;ncdf_varget, id, 'qc_temp_mean', qc2

;ncdf_varget, id, 'rh_mean', rh_in
;ncdf_varget, id, 'qc_rh_mean', qc3

;ncdf_varget, id, 'wdir_vec_mean', wd_in
;ncdf_varget, id, 'qc_wdir_vec_mean', qc5

