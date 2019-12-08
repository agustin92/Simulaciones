/*  variables de preprocessing */

/* Uso el potencial de L-J infinito define undef */
#undef pot_inf 

/* Uso el potencial de L-J cortado */
#define pot_corte

/* Configuracion inicial para caja cuadrada */
#undef intialize_box

/* Rutina de inicializacion del sistema para evitar solapamiento de particulas */
#undef initialize

/* Velocitiy verlet */
#undef velocity_verlet

/* Grabar la secuencia de posiciones para vmd */
#undef movie 

/* Termostato NVT - Langevin */
#undef thermostat_NV

/* Configuracion inicial para caja esférica, con NP en el centro */
#define initialize_spherical

/* Pared térmica esferas */
#define thermal_wall_spherical
