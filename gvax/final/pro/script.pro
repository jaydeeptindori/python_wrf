fin1= '/home/jd/GVAX_data/wd_LST.dat'
fin2= '/home/jd/GVAX_data/ws_LST.dat'
;fout= '/home/jd/GVAX_data/final/wd_ws_LST.dat'
n1   = file_lines(fin1)
date1  = lonarr(n1)
hh1 = fltarr(n1)
jdd1  = lonarr(n1)
wd   = fltarr(n1)

n2   = file_lines(fin2)
date2  = lonarr(n2)
hh2 = fltarr(n2)
jdd2  = lonarr(n2)
ws   = fltarr(n2)

help, n1, n2

x0=0
y0=0
z0= 0.0
z1=0.0

;OPENR, lun, fin1, /GET_LUN
;for i = 0, n-1 Do Begin & READF, lun, x0, y0, z0, z1 & date[i]=x0 & hh[i]=y0 & jdd[i]= z0 & wd[i]=z1 & endfor 
;free_lun, lun


;for i = 0, n-1 do hh[i] = hh[i] + 5.5 & for i = 0l, n-1l do j= where(hh gt 24.00, jcount) & hh[j] = hh[j]-24
 
;for i = 0, n-1 do k = where(hh gt 0.0 and hh le 6.0) & jdd[k] = jdd[k]+1 & date[k] = date[k] + 1

;if date[i+1] ne date[i] and hh[i] ge 0.0 and hh[i] le 6 then date[i] = date[i+ 1]
;help, i
;for i = 0, n_elements(date)-1 do print, date[i], hh[i] 

;openw, lun, fout, /get_lun
;printf, lun, 'Date	lhh    jddc    wd'
;for i = 0, n-1 do if date[i] ne -9999 then printf, lun, date[i], hh[i], jdd[i], ws[i], format = '(I8, 1x, f5.2, 1x, i3, 1x, f7.3)
;free_lun, lun
