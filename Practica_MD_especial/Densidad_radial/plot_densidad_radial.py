#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 20 14:43:20 2019

@author: agustin
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

datos = pd.read_csv("salida_gr.dat")
#datos['X_norm'] = 0.5*datos[' x']
datos.plot(x= ' r',y='g(r)')
plt.show()