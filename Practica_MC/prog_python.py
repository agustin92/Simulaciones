#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 15:56:24 2019

@author: agustin
"""

import subprocess




completed = subprocess.run('make',shell=True)
print('returncode: ',completed.returncode)
completed2 = subprocess.run('./simple >salida.csv',shell=True)
#completed2 = subprocess.run('./simple ',shell=True)




