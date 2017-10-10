package main

import (
	"fmt"
)

var mTotal, time, mSpeed, D, rSize, rDiv, tStep, hval, conMax, conMin float64

func main(){

	const N int = 10

	mTotal = 1000000000000000000000.0
	mSpeed = 250.0
	hval = 5.0/float64(N)
	D = 0.175
	conMax = mTotal
	conMin = 1.0
	tStep = hval/mSpeed

	var tot float64 = 0.0

	var room[N][N][N] float64

	for i:=0; i<N; i++ {
		for j:=0; j<N; j++{
			for k:=0; k<N; k++{
				room[i][j][k] = 0.0//float32(i*N*N+j*N+k+1)
					//fmt.Println(room[i][j][k])
			}
		}
	}

	room[0][0][0] = mTotal


	for (conMin/conMax) < 0.99 {
		time = time + tStep
		//step(room [:][:][:]);
		dCon := [6]float64{0.0,0.0,0.0,0.0,0.0,0.0}

	        var coefficient float64 = ((D*tStep) / (hval*hval))

	        for i:=0; i<N; i++ {
	                for j:=0; j<N; j++{
	                        for k:=0; k<N; k++{
	                                if k==N-1 {
	                                        dCon[0] = 0
	                                }else{
	                                        dCon[0] = (room[i][j][k]    -room[i][j][k+1]) * coefficient
	                                        room[i][j][k] = room[i][j][k] - dCon[0]
	                                        room[i][j][k+1]     = room[i][j][k+1] + dCon[0]
	                                }
	                                if j==N-1 {
	                                        dCon[1] = 0
	                                }else{
	                                        dCon[1] = (room[i][j][k]    -room[i][j+1][k]) * coefficient
	                                        room[i][j][k] = room[i][j][k] - dCon[1]
	                                        room[i][j+1][k]     = room[i][j+1][k] + dCon[1]
	                                }
	                                if i==N-1 {
	                                        dCon[2] = 0
	                                }else{
	                                        dCon[2] = (room[i][j][k]-room[i+1][j][k]) * coefficient
	                                        room[i][j][k] = room[i][j][k] - dCon[2]
	                                        room[i+1][j][k] = room[i+1][j][k] + dCon[2]
	                                }
	                                if k==0 {
	                                        dCon[3] = 0
	                                }else{
	                                        dCon[3] = (room[i][j][k]    -room[i][j][k-1]) * coefficient
	                                        room[i][j][k] = room[i][j][k] - dCon[3]
	                                        room[i][j][k-1]     = room[i][j][k-1] + dCon[3]
	                                }
	                                if j==0 {
	                                        dCon[4] = 0
	                                }else{
	                                        dCon[4] = (room[i][j][k]    -room[i][j-1][k]) * coefficient
	                                        room[i][j][k] = room[i][j][k] - dCon[4]
	                                        room[i][j-1][k]     = room[i][j-1][k] + dCon[4]
	                                }
	                                if i==0 {
	                                        dCon[5] = 0
	                                }else{
	                                        dCon[5] = (room[i][j][k]-room[i-1][j][k]) * coefficient
	                                        room[i][j][k] = room[i][j][k] - dCon[5]
	                                        room[i-1][j][k] = room[i-1][j][k] + dCon[5]
	                                }
	                       }
	                }
		}

		conMin = room[0][0][0]
		conMax = room[0][0][0]

		//var l, m, n int

		for l:=0; l<N; l++ {
                        for m:=0; m<N; m++{
	                        for n:=0; n<N; n++{
					if room[l][m][n] < conMin {
						conMin = room[l][m][n]
					}
					if room[l][m][n] > conMax{
						conMax = room[l][m][n]
					}
				}
			}
		}

	}

	for i:=0; i<N; i++ {
	        for j:=0; j<N; j++{
			for k:=0; k<N; k++{
				tot = tot + room[i][j][k]
			}
		}
	}

	fmt.Printf("Total molecules starting: %f\n", mTotal);
        fmt.Printf("Total molecules left: %f\n", tot);
        fmt.Printf("Time Simulated: %f\n", time);
        fmt.Printf("min concentration: %f\n", conMin);
        fmt.Printf("max concentration: %f\n", conMax);

}
/*
func step(alt []float32, L int){

	var room [N][N][N]float32

	var dCon[6]float32 = 0

	var coefficient float32 = ((D*tStep) / (hval*hval))

	for i:=0; i<N; i++ {
                for j:=0; j<N; j++{
			for k:=0; k<N; k++{
				if k==N-1 {
					dCon[0] = 0
				}else{
					dCon[0] = (room[i][j][k]    -room[i][j][k+1]) * coefficient
					room[i][j][k] = room[i][j][k] - dCon[0]
					room[i][j][k+1]     = room[i][j][k+1] + dCon[0]
				}
				if j==N-1 {
					dCon[1] = 0
				}else{
					dCon[1] = (room[i][j][k]    -room[i][j+1][k]) * coefficient
					room[i][j][k] = room[i][j][k] - dCon[1]
					room[i][j+1][k]     = room[i][j+1][k] + dCon[1]
				}
				if i==N-1 {
					dCon[2] = 0
				}else{
					dCon[2] = (room[i][j][k]-room[i+1][j][k]) * coefficient
					room[i][j][k] = room[i][j][k] - dCon[2]
					room[i+1][j][k] = room[i+1][j][k] + dCon[2]
				}
				if k==0 {
					dCon[3] = 0
				}else{
					dCon[3] = (room[i][j][k]    -room[i][j][k-1]) * coefficient
					room[i][j][k] = room[i][j][k] - dCon[3]
					room[i][j][k-1]     = room[i][j][k-1] + dCon[3]
				}
				if j==0 {
					dCon[4] = 0
				}else{
					dCon[4] = (room[i][j][k]    -room[i][j-1][k]) * coefficient
					room[i][j][k] = room[i][j][k] - dCon[4]
					room[i][j-1][k]     = room[i][j-1][k] + dCon[4]
				}
				if i==0 {
					dCon[5] = 0
				}else{
					dCon[5] = (room[i][j][k]-room[i-1][j][k]) * coefficient
					room[i][j][k] = room[i][j][k] - dCon[5]
					room[i-1][j][k] = room[i-1][j][k] + dCon[5]
				}
			}
		}
	}

}*/
