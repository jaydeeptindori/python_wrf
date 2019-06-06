file_in = '$MEDIA/Seagate/data/GVAX_data/final/press/press.dat'
fout = '$MEDIA/Seagate/data/GVAX_data/final/humid/press_hrly_gmt_std.dat'
;.r '/home/jd/Desktop/idl_library/readcol.pro'
;/.r '/home/jd/itt/idl/lib/coyoteprograms/coyote/cgerrormsg.pro'
;.r '/usr/local/itt/idl706/lib/strsplit.pro'
;.r '/home/jd/Desktop/idl_library/remchar.pro'
;.r '/home/jd/Desktop/idl_library/gettok.pro'
;.r '/home/jd/Desktop/idl_library/strnumber.pro'
;read rh as ec
readcol, file_in, date, jddc, time, rh, format = 'a,f,f,f'

ec = rh
nlines = n_elements(ec)


tstd = findgen(24)+1
tlow = tstd-0.5
tup = tstd+0.5

nt = n_elements(tstd)




ndays = 1 ; the follwong line was nlines-2; in next line nlines - 2 is taken because date[i+1] will be out of date array

for i = 0.0d, nlines-2 do if date[i] ne date[i+1]then ndays = ndays +1 
print,  date[i] & date_unq = strarr(ndays) & jdd_unq = fltarr(ndays)
help, date

q = 0

for i = 0.0d, nlines-2 do if date[i] ne date[i+1] then begin & date_unq[q] = date[i] & jdd_unq[q] = jddc[i] & q = q + 1 & endif

date_unq[ndays-1] = date[nlines-1]
jdd_unq[ndays-1] = jddc[nlines-1]

help, date_unq, date

dim = nt*ndays

date_fnl = strarr(dim)
jdd_fnl = fltarr(dim)
hh_fnl = intarr(dim)

ec_fnl = fltarr(dim)
sum = fltarr(dim)
cnt = fltarr(dim)


q = 0.0d

for j = 0, ndays-1 do begin & for k = 1, 24 do begin & if k ne 24 then begin & for l = 0.0d, nlines-1 do if jdd_unq[j] eq jddc[l] and time[l] gt tlow[k-1] and time[l] le tup[k-1] then begin & sum[q] = sum[q] + ec[l] & cnt[q] = cnt[q] + 1 & endif  & endif else begin & for l = 0.0d, nlines-1 do if (jdd_unq[j] eq jddc[l] and time[l] gt tlow[k-1]) or (jdd_unq[j]+1 eq jddc[l] and time[l] le tlow[0]) then begin & sum[q] = sum[q] + ec[l] & cnt[q] = cnt[q] + 1 & endif & endelse & if cnt[q] gt 0 then ec_fnl[q] = sum[q]/float(cnt[q]) else ec_fnl[q] = -9999.0 & date_fnl[q] = date_unq[j] & jdd_fnl[q] = jdd_unq[j] & hh_fnl[q] = k & q = q + 1.0d &  endfor & endfor

 
openw, lun, fout, /get_lun
printf, lun, 'Date	hh    jddc    humid'
for q = 0.0d, dim-1 do if ec_fnl[q] ne -9999 then printf, lun, date_fnl[q],  jdd_fnl[q], hh_fnl[q], ec_fnl[q], format = '(1a8, 1x, i3, 1x, i5.2, 1x, f6.2)'
free_lun, lun
end

