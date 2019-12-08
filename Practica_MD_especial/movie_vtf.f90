subroutine movie_vtf(mode)
use verlet_positions
implicit none
integer, intent(in) :: mode
integer(kind=8) :: i
character(len=3) :: natoms
character(len=7) :: atom
character(len=22) ::radius
character(len=50) :: header

select case (mode)
case(0)!Escribo el header del archivo vtf
    open(unit = 35, file = 'movie.vtf', status = 'unknown')
    write(natoms, '(i3)') N-1
    atom = "atom 0:"
    radius = "     radius 0.5 name S"
    header = atom // natoms // radius
!    header = header//"   radius0.5 name S"
    write(35,*) header
case(1)
    write(35,*) "timestep"
    write(35,*)
    do i= 1, N
        write(35,*) r(:,i)
    end do
case(2)
    close(35)

end select


end subroutine


 
