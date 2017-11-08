/* CSC 330
 * Assignment 2 - Diffusion
 *
 * Author: Devin McBryde
 *
 *
 */

package main

import (
	"fmt"
)

//declaration of the variables that define the system at the beginning
//	and will be used throughout the program
var mTotal, time, mSpeed, D, rSize, rDiv, tStep, hval, conMax, conMin float64

//This value will control whether or not a partition will present
//	int the room
var partition bool

func main(){

	//Initializeing all of the necessary variables for the simulation to start 
	const N int = 10

	mTotal = 1000000000000000000000.0
	mSpeed = 250.0
	hval = 5.0/float64(N)
	D = 0.175
	conMax = mTotal
	conMin = 1.0
	tStep = hval/mSpeed

	partition = true;

	var tot float64 = 0.0

	//A 3 dimensional array that will operate as a rank 3 tensor used 
	//	to represent the room 
	var room[N][N][N] float64

	//Following for loops will initialize the room tensor with 0 values 
	//	when partioning is turned off, otherwise locations that 
	//	represent the partion in the room will be initialized
	//	to the value -1
	for i:=0; i<N; i++ {
		for j:=0; j<N; j++{
			for k:=0; k<N; k++{
				if j==(N/2)-1 && i>=(N/2)-1 && partition{
					room[i][j][k] = -1.0
				}else{
					room[i][j][k] = 0.0
				}
			}
		}
	}


	//Provides the room with the gas material to be dispersed
	//	to be understood as the "upper corner" of the room
	room[0][0][0] = mTotal

	//We want the simulation to stop when the room has become sufficiently
	//	diffuse with the gas, thus we check if the ratio of lowest
	//	concentration to highest is less than 0.99, and when it is 
	//	higher we know the gas has diffused
	for (conMin/conMax) < 0.99 {
		time = time + tStep
		dCon := [6]float64{0.0,0.0,0.0,0.0,0.0,0.0}

	        var coefficient float64 = ((D*tStep) / (hval*hval))

	        for i:=0; i<N; i++ {
	                for j:=0; j<N; j++{
	                        for k:=0; k<N; k++{
					if room[i][j][k] != -1{
		                                if k==N-1 || room[i][j][k+1] == -1{
		                                        dCon[0] = 0
		                                }else{
		                                        dCon[0] = (room[i][j][k]    -room[i][j][k+1]) * coefficient
		                                        room[i][j][k] = room[i][j][k] - dCon[0]
		                                        room[i][j][k+1]     = room[i][j][k+1] + dCon[0]
		                                }
		                                if j==N-1 || room[i][j+1][k] == -1{
		                                        dCon[1] = 0
		                                }else{
		                                        dCon[1] = (room[i][j][k]    -room[i][j+1][k]) * coefficient
		                                        room[i][j][k] = room[i][j][k] - dCon[1]
		                                        room[i][j+1][k]     = room[i][j+1][k] + dCon[1]
		                                }
		                                if i==N-1 || room[i+1][j][k] == -1{
		                                        dCon[2] = 0
		                                }else{
		                                        dCon[2] = (room[i][j][k]-room[i+1][j][k]) * coefficient
		                                        room[i][j][k] = room[i][j][k] - dCon[2]
		                                        room[i+1][j][k] = room[i+1][j][k] + dCon[2]
		                                }
		                                if k==0 || room[i][j][k-1] == -1{
		                                        dCon[3] = 0
		                                }else{
		                                        dCon[3] = (room[i][j][k]    -room[i][j][k-1]) * coefficient
		                                        room[i][j][k] = room[i][j][k] - dCon[3]
		                                        room[i][j][k-1]     = room[i][j][k-1] + dCon[3]
		                                }
		                                if j==0 || room[i][j-1][k] == -1{
		                                        dCon[4] = 0
		                                }else{
		                                        dCon[4] = (room[i][j][k]    -room[i][j-1][k]) * coefficient
		                                        room[i][j][k] = room[i][j][k] - dCon[4]
		                                        room[i][j-1][k]     = room[i][j-1][k] + dCon[4]
		                                }
		                                if i==0 || room[i-1][j][k] == -1{
		                                        dCon[5] = 0
		                                }else{
		                                        dCon[5] = (room[i][j][k]-room[i-1][j][k]) * coefficient
		                                        room[i][j][k] = room[i][j][k] - dCon[5]
		                                        room[i-1][j][k] = room[i-1][j][k] + dCon[5]
		                                }
					}
				}
	                }
		}

		conMin = room[0][0][0]
		conMax = room[0][0][0]


		for l:=0; l<N; l++ {
                        for m:=0; m<N; m++{
	                        for n:=0; n<N; n++{
					if room[l][m][n] < conMin && room[l][m][n] != -1{
						conMin = room[l][m][n]
					}
					if room[l][m][n] > conMax && room[l][m][n] != -1{
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
