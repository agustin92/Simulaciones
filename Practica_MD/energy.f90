subroutine force()
use verlet_positions
use ziggurat
#include "control.h"
implicit none
real(kind=8), dimension(3) :: rij, fza_int
real(kind=8):: distance, eng_int, vc, presion_int
integer:: a, b, c

distance = 0
rij = 0
eng_int = 0
fza_int = 0
f = 0
force_langevin = 0
presion_int = 0
presion = 0

#ifdef pot_inf
do a = 1, N-1
    do b = a+1, N
        rij(:) = r(:, b) - r(:, a)
        rij(:) = rij(:) - L*int(2*rij(:)/L)
        distance  = norm2(rij)
        eng_int = eng_int + 4*(-1/distance**6 + 1/distance**12)
        fza_int(:) = 4*(6*rij(:)/distance**8-12*rij(:)/distance**14)
        presion_int  = presion_int + 1/(3*L**3)*DOT_PRODUCT(fza_int(:),rij(:)) 
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
            fza_int(:) = 4*(6*rij(:)/distance**8-12*rij(:)/distance**14)
            presion_int  = presion_int + 1/(3*L**3)*DOT_PRODUCT(fza_int(:),rij(:)) 
            f(:,a) = f(:,a) + fza_int
            f(:,b) = f(:,b) - fza_int
       
        endif

    end do
#ifdef thermostat_NVT
        force_langevin(1,a) = -langevin_gamma*v(1,a) + SQRT(2*T*langevin_gamma/(dt))*rnor()
        force_langevin(2,a) = -langevin_gamma*v(2,a) + SQRT(2*T*langevin_gamma/(dt))*rnor()
        force_langevin(3,a) = -langevin_gamma*v(3,a) + SQRT(2*T*langevin_gamma/(dt))*rnor()
        f(:,a) = f(:,a) + force_langevin(:,a)
#endif
end do
    
#ifdef thermostat_NVT
    force_langevin(1,N) = -langevin_gamma*v(1,N) + SQRT(2*T*langevin_gamma/(dt))*rnor()
    force_langevin(2,N) = -langevin_gamma*v(2,N) + SQRT(2*T*langevin_gamma/(dt))*rnor()
    force_langevin(3,N) = -langevin_gamma*v(3,N) + SQRT(2*T*langevin_gamma/(dt))*rnor()
    f(:,N) = f(:,N) + force_langevin(:,N)
#endif

#endif

energy_pot = eng_int
presion = N*temp_md/L**3 + presion_int/((N**2-N)/2)  !!revisar normalizacion de presion_inti

end subroutine
