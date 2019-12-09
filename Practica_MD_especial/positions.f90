subroutine positions()
use verlet_positions
#include "control.h"
implicit none
integer:: i

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
          r(:, i) = r(:, i) + R_NP
       end if
       if (norm2(r(:,i)) .gt. L) then
          r(:,i) = r(:, i) - L + R_NP
       end if
   end do
#endif

end subroutine
