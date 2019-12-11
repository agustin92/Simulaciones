#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 11 14:15:17 2019

@author: agustin
"""

import pandas as pd
import matplotlib.pyplot as plt

datos = pd.read_csv('perfiles.dat')

datos.plot(x=' Distacia_radial', y='Temperatura')
datos.plot(x=' Distacia_radial', y='Densidad')

datos2 = pd.read_csv('variables_fisicas.dat')
datos2.plot(x=' Tiempo', y='Temperatura_md')
#datos2.plot(x=' Tiempo', y=['Energia_pot','Energia_cin','Energia'])
plt.show()