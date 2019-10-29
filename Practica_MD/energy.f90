real(kind=8) function fza_interaction()

use verlet_positions

implicit none

real, dimension(3) :: rij, fza_int

real(kind=8):: distance, eng_int

integer:: a, b, c

distance = 0
rij = 0
eng_int = 0
fza = 0

do a = 1, N-1
      do b = a+1, N
              rij(:) = r(:, b) - r(:, a)
		rij(:) = rij(:) - L*int(2*rij(:)/L)
              distance  = norm2(rij)
              eng_int = eng_int + 4*(-1/distance**6 + 1/distance**12)

             !	fza_int(:) = 
            !  f(:, a)  = f(:, a) + fza_int
	!    f(:, b) =  f(:, b) - fza_int 
      end do
end do

!print *, 'fuerza', f
end function

