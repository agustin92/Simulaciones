module verlet_positions
#include "control.h"
implicit none
real(kind=8), dimension(:,:), allocatable :: r, v, f, force_langevin
real(kind=8) :: L, energy_pot, energy_cin, presion, temp_md, dt, T, langevin_gamma, presion_ac,presion2_ac, temp_ac
real(kind=8) :: R_NP, T_NP, thermal_skin, sigma_NP, epsilon_NP, Temp_est(100), Temp_est_ac(100)
real(kind=8) :: Dens_est(100), Dens_est_ac(100)
integer(kind=8) :: N, n_mc
contains

subroutine lectura
    open(unit=20,file='configuracion_ini.dat',status='old')
    read(20,*)
    read(20,*) L
    read(20,*)
    read(20,*) N
    read(20,*)
    read(20,*) n_mc
    read(20,*)
    read(20,*) dt
    read(20,*)
    read(20,*) T
    read(20,*)
    read(20,*) langevin_gamma
#ifdef mode_spherical
    print *, 'Leyendo parametros para configuracion esférica con NP'
    read(20,*)
    read(20,*) R_NP
    read(20,*)
    read(20,*) T_NP
    read(20,*)
    read(20,*) thermal_skin
    read(20,*)
    read(20,*) sigma_NP
    read(20,*)
    read(20,*) epsilon_NP
#endif
    close(20)
    
    allocate (r(3, N))
    allocate (v(3, N))
    allocate (f(3, N))
    allocate (force_langevin(3,N))
    energy_pot = 0
    energy_cin = 0
    presion = 0
    temp_md = 0
    presion_ac = 0
    presion2_ac = 0 
    temp_ac = 0
    Temp_est = 0
    Temp_est_ac = 0
    Dens_est = 0
    Dens_est_ac = 0
end subroutine
    
end module verlet_positions
