import numpy as np
import matplotlib.pyplot as plt
import os
import re
			

def open_data_step1(folder):

	list_of_folder = os.listdir(folder)
	list_of_folder.sort()

	list_of_folder = [f for f in list_of_folder if not (re.search('figuras',f))]

	L = len(list_of_folder)
	print('Carpetas:', list_of_folder)

	for i in range(L):
		sub_folder = os.path.join(folder, list_of_folder[i])
		print('Densidad:', list_of_folder[i])
		open_data_RUNS(sub_folder)
		

	print('Creado los valores medios de los RUNs para todas las carpetas')

	return


def open_data_RUNS(folder):

	list_of_folder = os.listdir(folder)
	list_of_folder.sort()
	list_of_folder = [f for f in list_of_folder if re.search('RUN',f) if not re.search('RUN_1',f)]

	L = len(list_of_folder) 
	print('Cantidad de RUNS', L)

	#densidad,temperatura_in,presion_mean,presion2_mean,var,temp_mean

	densidad = np.zeros(L)
	temperature_in = np.zeros(L)
	presion = np.zeros(L)
	presion2 = np.zeros(L)
	presion_var = np.zeros(L)
	temperature = np.zeros(L)
	energia_pot = np.zeros(L)
	energia_cin = np.zeros(L)
        energia_mec = np.zeros(L)

	for i in range(L):
		print('Carpeta RUN:', list_of_folder[i])

		name = os.path.join(folder, list_of_folder[i], 'mean_measurement.dat')
		data = np.genfromtxt(name, delimiter=',')

		densidad[i] = data[1,0]
		temperature_in[i] = data[1,1]
		presion[i] = data[1,2]
		presion2[i] = data[1,3]
		presion_var[i] = data[1,4]
		temperature[i] = data[1,5]

		name_energy = os.path.join(folder, list_of_folder[i], 'variables_fisicas.dat')
		data_energy = np.genfromtxt(name_energy, delimeter = ',')

                energia_pot[i] = np.mean(data[1,:])
                energia_cin[i] = np.mean(data[2,:])
                energia_mec[i] = np.mean(data[3,:])

	mean_data = np.array([np.mean(densidad), np.mean(temperature_in), np.mean(presion), np.mean(presion2), np.mean(presion_var), np.mean(temperature), np.mean(energia_pot), np.mean(energia_cin), np.mean(energia_mec)]).T
	name = os.path.join(folder, 'all_mean_measurement.csv')
	header_text = '#densidad, temperatura_in, presion, presion2, presion_var, temperatura, energia pot, energia cin, energia mec'
	np.savetxt(name, mean_data, header=header_text)

	print('Creado los valores medios de los RUNs para la carpeta.')

	return

def open_data_step2(folder, save_folder):

	list_of_folder = os.listdir(folder)
	list_of_folder.sort()

	list_of_folder = [f for f in list_of_folder if not (re.search('figuras',f))]
	L = len(list_of_folder) 
	#print('Cantidad de carpetas', L)

	densidad = np.zeros(L)
	temperature_in = np.zeros(L)
	presion = np.zeros(L)
	presion2 = np.zeros(L)
	presion_var = np.zeros(L)
	temperature = np.zeros(L)
        energia_pot = np.zeros(L)
        energia_cin = np.zeros(L)
        energia_mec = np.zeros(L)

	for i in range(L):

		name = os.path.join(folder, list_of_folder[i], 'all_mean_measurement.csv')
		data = np.genfromtxt(name, delimiter='')

		print(data)

		densidad[i] = data[0]
		temperature_in[i] = data[1]
		presion[i] = data[2]
		presion2[i] = data[3]
		presion_var[i] = data[4]
		temperature[i] = data[5]
                energia_pot[i] = data[6]
                energia_cin[i] = data[7]
                energia_mec[i] = data[8]
	data = np.array([densidad, temperature_in, presion, presion2, presion_var, temperature, energia_pot, energia_cin, energia_mec]).T
	name = os.path.join(save_folder, 'all_mean.csv')
	header_text = '#densidad, temperatura_in, presion, presion2, presion_var, temperatura. energia pot, energia cin, energia mec'
	np.savetxt(name, data, header=header_text)

	print('Juntados todos los valores medios')

	return

def manage_save_directory(path, new_folder_name):
    # Small function to create a new folder if not exist.
    new_folder_path = os.path.join(path, new_folder_name)
    if not os.path.exists(new_folder_path):
        os.makedirs(new_folder_path)
    return new_folder_path

def plot_data(save_folder):

	name = os.path.join(save_folder, 'all_mean.csv')
	data = np.genfromtxt(name, delimiter='')

	densidad = data[0:,0]
	temperatura_in = data[0:,1]
	presion = data[0:,2]
	presion2 = data[0:,3]
	presion_var = data[0:,4]
	temperatura = data[0:,5]
        energia_pot = data[0:,6]
        energia_cin = data[0:,7]
        energia_mec = data[0:,8]

	print('Grafico presion vs densidad')
	plt.figure()
	plt.plot(densidad, presion, 'o')
	plt.xlabel('Densidad')
	plt.ylabel('Presion interna')
	figure_name = os.path.join(save_folder, 'presion_vs_densidad.png')
	plt.savefig(figure_name, dpi = 400)
	plt.close()

	print('Grafico varianza presion vs densidad')
	plt.figure()
	plt.plot(densidad, presion_var, 'o')
	plt.xlabel('Densidad')
	plt.ylabel('Varianza Presion interna')
	figure_name = os.path.join(save_folder, 'var_presion_vs_densidad.png')
	plt.savefig(figure_name, dpi = 400)
	plt.close()

	print('Grafico temperatura vs densidad')
	plt.figure()
	plt.plot(densidad, temperatura, 'o', label = 'Temperatura MD')
	plt.plot(densidad, temperatura_in, 'r--', label = 'Temperatura impuesta')
	plt.xlabel('Densidad')
	plt.ylabel('Temperatura')
	plt.legend(loc = 'upper rigth')
	figure_name = os.path.join(save_folder, 'temperatura_vs_densidad.png')
	plt.savefig(figure_name, dpi = 400)
	plt.close()

	print('Grafico energias vs densidad')
	plt.figure()
	plt.plot(densidad, energia_pot, 'o', label = 'Energia potencial')
	plt.plot(densidad, energia_cin, 'o--', label = 'Energia cinética')
        plt.plot(densidad, energia_mec, '*', label = 'Energia mecanica')
	plt.xlabel('Densidad')
	plt.ylabel('Energia')
	plt.legend(loc = 'upper rigth')
	figure_name = os.path.join(save_folder, 'energia_vs_densidad.png')
	plt.savefig(figure_name, dpi = 400)
	plt.close()

	return

if __name__ == '__main__':

	#poner la direccion Densidad"
	#parent_folder = 'C:/Users/Alumno/Dropbox/Simulaciones-master/Practica_MD/Densidades'
	#parent_folder = '/home/alumnoit/Desktop/Simulaciones-master/Practica_MD/Densidades/Densidades_agus_completo'
	parent_folder = 'home/alumno/Escritorio/Densidades/Densidades_agus_completo'

	print('directorio:', parent_folder)
	
	save_folder = manage_save_directory(parent_folder, 'figuras_densidad')

	#recorre cada carpeta de Densidades y hace los means de los RUN, lo guarda como csv en cada carpeta de Densidad
	open_data_step1(parent_folder)

#recorre cada carpeta de Densidades y usa el archivo generado en step1, crea un csv con todos means

	open_data_step2(parent_folder, save_folder)

#grafica en funcion de la densidad

	plot_data(save_folder)



