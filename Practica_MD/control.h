/* variables de preprocessing */



/* Uso el potencial de L-J infinito define undef */
#undef pot_inf 

/* Uso el potencial de L-J cortado */
#define pot_corte

/* Rutina de inicializacion del sistema para evitar solapamiento de particulas */
#undef initialize

/* Velocitiy verlet */
#define vel_verlet

/* Grabar la secuencia de posiciones para vmd */
#define movie 
