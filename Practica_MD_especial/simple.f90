program simple 
use ziggurat
use verlet_positions
#include "control.h"
implicit none
logical :: es, inp, inp_vel
integer :: seed,i ,j,k,ither, i_est
integer(kind=8) :: a, b, c, mc, n_iteracion
real(kind=8) :: per, presion_mean, presion2_mean, dist, r_aux(3), r_norm_aux
real(kind=8) :: l_aux, ratio, colatitud, azimutal, v_colatitud, v_azimutal
real(kind=8) , parameter :: pi = 3.1415927

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

#ifdef mode_box
    else ! Si no existe el archivo, genero unas posiciones aleatorias para las N posiciones
        print *, 'Creo inpus aleatorios...'
        print *, '..para caja cuadrada de largo L'
        do a = 1, N
            r(1, a)  = L*uni()
            r(2, a)  = L*uni()
            r(3, a)  = L*uni()
            v(1, a)  = SQRT(T)*rnor()
            v(2, a)  = SQRT(T)*rnor()
            v(3, a)  = SQRT(T)*rnor()       
        end do
#endif

#ifdef mode_spherical
    else 
        print*, 'Creo inputs aleatorios...'
        print *, '...para caja esférica de radio L, con NP en el centro de radio R_NP'
    
        l_aux = L-R_NP
        do a = 1, N
        
            colatitud = uni()*pi
            azimutal = uni()*2*pi
            ratio = uni()*l_aux + R_NP

            r(1,a) = ratio*SIN(colatitud)*COS(azimutal) 
            r(2,a) = ratio*SIN(colatitud)*SIN(azimutal)
            r(3,a) = ratio*COS(colatitud)

!            r_aux(1)  = L*uni()
!            r_aux(2)  = L*uni()
!            r_aux(3)  = L*uni()
!            if (r_norm_aux .lt. L .and. r_norm_aux .gt. R_NP) then
!                r(:,a) = r_aux(:)
!            end if

            v(1,a) = SQRT(T)*rnor()          
            v(2,a) = SQRT(T)*rnor()
            v(3,a) = SQRT(T)*rnor()

       end do
#endif   

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
per = 10.0
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
per = 10.0
#ifdef movie
    call movie_vtf(0)
#endif
    call write_parameters(0,0)
    call kinetic()
    do mc= 1, n_mc
        r(:,:) = r(:,:) + v(:,:)*dt +0.5*f(:,:)*dt**2
        v(:,:) = v(:,:) + 0.5*f(:,:)*dt     
        call force()
        v(:,:) = v(:,:)+ 0.5*f(:,:)*dt

#ifdef thermal_wall_spherical
        do ither= 1, N
            call thermal_wall_spheres(ither)
        end do
#endif
        if (mod(mc,n_mc/10) .eq. 0) then
                print *, 'Simulacion completada en: ', per,'%'
                per = per + 10
        end if
        if (mod(mc, 500) .eq. 0) then
            call kinetic()
            call write_parameters(1,mc)
            temp_ac = temp_ac +temp_md
            Temp_est_ac(:) = Temp_est_ac(:) + Temp_est(:) 
            Dens_est_ac(:) = Dens_est_ac(:) + Dens_est(:)
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


    presion_mean = 0
    presion2_mean = 0
    write(22,*) 'densidad,temperatura_in,presion_mean,presion2_mean,var,temp_mean'
    write(22,*) N/L**3,',',T,',',presion_mean,',',presion2_mean,',',sqrt(presion2_mean-(presion_mean)**2),',',temp_ac/n_iteracion
    close(22)

    open(unit=23, file = 'perfiles.dat', status = 'unknown')
    write(23,*) 'Distacia_radial,Temperatura,Densidad'
    do i_est = 1,100
        dist = (L-R_NP)/100.0*(i_est-0.5)+R_NP
        write(23,*) dist,',',Temp_est_ac(i_est)/n_iteracion,',',Dens_est_ac(i_est)/n_iteracion
    end do
    close(23)



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
