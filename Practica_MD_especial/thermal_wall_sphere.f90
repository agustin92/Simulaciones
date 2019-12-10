subroutine thermal_wall_spheres(i)
use verlet_positions 
use ziggurat 
#include "control.h"
implicit none
integer, intent(in) :: i
real (kind=8) :: r_perp(3),v_new(3),r_par1(3),r_par2(3),r_perp_NP(3),v_new_NP(3),r_par1_NP(3),r_par2_NP(3)
real (kind=8) :: fac,fac_NP,v_par

interface 
        function cross_product(r1,r2)
        real(kind=8),intent(in) :: r1(3),r2(3)
        real (kind=8)  :: cross_product(3)
        end function cross_product
end interface 

! CURSO intro sims
! * Esto es thermal walls con pared esferica. Las partículas rebotan hacia adentro de la esfera
! * Sirve para la cavidad. Invertir sentido en dirección normal para hacer la nanopartícula
! * contemplar que la temperatura sea diferente para partícula y cavidad 

! Bounce in the wall with random velocity direction (inwards)
! and the velocity module take from a Maxwell-Boltzmann
! distribution

! ----- Spherical cavity
         
!Sphera external ratio L, temperature T, thermal_skin
        if (norm2(r(:, i)) > (L-thermal_skin)) then !.and. ((v(1, i) > 0.0) .or. (v(2,i) > 0.0) .or. (v(3, i) > 0.0)) then
            !print*, 'Aplica pared externa', i
            
            fac= SQRT(T)
            r_perp(:) =  -r(:,i)/SQRT(dot_product( r(:,i),r(:,i) ) )
            v_par = dot_product(r_perp(:),v(:,i))

            if (v_par<0) then

                r_par1(:)= cross_product(r_perp(:),v(:,i)) 
                r_par1(:)= r_par1(:)/SQRT(dot_product( r_par1(:),r_par1(:) ) )

                r_par2(:) = cross_product(r_par1(:),r_perp(:))
                r_par2(:)= r_par2(:)/SQRT(dot_product( r_par2(:),r_par2(:) ) )

                v_new(:) = SQRT(2.)*fac*SQRT(-log( uni() ) )*r_perp(:)  + & 
                       fac*rnor()*r_par1(:) + fac*rnor()*r_par2(:)

                v(:,i) = v_new(:)

            end if
        endif
      
!Nanoparticle ratio R_NP, temperature T_NP, thermal_skin
        if  (norm2(r(:,i)) < (R_NP + thermal_skin)) then !.and. ((v(1,i) < 0.0) .or. (v(2,i) < 0.0) .or. (v(3,i) < 0.0)) then
            !print*, 'Aplica pared NP', i

            fac_NP = sqrt(T_NP)
            r_perp_NP(:) = r(:,i)/sqrt(dot_product( r(:,i),r(:,i)))
            v_par = dot_product(r_perp(:),v(:,i))

            if (v_par<0) then
            
                r_par1_NP(:) = cross_product(r_perp_NP(:), v(:,i))
                r_par1_NP(:) = r_par1_NP(:)/sqrt(dot_product(r_par1_NP(:), r_par1_NP(:)))

                r_par2_NP(:) = cross_product(r_par1_NP(:), r_perp_NP(:))
                r_par2_NP(:) = r_par2_NP(:)/sqrt(dot_product(r_par2_NP(:),r_par2_NP(:))) 

                v_new_NP(:) = sqrt(2.)*fac_NP*sqrt(-log(uni()))*r_perp_NP(:) + &
                            fac_NP*rnor()*r_par1_NP(:) + fac_NP*rnor()*r_par2_NP(:) 

                v(:, i) = v_new_NP(:)

            end if
      
        endif

 end subroutine thermal_wall_spheres

! ---- Definition of the vector product

 function cross_product (r1,r2) 
 real (kind=8) , intent(in) :: r1(3),r2(3)
 real (kind=8)  , dimension(3):: cross_product 

 cross_product(1) = r1(2)*r2(3) - r1(3)*r2(2) 
 cross_product(2) = -r1(1)*r2(3)+ r1(3)*r2(1)
 cross_product(3) = r1(1)*r2(2) - r1(2)*r2(1)

  end function cross_product
