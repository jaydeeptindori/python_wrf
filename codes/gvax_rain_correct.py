# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import numpy as np
import glob
import matplotlib.pyplot as plt
from datetime import datetime, timedelta
from matplotlib import rcParams
rcParams['font.family'] = 'serif'
rcParams['font.size'] = 12


start = datetime.strptime("11-06-2011", "%d-%m-%Y")
end = datetime.strptime("01-10-2011", "%d-%m-%Y")
date_generated = [start + timedelta(days=x) for x in range(0, (end-start).days)]
date1 =[]
date2 =[]
for date in date_generated:
    date1.append(date.strftime("%Y%m%d"))
    date2.append(date.strftime("%b%d"))
file = '/run/media/jaydeep/F2AC-315E/codes/python/rain_gvax.txt'

date, jdd, hh, pcp, qc_pcp = np.loadtxt(file, unpack=True, dtype ='str')


date_out=[]
jdd_out=[]
hh_out=[]
pcp_out=[] 
qc_out = []



j = np.where(pcp != '--')

date = date[j]
jdd = jdd[j]
hh = hh[j]
pcp = pcp[j]
qc_out = qc_pcp[j]


for i in range(len(date)-1):
    if i ==0:
        date_out.append(date[i])
        jdd_out.append(jdd[i])
        hh_out.append(hh[i])
        pcp_out.append(float(pcp[i]))
    elif (float(pcp[i]) >= float(pcp[i-1]) and (float(pcp[i]) - float(pcp[i-1]))<35):
        
        date_out.append(date[i])
        jdd_out.append(jdd[i])
        hh_out.append(hh[i])
        pcp_out.append(float(pcp[i])-float(pcp[i-1]))
        #qc_pcp.append(float(qc_pcp[i])-float(pcp[i-1]))
    
    else:
        print, (date[i], hh[i], jdd[i], pcp[i])
        

#DAT =  np.column_stack((date_out, jdd_out, hh_out, np.array(pcp_out, dtype='float')))

#np.savetxt('rain_jjas_final.txt', DAT, delimiter=" ", fmt="%s %s %s %10.2f") 

f = open('rain_gvax_jjas.txt', 'w+')
for i in range(len(date_out)):
    f.write("%s         %s          %s          %10.2f  \r\n" %(date_out[i], jdd_out[i], hh_out[i], pcp_out[i]))
f.close()



#final section for the data:
#u represent the unique

date_u = np.unique(date)
hh_tmp = []
[hh_tmp.append(int(i[0:2])) for i in hh_out]
hh_u = np.unique(hh_tmp)

#Daily accumulated 
date_out = np.array(date_out)
pcp_out = np.array(pcp_out)
date_f = []
rain_f = []


for i in range(len(date1)):
    kk = np.where(np.array(date_u) == date1[i])
    
    if len(kk[0]) !=0:
        date_f.append(date_u[kk[0][0]])
        j = np.where(date_out == date_u[kk[0][0]])
        if j[0].shape[0] > 10:
            print(j[0])
            rain_f.append(sum(pcp_out[j[0]]))
        else:
            rain_f.append(-10)
    else:
        date_f.append(date1[i])
        rain_f.append(-10)
rain_f = np.array(rain_f, dtype=float)
            
rain_f1 = np.ma.array(rain_f, mask=[rain_f==-10])


f = open('rain_gvax_jjas_finallycorrected.txt', 'w+')
for i in range(len(date_f)):
    f.write("%s          %10.2f  \r\n" %(date_f[i],  rain_f[i]))
f.close()


plt.figure(figsize=(12, 2.5))
dummy = np.linspace(0, len(date_f)-1, len(date_f))        
plt.plot(dummy, rain_f1, 'o', color='red')
plt.plot(dummy, rain_f1, 'k-', color='red')
plt.xticks(dummy[0::5], date2[::5] , rotation=75)
plt.xlabel("Time")
plt.ylim(0, 85)
plt.ylabel("Daily Rainfall (mm) ")
plt.grid(linestyle='dotted')
    



