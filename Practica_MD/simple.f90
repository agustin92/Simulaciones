program simple 
use ziggurat
use verlet_positions
#include "control.h"
implicit none
logical :: es, inp, inp_vel
integer :: seed,i ,j,k
integer(kind=8) :: a, b, c, mc, n_iteracion
real(kind=8) :: per, presion_mean, presion2_mean

![NO TOCAR] Inicializa generador de número random

    inquire(file='seed.dat',exist=es)
    if(es) then
        open(unit=10,file='seed.dat',status='old')
        read(10,*) seed
        close(10)
    else
        seed = 24583490
    end if

    call zigset(seed)
![FIN NO TOCAR]    

! Llamo a la rutina de lectura de las condiciones iniciales y tamano de vectores
    call lectura
    r = 0
    v = 0
    f = 0
    n_iteracion = 0
!!Armo la configuración inicial de las posiciones  al azar si es que no existe el archivo input.dat

    inquire(file='input_pos.dat', exist=inp)
    inquire(file='input_vel.dat', exist=inp_vel) 
!Si existe lo abro par:a asignar los valores de las posiciones, tiene que estar la informacion en columnas
    if (inp .and. inp_vel) then
       
        open(unit = 20, file = 'input_pos.dat', status = 'old')
        open(unit = 21, file = 'input_vel.dat', status = 'old')
        do j = 1, N
            read(20, *) r(:, j)
            read(21, *) v(:, j)
        end do
        close(20)
        close(21)

    else ! Si no existe el archivo, genero unas posiciones aleatorias para las N posiciones
        print *, 'Creo inputs aleatorios'
        do a = 1, N
            r(1, a)  = L*uni()
            r(2, a)  = L*uni()
            r(3, a)  = L*uni()
            v(1, a)  = SQRT(T)*rnor()
            v(2, a)  = SQRT(T)*rnor()
            v(3, a)  = SQRT(T)*rnor()
                   
        end do
    end if   
    
!    r(1,1) = 0.0
!    r(2,1) = 0.0
!    r(3,1) = 0.0

!    r(1,2) = 1.05
!    r(2,2) = 0.0
!    r(3,2) = 0.0
   
!    call force()
!    print *, 'Fuerza ' , f
!    print *, 'Energia' , energy

#ifdef initialize

!Rutina para inicializar el sistema si se comienza con una configuracion inicial aleatoria para evitar solapamiento excesivo    
per = 0.0
#ifdef movie
    call movie_vtf(0)
#endif
    call write_parameters(0,0) 
    do mc= 1, n_mc
        r(:,:) = r(:,:) + 0.5*f(:,:)*dt**2
        call positions()
        call force()
        if (mod(mc,n_mc/10) .eq. 0) then
                print *, 'Simulacion completada en: ', per,'%'
                per = per + 10
        end if
        if (mod(mc, 1000) .eq. 0) then
            call write_parameters(1,mc)
            presion_ac = presion_ac + presion
            presion2_ac = presion2_ac + presion**2
            temp_ac = temp_ac + temp_md
            n_iteracion = n_iteracion + 1 
#ifdef movie
            call movie_vtf(1)
#endif
        end if
    end do
    call write_parameters(2,0)
#ifdef movie
    call movie_vtf(2)
#endif

!Guardo la configuracion final de posiciones y velocidades
    open(unit=20, file = 'input_pos.dat', status = 'unknown')
    open(unit=21, file = 'input_vel.dat', status = 'unknown')
    do i = 1, N
        write(20, *) r(:, i)
        write(21, *) v(:, i)
    end do
    close(20)
    close(21)

#endif

#ifdef velocity_verlet
per = 0.0
#ifdef movie
    call movie_vtf(0)
#endif
    call write_parameters(0,0)
    call kinetic()
    do mc= 1, n_mc
        r(:,:) = r(:,:) + v(:,:)*dt +0.5*f(:,:)*dt**2
        v(:,:) = v(:,:) + 0.5*f(:,:)*dt
        call positions()
        call force()
        v(:,:) = v(:,:)+ 0.5*f(:,:)*dt
        if (mod(mc,n_mc/10) .eq. 0) then
                print *, 'Simulacion completada en: ', per,'%'
                per = per + 10
        end if
        if (mod(mc, 1000) .eq. 0) then
            call kinetic()
            call write_parameters(1,mc)
            presion_ac = presion_ac + presion
            presion2_ac = presion2_ac + presion**2
            temp_ac = temp_ac +temp_md
            n_iteracion = n_iteracion + 1
#ifdef movie
            call movie_vtf(1)
#endif
        end if
    end do
    call write_parameters(2,0)
#ifdef movie
    call movie_vtf(2)
#endif

!Guardo la configuracion final de posiciones y velocidades
    open(unit=20, file = 'input_pos.dat', status = 'unknown')
    open(unit=21, file = 'input_vel.dat', status = 'unknown')
    do i = 1, N
        write(20, *) r(:, i)
        write(21, *) v(:, i)
    end do
    close(20)
    close(21)
    open(unit=22, file = 'mean_measurement.dat', status = 'unknown')


    presion_mean = presion_ac/n_iteracion
    presion2_mean = presion2_ac/n_iteracion   
    write(22,*) 'densidad,temperatura_in,presion_mean,presion2_mean,var,temp_mean'
    write(22,*) N/L**3,',',T,',',presion_mean,',',presion2_mean,',',sqrt(presion2_mean-(presion_mean)**2),',',temp_ac/n_iteracion
    close(22)
#endif


!! FIN FIN edicion
!! 
![No TOCAR]
! Escribir la última semilla para continuar con la cadena de numeros aleatorios 

        open(unit=10,file='seed.dat',status='unknown')
        seed = shr3() 
         write(10,*) seed
        close(10)
![FIN no Tocar]        


end program simple
