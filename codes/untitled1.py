#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May 12 17:23:23 2019

@author: jaydeep
"""

#!/usr/bin/env python3
import numpy as np        
f=open('/home/jaydeep/asd.dat','ab')
for iind in range(4):
    a=np.random.rand(10,10)
    np.savetxt(f, np.c_[a[1], a[2]], delimiter="\t")
f.close()