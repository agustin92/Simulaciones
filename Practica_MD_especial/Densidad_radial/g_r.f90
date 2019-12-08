program gr
use gr_module
implicit none 
integer(kind=8) :: i,j,k
real(kind=8) :: dist

open(unit=20, file='movie.vtf',status='old')
read(20,*)

call inicio

call gr_c(0)
do i = 1,1000
    read(20,*)
    read(20,*)
    do j= 1,200
        read(20,*) r(:,j)
    end do
    call gr_c(1)   

end do
call gr_c(2)

close(20)

open(unit=21, file='salida_gr.dat', status='unknown')
write(21,*) 'r,g(r)'
do k= 1,nhist
    dist = delg*(k-0.5)
    write(21,*) dist,',',g(k)
end do
close(21)

end program gr
