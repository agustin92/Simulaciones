/*  variables de preprocessing */

/* Uso el potencial de L-J infinito define undef */
#undef pot_inf 

/* Uso el potencial de L-J cortado */
#define pot_corte

/* Configuracion inicial y condiciones de contorno para caja cuadrada */
#undef mode_box

/* Rutina de inicializacion del sistema para evitar solapamiento de particulas */
#define initialize

/* Velocitiy verlet */
#undef velocity_verlet

/* Grabar la secuencia de posiciones para vmd */
#define movie 

/* Termostato NVT - Langevin */
#undef thermostat_NVT

/* Configuracion inicial para caja esférica, con NP en el centro */
#define mode_spherical

/* Pared térmica esferas */
#define thermal_wall_spherical
