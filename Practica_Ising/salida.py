#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 16:03:56 2019

@author: agustin
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

datos = pd.read_csv("salida.dat")
#datos['X_norm'] = 0.5*datos[' x']
#hist = datos.hist(bins=20)
#plt.show()

datos.plot(y='Magnetization')
datos.plot(y=' Energy')
plt.show()