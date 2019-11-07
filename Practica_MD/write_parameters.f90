subroutine write_parameters(mode,npaso)
use verlet_positions
implicit none
integer, intent(in) :: mode, npaso
real(kind=8) :: energy_tot

select case (mode)
case(0)
    open(unit = 45, file = 'variables_fisicas.dat', status = 'unknown')
    write(45,*) 'Tiempo,Energia_pot,Energy_cin,Energy,Presion,Temperatura_md'
case(1)
    energy_tot = energy_cin + energy_pot
    write(45,*) dt*npaso,',',energy_pot,',',energy_cin,',',energy_tot,',',presion,',',temp_md
case(2)
    close(45)
end select

end subroutine

