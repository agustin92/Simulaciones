subroutine positions()
use verlet_positions
#include "control.h"
implicit none
integer(kind=8):: i
real(kind=8) :: r_perp(3)
#ifdef mode_box
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
        if (r(1,i) .gt. L) then
            r(1,i) = r(1,i) - L
        end if
        if (r(2,i) .gt. L) then
            r(2,i) = r(2,i) - L
        end if
        if (r(3,i) .gt. L) then
            r(3,i) = r(3,i) - L
        end if
    end do
#endif

#ifdef mode_spherical
   do i = 1, N
       if (norm2(r(:,i)) .lt. R_NP) then
          r_perp(:) =  r(:,i)/SQRT(dot_product( r(:,i),r(:,i) ) )
          r(:,i) = R_NP*r_perp(:)
       end if
       if (norm2(r(:,i)) .gt. L) then
          r_perp(:) =  -r(:,i)/SQRT(dot_product( r(:,i),r(:,i) ) )
          r(:,i) = r_perp(:)*L
       end if
   end do
#endif

end subroutine
