module gr_module
implicit none
real(kind=8), dimension(3,200) :: r
real(kind=8), dimension(:), allocatable :: g
real(kind=8) :: delg, L, dens
integer(kind=8) :: nhist, ngr
contains

subroutine inicio
    r = 0.0
    delg = 0.0
    L = 58.48035476425731
    nhist = 500
    dens = 0.001
    allocate(g(nhist))
end subroutine

end module gr_module
