program simple 
    use ziggurat
    implicit none
    logical :: es
    integer :: seed,i ,j,k,num, casos_fav
    real(kind=8) :: x,y,dp,f_aux,p,r,ncf

![NO TOCAR] Inicializa generador de número random

    inquire(file='seed.dat',exist=es)
    if(es) then
        open(unit=10,file='seed.dat',status='old')
        read(10,*) seed
        close(10)
!        print *,"  * Leyendo semilla de archivo seed.dat"
    else
        seed = 24583490
    end if

    call zigset(seed)
![FIN NO TOCAR]    

! Ej: Número random en [0,1]: uni()
!!! Para probabilidades uniformes de X

    open(unit=2,file='imput.dat',status='old')
    read(2,*) num
    close(2)
    print *, 'x,f(x),y'
        do i = 1, num
            x = (rnor()/2.5)+1
            y = uni()
            f_aux = dp(x)
            if(x.le.2 .and. y.le.f_aux) then
                print *, x,',',f_aux,',',y
            end if
        end do

!!!! Para otras distribuciones

!    open(unit=2,file='imput.dat',status='old')
!    read(2,*) num
!    close(2)
!    casos_fav=0
!    print *, 'x,f(x),y'
!        do while (casos_fav<num)
!            x = (rnorm+1)/2
!            x = uni()*2
!            y = uni()
!            f_aux = dp(x)
!            if(x.le.2 .and. y.le.f_aux) then
!                print *, x,',',f_aux,',',y
!                casos_fav = casos_fav + 1
!            end if
!        end do

!!! Programa para Pi
!    open(unit=2,file='imput.dat',status='old')
!    read(2,*) num
!    close(2)
!    ncf= 0.0
!    do i = 1, num
!        x= uni()
!        y= uni()
!        r = x**2+y**2
!        if (r.le.1) then
!            ncf=ncf+1.0
!        end if
!    end do
!    p = ncf/(dble(num))*4
!    print *, p

!!!!

!!!! Print distribuciones

!        print *, 'rnor,rexp,uni,prueba'
!        do i = 1,1000
!            ncf = (rnor()/2.5)+1
!            print *, rnor(),',',rexp(),',',uni(),',',ncf
!        end do



!! 
!! EDITAR AQUI 
!! 


!! 
!! FIN FIN edicion
!! 
![No TOCAR]
! Escribir la última semilla para continuar con la cadena de numeros aleatorios 

        open(unit=10,file='seed.dat',status='unknown')
        seed = shr3() 
         write(10,*) seed
        close(10)
![FIN no Tocar]        


end program simple
