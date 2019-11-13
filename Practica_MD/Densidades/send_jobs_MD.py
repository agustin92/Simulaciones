#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 13 14:08:48 2019

@author: agustin
"""

import subprocess

#Poner el directorio donde se aloja el programa send jobs
path_directory = '/home/agustin/Documents/Materia2/Practica_MD/Densidades'

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
    g.write('1000000\n')
    g.write('! Paso temporal\n')
    g.write('0.0002\n')
    g.write('! Temperatura \n')
    g.write('1.1\n')
    g.write('! Langevin gamma\n')
    g.write('0.5\n')
    g.close()
    for i in range(11):
        print('Inicio simulacion {} de MD para densidad {}'.format(i+1,densidad))
        process1 = subprocess.run('mkdir '+ path_directory+'/{}/RUN_{}'.format(densidad,i+1), shell =True)
        process2 = subprocess.run('cp '+path_directory+'/{}/inicial/input_pos.dat '.format(densidad)+path_directory,shell=True )
        process3 = subprocess.run('cp '+path_directory+'/{}/inicial/input_vel.dat '.format(densidad)+path_directory,shell=True )
        process3 = subprocess.run('../simple', shell=True)
        process4 = subprocess.run('mv variables_fisicas.dat mean_measurement.dat movie.vtf '+path_directory+'/{}/RUN_{}'.format(densidad,i+1),shell=True)
        process5 = subprocess.run('cp configuracion_ini.dat '+path_directory+'/{}/RUN_{}'.format(densidad,i+1),shell=True)
        process6 = subprocess.run('mv input_pos.dat input_vel.dat '+path_directory+'/{}/RUN_{}'.format(densidad,i+1),shell=True)
        print('Finalizacion de simulacion {} de MD para densidad {}'.format(i+1,densidad))
f.close()        