subroutine kinetic()
use verlet_positions
implicit none
integer(kind=8) :: i
real(kind=8) :: energy_aux

do i = 1,N
    energy_aux = energy_aux + 0.5*norm2(v(:,i))**2
end do

energy_cin = energy_aux

end subroutine
