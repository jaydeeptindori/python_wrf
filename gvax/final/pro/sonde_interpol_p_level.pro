compile_opt idl2

path = '/run/media/jaydeep/Seagate/data/GVAX_data/raw/sonde/'
files = file_search(path + 'pgh*.cdf', count = nfiles)

len = strlen(path+'pghsondewnpnM1.b1.') + 9
date = strmid(files, len-9, 8)
tt = strmid(files, len, 4)
hh = float(strmid(tt, 0, 2))
minut = float(strmid(tt, 2, 2))

ltime = fltarr(nfiles)
filename=strarr(nfiles)


ndd = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
yy=fltarr(nfiles)
dd=fltarr(nfiles)
mm=fltarr(nfiles)
jdd = fltarr(nfiles)

for i1=0, nfiles-1 do begin
	yy[i1]=float(strmid(date[i1], 0, 4))
	mm[i1] = float(strmid(date[i1], 4, 2)) 
	dd[i1] =float(strmid(date[i1], 6, 2)) 
	jdd[i1] = ndd[mm[i1]-1] + dd[i1] 
endfor 
	
j= where(date gt 20120229, jcount) 
   jdd[j] = jdd[j]+1

for i = 0, nfiles-1 do ltime[i] = hh[i] + minut[i]/60.0 


dates = strmid(files, len-9,8)
readcol, '/run/media/jaydeep/Seagate/data/GVAX_data/final/sonde/altitude.dat', alt_out1
readcol, '/run/media/jaydeep/Seagate/data/GVAX_data/final/sonde/pressure_level.dat', p_level
alt_out = p_level
dim = n_elements(alt_out)
temp_out = dblarr(dim)
rh_out = dblarr(dim)
wspd_out = dblarr(dim)
pres_out = dblarr(dim)
help, dim
; for diff files
;for i = 0, nfiles-1 do begin &  & endfor

for i = 0, nfiles-1 do begin
	filename[i] = files[i] 
	print, 'running =', 1+i, ' out of ', nfiles
		id = ncdf_open(filename[i])
		ncdf_varget, id, 'tdry', tdry
		ncdf_varget, id, 'rh', rh 
		ncdf_varget, id, 'alt', alt
		ncdf_varget, id, 'wspd', wspd
		ncdf_varget, id, 'pres', pres 
		ncdf_varget, id, 'qc_tdry', qc1 
		ncdf_varget, id, 'qc_rh', qc2 
		ncdf_varget, id, 'qc_wspd', qc3
		ncdf_varget, id, 'qc_pres', qc4
		ncdf_close, id 
;;The interpolation of temperature
;alt_in = alt
tdry_in = tdry
ind = where( qc1 eq 0.0 and tdry ne -9999 and tdry ge -90 and tdry le 50. and qc4 eq 0. and pres ne -9999 and pres lt 1100 and pres gt 0)
;alt = alt[ind]
tdry = tdry[ind]
pres= pres[ind]
alt = pres

;if n_elements(tdry) eq n_elements(alt) and n_elements(alt) gt 100 then pp = interpol(tdry, alt, alt_out)
;help, pp

nlines = n_elements(tdry)
;i set the variable var for variable whatever i m using
var = tdry
help, dim
 for j = 0.0d, dim-1 do begin 
	limit = [alt_out[j]-20, alt_out[j]+20] 
	ind_l = where(alt lt alt_out[j] and alt ge limit[0] and alt le limit[1]) 
	ind_u = where(alt gt alt_out[j] and alt ge limit[0] and alt le limit[1])
	;print, limit & print, 'ind_l', ind_l, & print, 'ind_u', ind_u & 
	;endfor
  
        if ind_l ne [-1] and ind_u ne [-1] then begin
        alt_l = alt[ind_l]
        var_l = var[ind_l]
        alt_u = alt[ind_u]
        var_u = var[ind_u]
        ind1 = where(alt_l eq max(alt_l))
        ind2 = where(alt_u eq min(alt_u))
        tmp_alt = [alt_l[ind1], alt_u[ind2]]
        tmp_var = [var_l[ind1], var_u[ind2]]
        ;print, tmp_var, tmp_alt, j;, alt_out[j]
        temp_out[j] = interpol(tmp_var, tmp_alt, alt_out[j])
        endif  else begin
        temp_out[j] = -9999
        endelse
 endfor; for given altitude


;The follwoing block is for relative humidity
ind = where(qc2 eq 0 and rh ne -9999 and rh ge 0.0 and rh le 100.0 and qc4 eq 0. and pres ne -9999 and pres lt 1100 and pres gt 0)
pres= pres[ind]
alt = pres
rh_in = rh[ind]

var = rh
for j = 0.0d, dim-1.0 do begin
limit = [alt_out[j]-20, alt_out[j]+20]
ind_l = where(alt lt alt_out[j] and alt ge limit[0] and alt le limit[1])
ind_u = where(alt gt alt_out[j] and alt ge limit[0] and alt le limit[1])
  
        if ind_l ne [-1] and ind_u ne [-1] then begin
        alt_l = alt[ind_l]
        var_l = var[ind_l]
        alt_u = alt[ind_u]
        var_u = var[ind_u]
;
        ind1 = where(alt_l eq max(alt_l))
        ind2 = where(alt_u eq min(alt_u))
        tmp_alt = [alt_l[ind1], alt_u[ind2]]
        tmp_var = [var_l[ind1], var_u[ind2]]
        rh_out[j] = interpol(tmp_var, tmp_alt, alt_out[j])
        endif  else begin
        rh_out[j] = -9999
        endelse
endfor; for given altitude

; This block is for the wind speed data interpolation
 wspd_in=wspd
 ind = where(qc3 eq 0 and wspd ne -9999 and wspd ge 0 and wspd le 100 and qc4 eq 0. and pres ne -9999 and pres lt 1100 and pres gt 0) 
	pres= pres[ind]
	alt = pres
	  wspd = wspd[ind] 
	var = wspd
for j = 0.0d, dim-1.0 do begin
limit = [alt_out[j]-20, alt_out[j]+20]
ind_l = where(alt lt alt_out[j] and alt ge limit[0] and alt le limit[1])
ind_u = where(alt gt alt_out[j] and alt ge limit[0] and alt le limit[1])
  
      if ind_l ne [-1] and ind_u ne [-1] then begin
        alt_l = alt[ind_l]
        var_l = var[ind_l]
        alt_u = alt[ind_u]
        var_u = var[ind_u]

        ind1 = where(alt_l eq max(alt_l))
        ind2 = where(alt_u eq min(alt_u))
        tmp_alt = [alt_l[ind1], alt_u[ind2]]
        tmp_var = [var_l[ind1], var_u[ind2]]
        wspd_out[j] = interpol(tmp_var, tmp_alt, alt_out[j])
        endif  else begin
        wspd_out[j] = -9999
        endelse
endfor; for given altitude
; this block gives the separate .dat file for each radiosonde with interpolated at tabulated altitude in altitude.dat

openw, lun, strcompress('/run/media/jaydeep/Seagate/data/GVAX_data/final/sonde/p_level_sonde_data_inter.dat', /remove_all), /get_lun, /append
;printf, lun, 'date, ltime, atl, temp, rh, wspd'
for j = 0.0d, dim-1 do printf, lun, date[i], jdd[i], ltime[i], alt_out[j], temp_out[j], rh_out[j], wspd_out[j], format = '(I8, 1x, I5, 1x, f6.1, 1x, 1f7.1, 1x, f8.1, 1x, f8.1, 1x, f8.1, 2x)
free_lun, lun
; the follwoing files are the complete set of variable with different altitudes
;nlines1 = n_elements(rh_in)
;openw, lun, strcompress('/run/media/jd/Seagate/data/GVAX_data/final/sonde/alt_in/sonde_' + string(dates[i]) + '_' + string(tt[i]) + '.dat', /remove_all), /get_lun
;openw, lun, strcompress('/run/media/jd/Seagate/data/GVAX_data/final/sonde/sonde_data.dat', /remove_all), /get_lun, /append
;for j = 0.0d, nlines1-1 do printf, lun, date[i], jdd[i], ltime[i], alt_in[j], tdry_in[j], rh_in[j], wspd_in[j], format = '(I8, 1x, I5, 1x, f6.1, 1x, 1f7.1, 1x, f8.1, 1x, f8.1, 1x, f8.1)' 


endfor; the major loop for opening files on loop
end
