#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 16:03:56 2019

@author: agustin
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

datos = pd.read_csv("variables_fisicas.dat")
#datos['X_norm'] = 0.5*datos[' x']
datos.plot(x= ' Tiempo',y=['Energia_pot','Energia_cin','Energia'])
datos.plot(x= ' Tiempo',y='Temperatura_md')
plt.show()