module verlet_positions
implicit none
real(kind=8), dimension(:,:), allocatable :: r, v, f
real(kind=8) :: L, energy_pot, energy_cin, dt, T
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
    close(20)
    
    allocate (r(3, N))
    allocate (v(3, N))
    allocate (f(3, N))
    energy_pot = 0
    energy_cin = 0
end subroutine
    
end module verlet_positions
