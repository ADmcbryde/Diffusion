program diff

        implicit none

        integer, parameter :: N = 10
        

        real(kind=8) :: mTotal
        real(kind=8) :: tot
        real(kind=8) :: mSpeed
        real(kind=8) :: hval
        real(kind=8) :: D
        real(kind=8) :: conMax
        real(kind=8) :: conMin
        real(kind=8) :: tStep
        real(kind=8) :: time

        real(kind=8), dimension(N,N,N) :: room 
        real(kind=8), dimension(6) :: dCon

        real :: coefficient

        logical      :: partition

        integer :: i,j,k
        time = 0


        mTotal = 1000000000000000000000.0
        mSpeed = 250.0
        hval   = 5.0/N
        D      = 0.175
        conMax = 0.0
        conMin = 0.0
        tStep  = hval/mSpeed

        partition = .true.

        coefficient = (tStep*D)/(hval*hval)

        do i = 1, N
                do j = 1, N
                        do k = 1, N
                                if (j==((N/2)+1) .and. i>=((N/2)+1) .and. partition) then
                                        room(i,j,k) = -1.0
                                else
                                        room(i,j,k) = 0.0
                                end if
                                !print *, room(i,j,k)
                        end do
                        !print *
                end do
                !print *
        end do

        print *, (-1 == -1.0)

        do i = 1, 6
                dCon(i) = 0
        end do
!go to 100

        room(1,1,1) = mTotal
        conMax = mTotal
        conMin = 1.0

 
do while ((conMin/conMax) .lt. 0.99)
        
        time = time + tStep

        do i = 1, N
                do j = 1, N
                        do k = 1, N
                                
                                if (room(i,j,k) .ne. -1) then
                                       
                                        if (k==N .or. room(i,j,k+1) == -1) then
                                                dCon(1) = 0
                                        else
                                                dcon(1) = (room(i,j,k)-room(i,j,k+1)) * coefficient
                                                room(i,j,k) = room(i,j,k) - dCon(1)
                                                room(i,j,k+1) = room(i,j,k+1) + dCon(1)
                                        end if
        
                                        if (j==N .or. room(i,j+1,k) == -1) then
                                                dCon(2) = 0
                                        else
                                                dcon(2) = (room(i,j,k)-room(i,j+1,k)) * coefficient
                                                room(i,j,k) = room(i,j,k) - dCon(2)
                                                room(i,j+1,k) = room(i,j+1,k) + dCon(2)
                                        end if
        
                                        if (i==N .or. room(i+1,j,k) == -1) then
                                                dCon(3) = 0 
                                        else
                                                dcon(3) = (room(i,j,k)-room(i+1,j,k)) * coefficient
                                                room(i,j,k) = room(i,j,k) - dCon(3)
                                                room(i+1,j,k) = room(i+1,j,k) + dCon(3)
                                        end if
        
                                        if (k==1 .or. room(i,j,k-1) == -1) then
                                                dCon(4) = 0
                                        else
                                                dcon(4) = (room(i,j,k)-room(i,j,k-1)) * coefficient
                                                room(i,j,k) = room(i,j,k) - dCon(4)
                                                room(i,j,k-1) = room(i,j,k-1) + dCon(4)
                                        end if
        
                                        if (j==1 .or. room(i,j-1,k) == -1) then
                                                dCon(5) = 0
                                        else
                                                dcon(5) = (room(i,j,k)-room(i,j-1,k)) * coefficient
                                                room(i,j,k) = room(i,j,k) - dCon(5)
                                                room(i,j-1,k) = room(i,j-1,k) + dCon(5)
                                        end if
        
                                        if (i==1 .or. room(i-1,j,k) == -1) then
                                                dCon(6) = 0
                                        else
                                                dcon(6) = (room(i,j,k)-room(i-1,j,k)) * coefficient
                                                room(i,j,k) = room(i,j,k) - dCon(6)
                                                room(i-1,j,k) = room(i-1,j,k) + dCon(6)
                                        end if
                                end if
                        end do
                end do
        end do

!100 continue
        conMin = room(1,1,1)
        conMax = room(1,1,1)

         do i = 1, N
                do j = 1, N
                        do k = 1, N

                        if (room(i,j,k) < conMin .and. room(i,j,k) .ne. -1) then
                                conMin = room(i,j,k)
                        end if

                        if (room(i,j,k) > conMax .and. room(i,j,k) .ne. -1) then
                                conMax = room(i,j,k)
                        end if

                        end do
                end do
        end do

        
!        do i = 1, N
!                do j = 1, N
!                        do k = 1, N
!                                 Print *, room(i,j,k), i, j, k
!                        end do
!                end do
!                Print *
!        end do
!        Print *
end do
        do i = 1, N
                do j = 1, N
                        do k = 1, N
                                tot = tot + room(i,j,k)
                        end do
                end do
        end do
 
        !print *, coefficient
        print *, "Total molecules starting:", mTotal
        print *, "Total molecules left:", tot
        print *, "Time Simulated:", time
        print *, "min concentration:", conMin
        print *, "max concentration:", conMax



end program diff
