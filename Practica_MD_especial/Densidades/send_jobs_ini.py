#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Oct  4 18:15:38 2019

@author: agustin
"""

import subprocess
#import numpy as np

#pi = []
# completed = subprocess.run(['ls','-1'])

#Poner el directorio donde se aloja el programa send jobs
path_directory = '/home/agustin/Documents/Materia2/Practica_MD/Densidades'

#h = open('control.h','w+')
#for renglon in h:
#    h.write('/*  variables de preprocessing */ \n')
#    h.write('\n')
#    h.write('/* Uso el potencial de L-J infinito define undef */ \n')
#    h.write('#undef pot_inf \n')
#    h.write('\n')
#    h.write('/* Rutina de inicializacion del sistema para evitar solapamiento de particulas */ \n')
#    h.write('#define initialize')
#    h.write('\n')
#    h.write('/* Velocitiy verlet */ \n')
#    h.write('#undef velocity_verlet')
#    h.write('\n')
#    h.write('/* Grabar la secuencia de posiciones para vmd */ \n')
#    h.write('#undef movie')
#    h.write('\n')
#    h.write('/* Termostato NVT - Langevin */ \n')
#    h.write('#undef thermostat_NVT')
            
f = open('lista_densidades.dat','r')
for renglon in f:
    densidad = renglon.rstrip()
    l = (200/float(densidad))**(1/3)
    g = open('configuracion_ini.dat','w+')
    g.write('! Largo de la caja \n')
    g.write(str(l)+'\n')
    g.write('! N numero de particulas \n')
    g.write('200\n')
    g.write('! Numero de pasos de MD \n')
    g.write('500000\n')
    g.write('! Paso temporal\n')
    g.write('0.000001\n')
    g.write('! Temperatura \n')
    g.write('1.1\n')
    g.write('! Langevin gamma\n')
    g.write('0.5\n')
    g.close()
    print('Inicio simulacion de inicializacion para densidad {}'.format(densidad))
    process1 = subprocess.run('mkdir {}'.format(densidad), shell = True)
    process2 = subprocess.run('mkdir '+ path_directory+'/{}/inicial'.format(densidad), shell =True)
    process3 = subprocess.run('../simple', shell=True)
    process4 = subprocess.run('mv variables_fisicas.dat '+path_directory+'/{}/inicial'.format(densidad),shell=True)
    process5 = subprocess.run('cp configuracion_ini.dat '+path_directory+'/{}/inicial'.format(densidad),shell=True)
    process6 = subprocess.run('mv input_pos.dat input_vel.dat '+path_directory+'/{}/inicial'.format(densidad),shell=True)
    print('Finalizacion de simulacion de inicializacion para densidad {}'.format(densidad))
f.close()        








