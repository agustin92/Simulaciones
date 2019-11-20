subroutine gr_c(mode)
use gr_module
implicit none
integer, intent (in) :: mode
integer(kind=8) ::  i, j, ig, k
real(kind=8) :: dist, vb, nid
real(kind=8), dimension(3) :: xr
real, parameter :: Pi=3.1415927


select case (mode)

case(0)
    ngr = 0
    delg = L/(2*nhist)
    g(:) = 0

case(1)
    ngr = ngr + 1
    do i = 1, 199
        do j= i+1, 200
            xr(:) = r(:,j)-r(:,i)
            xr(:) = xr(:) - L*nint(xr(:)/L)
            dist = norm2(xr)
            if (dist .lt. L/2) then
                ig = int(dist/delg)+1
                g(ig) = g(ig) + 2
            end if
        end do
    end do

case(2)
    do k = 1, nhist
        dist = delg*(k+0.5)
        vb = ((k+1)**3-k**3)*delg**3
        nid = 4/3*Pi*vb*0.3
        g(k) = g(k)/(ngr*200*nid)
    end do

end select 

end subroutine
    

