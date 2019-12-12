subroutine kinetic()
use verlet_positions
implicit none
integer(kind=8) :: i, j , nbin
real(kind=8) :: energy_aux, bin_size, r_norm, vb
real(kind=8) :: cont(100), Temp_est_aux(100), Dens_est_aux(100)

!allocate (cont(450))
!allocate (Temp_est_aux(450))
!allocate (Dens_est_aux(450))

energy_aux = 0.0
bin_size = (L-R_NP)/100.0
cont = 0.000
Temp_est_aux = 0.0
Dens_est_aux = 0.0
temp_md = 0.0

do i = 1, N
    r_norm = abs(norm2(r(:,i)) - R_NP)
    nbin = int(r_norm/bin_size)+1
    energy_aux = energy_aux + 0.5*dot_product(v(:,i),v(:,i))
    Temp_est_aux(nbin) = Temp_est_aux(nbin) + dot_product(v(:,i),v(:,i))
    cont(nbin) = cont(nbin) + 1.0
end do

do j = 1, 100
    if (cont(j) .gt. 0) then
        Temp_est_aux(j) = Temp_est_aux(j)/(3.000*cont(j))
        vb = 4.0/3.0*3.1415927*(((j+1)*bin_size+R_NP)**3.0-(j*bin_size+R_NP)**3.0)    
        Dens_est_aux(j) = cont(j)/vb
    end if
end do

    
Temp_est(:) = Temp_est_aux(:)
Dens_est(:) = Dens_est_aux(:)
energy_cin = energy_aux
temp_md = energy_aux*2.0/(3.00*N)

end subroutine
