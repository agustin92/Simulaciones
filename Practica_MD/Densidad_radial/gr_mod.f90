module gr_module
implicit none
real(kind=8), dimension(3,200) :: r
real(kind=8), dimension(400) :: g
real(kind=8) :: delg, L
integer(kind=8) :: nhist, ngr
contains

subroutine inicio
    r = 0.0
    g = 0.0
    delg = 0.0
    L = 8.7358
    nhist = 400
end subroutine

end module gr_module
