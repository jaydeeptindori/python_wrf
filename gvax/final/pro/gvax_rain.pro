fout = strcompress('/run/media/jaydeep/Seagate/data/GVAX_data/rain.dat', /remove_all)

path = '/run/media/jaydeep/Seagate/data/GVAX_data/raw/met/'

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

;because block statement is not allowed in the idl programming
for i=0, nfiles-1 do begin 
	 print, 'running =', 1+i, ' out of ', nfiles 
	 Date[i]=STRMID(files[i], len+12, 8) 
	 yy[i]=float(strmid(date[i], 0, 4)) 
	 mm[i] = float(strmid(date[i], 4, 2)) 
	 dd[i] =float(strmid(date[i], 6, 2)) 
	 if yy[i] mod 4 eq 0 then for k = 2, 11 do ndd[k] = ndd[k] + 1 
	 print, ndd 
	 jdd[i]=ndd[mm[i]-1] + dd[i] 
	 filename[i] = files[i] 
 endfor

for i=0, nfiles-1 do begin 
	id[i] = ncdf_open(filename[i]) 
	ncdf_varget, id[i], 'time', time 
	time = time/3600.0d 
	ncdf_varget, id[i], 'pwd_cumul_rain', ws_in 
	ncdf_varget, id[i], 'qc_pwd_cumul_rain', qc4 
	ncdf_close, id[i] 
	data = ws_in 
	dim = n_elements(data) 
	openw, lun, fout, /get_lun, /append 
	for q = 0, dim-1 do printf, lun, date[i], jdd[i], time[q], data[q], qc4[q], format = '(1a8, 2x, 1i5, 2x, f5.2, 2x, f15.5, 2x, f5.2, 1x)'
	free_lun, lun 
endfor
end


;data = ws_in[ind]
;& 

