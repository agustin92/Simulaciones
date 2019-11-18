#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 13 14:08:48 2019

@author: agustin
"""

import subprocess

#Poner el directorio donde se aloja el programa send jobs
path_directory = '/home/agustin/Documents/Materia/Practica_MD/Temperaturas'
densidad = 0.300
f = open('lista_temperaturas.dat','r')
for renglon in f:
    temp = renglon.rstrip()
    g = open('configuracion_ini.dat','w+')
    g.write('! Largo de la caja \n')
    g.write( str((200/0.3)**(1/3))+'\n')
    g.write('! N numero de particulas \n')
    g.write('200\n')
    g.write('! Numero de pasos de MD \n')
    g.write('1000000\n')
    g.write('! Paso temporal\n')
    g.write('0.0002\n')
    g.write('! Temperatura \n')
    g.write(temp+'\n')
    g.write('! Langevin gamma\n')
    g.write('0.5\n')
    g.close()
    for i in range(11):
        if i == 0 :
            print('Inicio simulacion {} de MD para temperatura {}'.format(i+1,temp))
            process0 = subprocess.run('mkdir ' + path_directory +'/{}'.format(temp),shell=True)
            process1 = subprocess.run('mkdir '+ path_directory+'/{}/RUN_{}'.format(temp,i+1), shell =True)
            process2 = subprocess.run('cp '+path_directory+'/0.300/inicial/input_pos.dat '+path_directory,shell=True )
            process3 = subprocess.run('cp '+path_directory+'/0.300/inicial/input_vel.dat '+path_directory,shell=True )
            process4 = subprocess.run('../simple', shell=True)
            process5 = subprocess.run('mv variables_fisicas.dat mean_measurement.dat '+path_directory+'/{}/RUN_{}'.format(temp,i+1),shell=True)
            process6 = subprocess.run('cp configuracion_ini.dat '+path_directory+'/{}/RUN_{}'.format(temp,i+1),shell=True)
            process7 = subprocess.run('cp input_pos.dat input_vel.dat '+path_directory+'/{}/RUN_{}'.format(temp,i+1),shell=True)
            process8 = subprocess.run('rm movie.vtf',shell=True)
            print('Finalizacion de simulacion {} de MD para temperatura {}'.format(i+1,temp))
        else:
            print('Inicio simulacion {} de MD para temperatura {}'.format(i+1,temp))
            process1 = subprocess.run('mkdir '+ path_directory+'/{}/RUN_{}'.format(temp,i+1), shell =True)
            process2 = subprocess.run('../simple', shell=True)
            if i == 10:
                process3 = subprocess.run('mv variables_fisicas.dat mean_measurement.dat movie.vtf '+path_directory+'/{}/RUN_{}'.format(temp,i+1),shell=True)
            else:
                process3a = subprocess.run('mv variables_fisicas.dat mean_measurement.dat '+path_directory+'/{}/RUN_{}'.format(temp,i+1),shell=True)
                process3b = subprocess.run('rm movie.vtf',shell=True)
            process4 = subprocess.run('cp configuracion_ini.dat '+path_directory+'/{}/RUN_{}'.format(temp,i+1),shell=True)
            process5 = subprocess.run('cp input_pos.dat input_vel.dat '+path_directory+'/{}/RUN_{}'.format(temp,i+1),shell=True)
            print('Finalizacion de simulacion {} de MD para temperatura {}'.format(i+1,temp))                
f.close()        
