        SUBROUTINE bounce (SIGMA, I,ww )
        use commons 
        use ziggurat 
        implicit none
!    ** The rutine computes collisional virial ww.               **
        integer,intent(in) :: I
        real (kind=8) :: sigma,ww
        real (kind=8) :: r_par(3),r_perp(3),v_mod,stheta,ctheta,v_vers(3),r_par1(3),r_par2(3)
        real (kind=8) :: e_fac(3)
        real (kind=8) :: rv,v_new(3),v_dlt(3),fac ,t_here,v_dir(3)
        integer :: k,j,l
        real (kind=8) :: zvers(3) = (/0.,0.,1./) 
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
         

            fac= sqrt( kb*temp/m )
            r_perp(:) =  -r(:,i)/sqrt(dot_product( r(:,i),r(:,i) ) )

            r_par1(:)= cross_product(r_perp(:),v(:,I)) 
            r_par1(:)= r_par1(:)/sqrt(dot_product( r_par1(:),r_par1(:) ) )

            r_par2(:) = cross_product(r_par1(:),r_perp(:))
            r_par2(:)= r_par2(:)/sqrt(dot_product( r_par2(:),r_par2(:) ) )


            v_new(:) = sqrt(2.)*fac*sqrt(-log( uni() ) )*r_perp(:)  + & 
                       fac*rnor()*r_par1(:) + fac*rnor()*r_par2(:)

            v(:,I) = v_new(:)



        end subroutine bounce

! ---- Definition of the vector product

        function cross_product (r1,r2) 
        real (kind=8) , intent(in) :: r1(3),r2(3)
        real (kind=8)  , dimension(3):: cross_product 

        cross_product(1) = r1(2)*r2(3) - r1(3)*r2(2) 
        cross_product(2) = -r1(1)*r2(3)+ r1(3)*r2(1)
        cross_product(3) = r1(1)*r2(2) - r1(2)*r2(1)

        end function cross_product
