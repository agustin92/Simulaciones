#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 11 14:15:17 2019

@author: agustin
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import re

def folder_temperature(folder):

    list_of_folder = os.listdir(folder)
    list_of_folder = [f for f in list_of_folder if (re.search('RUN',f))]
    list_of_folder.sort()
    
    L = len(list_of_folder)
    
    file = os.path.join(folder, list_of_folder[0], 'perfiles.dat')
    datos = np.loadtxt(file, delimiter = ',', skiprows = 1)    
    distancia_radial = datos[:, 0]
    temperatura = datos[:, 1]
    densidad = datos[:, 2]
    
    for i in range(1, L):
        
        file = os.path.join(folder, list_of_folder[i], 'perfiles.dat')
        
        datos = np.loadtxt(file, delimiter = ',', skiprows = 1)
        temperatura = temperatura + datos[:, 1]
        densidad = densidad + datos[:, 2]
        
    temperatura = temperatura/L
    densidad = densidad/L

    return distancia_radial, temperatura, densidad

def plot_temperature(path_directory):
    
    list_of_folder = os.listdir(path_directory)
    list_of_folder = [f for f in list_of_folder if not (re.search('tar',f)) and not (re.search('png', f)) ]
    list_of_folder.sort()
    print('Temperaturas', list_of_folder)
    
    L = len(list_of_folder)
    
    plt.figure()
    
    for i in range(L):
        
        folder = os.path.join(path_directory, list_of_folder[i])
        distancia_radial, temperatura, densidad = folder_temperature(folder)
        
        plt.plot(distancia_radial, temperatura, label = '%s'%list_of_folder[i])
        plt.xlabel('Distancia radial')
        plt.ylabel('Perfil de Temperatura')
    
        
    plt.xlim(4, 11)
    plt.legend(loc = 'upper right')
    
    
    name_fig = os.path.join(path_directory, 'perfil_temperatura_epislon_0.png')
    
    plt.savefig(name_fig, dpi = 400)
        
    plt.show()
    
    return

def plot_density(path_directory):
    
    list_of_folder = os.listdir(path_directory)
    list_of_folder = [f for f in list_of_folder if not (re.search('tar',f)) and not (re.search('png', f)) ]
    list_of_folder.sort()
    print('Temperaturas', list_of_folder)
    
    L = len(list_of_folder)
    
    plt.figure()
    
    for i in range(L):
        
        folder = os.path.join(path_directory, list_of_folder[i])
        distancia_radial, temperatura, densidad = folder_temperature(folder)
        
        plt.plot(distancia_radial, densidad, label = '%s'%list_of_folder[i])
        plt.xlabel('Distancia radial')
        plt.ylabel('Perfil de Densidad')
    
    plt.xlim(4, 11)
    plt.legend(loc = 'upper right')
    
    name_fig = os.path.join(path_directory, 'perfil_densidad_epislon_0.png')
    
    plt.savefig(name_fig, dpi = 400)
        
    plt.show()
    
    return
    
    
#%%

path_directory = '/home/agustin/Documents/Materia/Simulaciones/Practica_MD_especial/hola'

plot_temperature(path_directory)
plot_density(path_directory)








    

