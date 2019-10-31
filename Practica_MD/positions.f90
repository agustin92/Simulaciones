subroutine positions()
use verlet_positions
implicit none
integer:: i

! Mueve las posiciones de las particulas para garantizar ccp
    do i = 1, N
        if (r(1,i) .lt. 0) then
            r(1,i) = r(1,i) + L
        end if
        if (r(2,i) .lt. 0) then
            r(2,i) = r(2,i) + L
        end if
        if (r(3,i) .lt. 0) then
            r(3,i) = r(3,i) + L
        end if
        if (r(1,i) .gt. 0) then
            r(1,i) = r(1,i) - L
        end if
        if (r(2,i) .gt. 0) then
            r(2,i) = r(2,i) - L
        end if
        if (r(3,i) .gt. 0) then
            r(3,i) = r(3,i) - L
        end if
    end do

end subroutine
