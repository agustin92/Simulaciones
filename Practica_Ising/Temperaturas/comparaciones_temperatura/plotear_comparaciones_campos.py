#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct 15 11:02:23 2019

@author: luciana
"""

import matplotlib.pyplot as plt
import numpy as np
import os


folder = '/home/luciana/Documentos/Simulaciones-master/Practica_Ising/Temperaturas/comparaciones_temperatura'

new_folder_name = 'comparacion_campos'
save_folder = os.path.join(folder, new_folder_name)
if not os.path.exists(save_folder):
    os.makedirs(save_folder)

data_20_B_nulo = np.genfromtxt('all_data_temperature_20_B0.csv', delimiter='')
data_20_B_001 = np.genfromtxt('all_data_temperature_20_B0.01.csv', delimiter='')
data_20_B_010 = np.genfromtxt('all_data_temperature_20_B0.1.csv', delimiter='')

temperature = data_20_B_nulo [0:,0]
energy = data_20_B_nulo [0:,1]
err_energy = data_20_B_nulo [0:,2]
cv  = data_20_B_nulo [0:,4]
magnetization  = data_20_B_nulo [0:,5]
err_magnetization = data_20_B_nulo [0:,6]
x  = data_20_B_nulo [0:,8]
Neff  = data_20_B_nulo [0:,9]

temperature_001 = data_20_B_001[0:,0]
energy_001 = data_20_B_001[0:,1]
err_energy_001 = data_20_B_001[0:,2]
cv_001  = data_20_B_001[0:,4]
magnetization_001  = data_20_B_001[0:,5]
err_magnetization_001 = data_20_B_001[0:,6]
x_001  = data_20_B_001[0:,8]
Neff_001  = data_20_B_001[0:,9]

temperature_010 = data_20_B_010[0:,0]
energy_010 = data_20_B_010[0:,1]
err_energy_010 = data_20_B_010[0:,2]
cv_010  = data_20_B_010[0:,4]
magnetization_010  = data_20_B_010[0:,5]
err_magnetization_010 = data_20_B_010[0:,6]
x_010  = data_20_B_010[0:,8]
Neff_010  = data_20_B_010[0:,9]

print('Grafico energía')
plt.figure()
plt.errorbar(temperature, energy, yerr = err_energy,linestyle = 'none', marker = 'o', label = 'Campo B = 0.00')
plt.errorbar(temperature_001, energy_001, yerr = err_energy_001,linestyle = 'none', marker = 'o', label = 'Campo B = 0.01')
plt.errorbar(temperature_010, energy_010, yerr = err_energy_010,linestyle = 'none', marker = 'o', label = 'Campo B = 0.10')
plt.xlabel('Temperatura')
plt.ylabel('Energía')
plt.legend()
plt.xlim(0,4.1)
figure_name = os.path.join(save_folder, 'energy_vs_temperature.png')
plt.savefig(figure_name, dpi = 400)
plt.close()

print('Grafico Cv')
plt.figure()
plt.plot(temperature, cv, 'o', label = 'Campo B = 0.00')
plt.plot(temperature_001, cv_001, 'o', label = 'Campo B = 0.01')
plt.plot(temperature_010, cv_010, 'o', label = 'Campo B = 0.10')
plt.xlabel('Temperatura')
plt.ylabel('Cv')
plt.legend()
plt.xlim(0,4.1)
figure_name = os.path.join(save_folder, 'cv_vs_temperature.png')
plt.savefig(figure_name, dpi = 400)
plt.close()

print('Grafico Magnetización')
plt.figure()
plt.errorbar(temperature, magnetization/(20*20), yerr = err_magnetization/(20*20),linestyle = 'none',marker = 'o', label = 'Campo B = 0.00')
plt.errorbar(temperature_001, magnetization_001/(20*20), yerr = err_magnetization_001/(20*20),linestyle = 'none',marker = 'o', label = 'Campo B = 0.01')
plt.errorbar(temperature_010, magnetization_010/(20*20), yerr = err_magnetization_010/(20*20),linestyle = 'none',marker = 'o', label = 'Campo B = 0.10')
plt.xlabel('Temperatura')
plt.ylabel('Magnetización')
plt.legend()
plt.xlim(0, 4.1)
figure_name = os.path.join(save_folder, 'M_vs_temperature.png')
plt.savefig(figure_name, dpi = 400)
plt.close()

print('Grafico X susceptibilidad magnetica')
plt.figure()
plt.plot(temperature, x, 'o', label = 'Campo B = 0.00')
plt.plot(temperature_001, x_001, 'o', label = 'Campo B = 0.01')
plt.plot(temperature_010, x_010, 'o', label = 'Campo B = 0.10')
plt.xlabel('Temperatura')
plt.ylabel('X susceptibilidad magnética')
plt.legend()
plt.xlim(0,4.1)
figure_name = os.path.join(save_folder, 'x_vs_temperature.png')
plt.savefig(figure_name, dpi = 400)
plt.close()

print('Grafico Neff')
plt.figure()
plt.plot(temperature, Neff, 'o', label = 'Campo B = 0.00')
plt.plot(temperature_001, Neff_001, 'o', label = 'Campo B = 0.01')
plt.plot(temperature_010, Neff_010, 'o', label = 'Campo B = 0.10')
plt.xlabel('Temperatura')
plt.ylabel('N aceptados/N total')
plt.legend()
plt.xlim(0,4.1)
figure_name = os.path.join(save_folder, 'Neff_temperature.png')
plt.savefig(figure_name, dpi = 400)
plt.close()
