t_win = 1; time window in hour

diff = t_win/2.0

t = 6
;for t = 6, 12, 6 do begin

std_time = t ; 6 GMT = 1130

fout = strcompress('/home/ojha/ANL-work/SURF-MET/surf-met_' + string(std_time) + 'hr.dat', /remove_all)

t_low = std_time-diff
t_up  = std_time+ diff

path = '/home/ojha/GVAX_data/met/'

len = strlen(path)

files = file_search(string(path) + 'pgh*.cdf', count = nfiles)

date = strarr(nfiles)
jdd = fltarr(nfiles)
temp = fltarr(nfiles)
pres = fltarr(nfiles)
rh = fltarr(nfiles)
ws = fltarr(nfiles)
wd = fltarr(nfiles)



for i = 0, nfiles-1 do begin
print, 'running = ', i, ' out of ', nfiles-1

date[i] = strmid(files[i], len+12, 8)

yy = float(strmid(date[i], 0, 4))
mm = float(strmid(date[i], 4, 2))
dd = float(strmid(date[i], 6, 2))

ndd = [0, 31, 59, 90, 120, 151, 181, 212,  243, 273, 304, 334]
if yy mod 4 eq 0 then for k = 1, 11 do ndd[k] = ndd[k] + 1

jdd[i] = ndd[mm-1] + dd

filename = files[i]

id = ncdf_open(filename)

ncdf_varget, id, 'time', time
time = time/3600.0d

ncdf_varget, id, 'atmos_pressure', pres_in
ncdf_varget, id, 'qc_atmos_pressure', qc1

ncdf_varget, id, 'temp_mean', temp_in
ncdf_varget, id, 'qc_temp_mean', qc2

ncdf_varget, id, 'rh_mean', rh_in
ncdf_varget, id, 'qc_rh_mean', qc3

ncdf_varget, id, 'wspd_arith_mean', ws_in
ncdf_varget, id, 'qc_wspd_arith_mean', qc4

ncdf_varget, id, 'wdir_vec_mean', wd_in
ncdf_varget, id, 'qc_wdir_vec_mean', qc5

; Quality controlled data of the given time window, qc = 0; data exists and passes all qc tests

;ind = where(qc1 eq 0 and qc2 eq 0 and qc3 eq 0 and qc4 eq 0 and qc5 eq 0 and qc_alpha eq 0 and time ge t_low and time le t_up and aod1 ne -9999 and aod2 ne -9999 and aod3 ne -9999 and aod4 ne -9999 and aod5 ne -9999)

ind = where(qc1 eq 0 and time ge t_low and time le t_up and pres_in ne -9999)
if ind ne [-1] then pres[i] =  mean(pres_in[ind]) else pres[i] = -9999

ind = where(qc2 eq 0 and time ge t_low and time le t_up and temp_in ne -9999)
if ind ne [-1] then temp[i] =  mean(temp_in[ind]) else temp[i] = -9999

ind = where(qc3 eq 0 and time ge t_low and time le t_up and rh_in ne -9999)
if ind ne [-1] then rh[i] =  mean(rh_in[ind]) else rh[i] = -9999

ind = where(qc4 eq 0 and time ge t_low and time le t_up and ws_in ne -9999)
if ind ne [-1] then ws[i] =  mean(ws_in[ind]) else ws[i] = -9999

;ind = where(qc5 eq 0 and time ge t_low and time le t_up and wd_in ne -9999)
;if ind ne [-1] then wd[i] =  mean(wd_in[ind]) else wd[i] = -9999

ncdf_close, id

endfor



openw, lun, fout, /get_lun

printf, lun, 'date    jdd   pressure   temp   RH    ws '

for j = 0, nfiles-1 do printf, lun, date[j], jdd[j], pres[j], temp[j], rh[j], ws[j], format = '(1a8, 1x, i3, 1x, 4(1f8.2, 1x))'

free_lun, lun



End
