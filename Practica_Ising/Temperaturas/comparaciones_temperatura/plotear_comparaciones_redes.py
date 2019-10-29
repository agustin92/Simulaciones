#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct 15 11:02:23 2019

@author: luciana
"""

import matplotlib.pyplot as plt
import numpy as np
import os

# Parent folder Agustin
# /home/agustin/Documents/Simulaciones/Practica_Ising/Temperaturas
# Parent folder Luciana
# '/home/luciana/Documentos/Simulaciones-master/Practica_Ising/Temperaturas/comparaciones_temperatura'

folder = '/home/agustin/Documents/Simulaciones/Practica_Ising/Temperaturas/comparaciones_temperatura'

new_folder_name = 'comparacion_redes'
save_folder = os.path.join(folder, new_folder_name)
if not os.path.exists(save_folder):
    os.makedirs(save_folder)

data_20_B_nulo = np.genfromtxt('all_data_temperature_20_B0.csv', delimiter='')
data_40_B_nulo = np.genfromtxt('all_data_temperature_40_B0.csv', delimiter='')

temperature = data_20_B_nulo [0:,0]
energy = data_20_B_nulo [0:,1]
err_energy = data_20_B_nulo [0:,2]
cv  = data_20_B_nulo [0:,4]
magnetization  = data_20_B_nulo [0:,5]
err_magnetization = data_20_B_nulo [0:,6]
x  = data_20_B_nulo [0:,8]
Neff  = data_20_B_nulo [0:,9]

temperature_40 = data_40_B_nulo [0:,0]
energy_40 = data_40_B_nulo [0:,1]
err_energy_40 = data_40_B_nulo [0:,2]
cv_40  = data_40_B_nulo [0:,4]
magnetization_40  = data_40_B_nulo [0:,5]
err_magnetization_40 = data_40_B_nulo [0:,6]
x_40  = data_40_B_nulo [0:,8]
Neff_40  = data_40_B_nulo [0:,9]


print('Grafico energía')
plt.figure()
plt.errorbar(temperature, energy, yerr = err_energy,linestyle = 'none', marker = 'o', label = 'Red 20x20')
plt.errorbar(temperature_40, energy_40, yerr = err_energy_40,linestyle = 'none', marker = 'o', label = 'Red 40x40')
plt.xlabel('Temperatura')
plt.ylabel('Energía')
plt.xlim(0,4.1)
plt.legend()
figure_name = os.path.join(save_folder, 'energy_vs_temperature.png')
plt.savefig(figure_name, dpi = 400)
plt.close()

print('Grafico Cv')
plt.figure()
plt.plot(temperature, cv, 'o', label = 'Red 20x20')
plt.plot(temperature_40, cv_40, 'o', label = 'Red 40x40')
plt.xlabel('Temperatura')
plt.ylabel('Cv')
plt.legend()
plt.xlim(0,4.1)
figure_name = os.path.join(save_folder, 'cv_vs_temperature.png')
plt.show()
plt.savefig(figure_name, dpi = 400)
#plt.close()

print('Grafico Magnetización')
plt.figure()
plt.errorbar(temperature, magnetization, yerr = err_magnetization,linestyle = 'none',marker = 'o', label = 'Red 20x20')
plt.errorbar(temperature_40, magnetization_40, yerr = err_magnetization_40,linestyle = 'none',marker = 'o', label = 'Red 40x40')
plt.xlabel('Temperatura')
plt.ylabel('Magnetización')
plt.legend()
plt.xlim(0, 4.1)
figure_name = os.path.join(save_folder, 'M_vs_temperature.png')
plt.savefig(figure_name, dpi = 400)
plt.close()

print('Grafico X susceptibilidad magnetica')
plt.figure()
plt.plot(temperature, x, 'o', label = 'Red 20x20')
plt.plot(temperature_40, x_40, 'o', label = 'Red 40x40')
plt.xlabel('Temperatura')
plt.ylabel('X susceptibilidad magnética')
plt.legend()
plt.xlim(0,4.1)
figure_name = os.path.join(save_folder, 'x_vs_temperature.png')
plt.show()
plt.savefig(figure_name, dpi = 400)
#plt.close()

print('Grafico Neff')
plt.figure()
plt.plot(temperature, Neff, 'o', label = 'Red 20x20')
plt.plot(temperature_40, Neff_40, 'o', label = 'Red 40x40')
plt.xlabel('Temperatura')
plt.ylabel('N aceptados/N total')
plt.legend()
plt.xlim(0,4.1)
figure_name = os.path.join(save_folder, 'Neff_temperature.png')
plt.savefig(figure_name, dpi = 400)
plt.close()
