#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 15:56:24 2019

@author: agustin
"""

import subprocess
import numpy as np

#pi = []
# completed = subprocess.run(['ls','-1'])


completed = subprocess.run('make',shell=True)
print('returncode: ',completed.returncode)
completed2 = subprocess.run('./simple >salida.csv',shell=True)
#completed2 = subprocess.run('./simple ',shell=True)
#print('returncode: ',completed2.returncode)
#completed3 = subprocess.run('vim salida.dat',shell=True) 
#for i in range(50):
#    completed = subprocess.run('./simple',stdout=subprocess.PIPE,)
#    pi.append(float(completed.stdout.decode('utf-8')))
#    print(pi[i])

#pi_array = np.array(pi)
#print(np.mean(pi_array))


