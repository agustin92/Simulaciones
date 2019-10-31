real(kind=8) function fza_interaction()
use verlet_positions
#include "control.h"
implicit none
real, dimension(3) :: rij, fza_int
real(kind=8):: distance, eng_int, vc
integer:: a, b, c

distance = 0
rij = 0
eng_int = 0
fza_int = 0

#ifdef pot_inf
do a = 1, N-1
    do b = a+1, N
        rij(:) = r(:, b) - r(:, a)
        rij(:) = rij(:) - L*int(2*rij(:)/L)
        distance  = norm2(rij)
        eng_int = eng_int + 4*(-1/distance**6 + 1/distance**12)
        fza_int(:) = -4*(6*rij(:)/distance**8-12*rij(:)/distance**14)
        f(:,a) = f(:,a) + fza_int
        f(:,b) = f(:,b) - fza_int
    end do
end do
#endif

#ifdef pot_corte

vc = 4*(-1/2.5**6 + 1/2.5**12)

do a = 1, N-1
    do b = a+1, N
        rij(:) = r(:, b) - r(:, a)
        rij(:) = rij(:) - L*int(2*rij(:)/L)
        distance  = norm2(rij)
        if (distance .le. 2.5) then
            eng_int = eng_int + 4*(-1/distance**6 + 1/distance**12) - vc
            fza_int(:) = -4*(6*rij(:)/distance**8-12*rij(:)/distance**14)
            f(:,a) = f(:,a) + fza_int
            f(:,b) = f(:,b) - fza_int
        end if
    end do
end do
#endif
fza_interaction = eng_int

!print *, 'fuerza', f
end function

