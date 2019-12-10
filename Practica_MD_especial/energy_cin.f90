subroutine kinetic()
use verlet_positions
implicit none
integer(kind=8) :: i, j , nbin
real(kind=8) :: energy_aux, bin_size, r_norm, vb
real(kind=8), allocatable :: cont(:), Temp_est_aux(:), Dens_est_aux(:)

allocate (cont(450))
allocate (Temp_est_aux(450))
allocate (Dens_est_aux(450))

energy_aux = 0
bin_size = (L-R_NP)/450.0
cont = 0
Temp_est_aux = 0
Dens_est_aux = 0

print *, 'Energi cinetica'

do i = 1,N
    r_norm = norm2(r(:,i)) - R_NP
    nbin = nint(r_norm/bin_size)
    energy_aux = energy_aux + 0.5*norm2(v(:,i))**2
    Temp_est_aux(nbin) = Temp_est_aux(nbin) + 0.5*norm2(v(:,i))**2
    cont(nbin) = cont(nbin) + 1
end do

do j = 1, 450
    if (cont(j) .gt. 0) then
        Temp_est_aux(j) = Temp_est_aux(j)/cont(j)
        vb = ((j+1+R_NP)**3.0-(j+R_NP)**3.0)*bin_size**3.0    
        Dens_est_aux(j) = cont(j)/vb
    end if
end do

    
Temp_est(:) = Temp_est_aux(:)
Dens_est(:) = Dens_est_aux(:)
energy_cin = energy_aux
temp_md = energy_aux*2/(3*N)

end subroutine
