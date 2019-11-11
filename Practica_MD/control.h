/*  variables de preprocessing */

/* Uso el potencial de L-J infinito define undef */
#undef pot_inf 

/* Uso el potencial de L-J cortado */
#define pot_corte

/* Rutina de inicializacion del sistema para evitar solapamiento de particulas */
#undef initialize

/* Velocitiy verlet */
#undef thermostat_NVE

/* Grabar la secuencia de posiciones para vmd */
#undef movie 

/* Termostato NVT - Langevin */
#define thermostat_NVT
