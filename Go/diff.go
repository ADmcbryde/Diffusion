package main

import (
	"fmt"
)

var mTotal, time, mSpeed, D, rSize, rDiv, tStep, hval, conMax, conMin float32

func main(){

	mTotal = 1000000000000000000000.0
	mSpeed = 250.0
	hval = 5.0/10.0
	D = 0.175
	conMax = mTotal
	conMin = 1.0
	tStep = (5.0/mSpeed)/10.0

	const N int = 10

	var room[N][N][N] float32

	var test[N]float32

	for i:=0; i<N; i++ {
		for j:=0; j<N; j++{
			for k:=0; k<N; k++{
				room[i][j][k] = 0.0//float32(i*N*N+j*N+k+1)
				//fmt.Println(room[i][j][k])
			}
		}
	}

	room[0][0][0] = mTotal

	for false{//(conMin/conMax) < 0.99{
		time = time + tStep
		//step(room [:][:][:]);
		step(test[:])
	}


	fmt.Println("Last Value", room[N-1][N-1][N-1])

}

func step(alt []float32){

	const N int = 10

	var dCon float32 = 0

	var room [10][10][10]float32
	conMin, conMax = conMax, conMin

	for i:=0; i<N; i++ {
                for j:=0; j<N; j++{
			for k:=0; k<N; k++{
				dCon = (D*(room[i+1][j+1][k+1]-room[i][j][k])*tStep) / (hval*hval)
				room[i][j][k] = room[i][j][k] + dCon
				room[i+1][j+1][k+1] = room[i+1][j+1][k+1] - dCon

				if room[i][j][k] < conMin {
					conMin = room[i][j][k]
				} else if room[i][j][k] > conMax {
					conMax = 0.0
					//room[i][j][k]
				}

				dCon = 0.0
			}
		}
	}

}
