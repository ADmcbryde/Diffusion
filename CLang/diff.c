#include<stdlib.h>
#include<stdio.h>

double mTotal, time, mSpeed, D, rSize, rDiv, tStep, hval, conMax, conMin;

int main(){

	mTotal = 1000000000000000000000.0;
	mSpeed = 250.0;
	hval = 5.0/10.0;
	D = 0.175;
	conMax = mTotal;
	conMin = 1.0;
	tStep = (5.0/mSpeed)/10.0;

	const int N = 10;

	int i,j,k;

	double *room = malloc(N*N*N*sizeof(double));

	for (i=0; i<N; i++) {
		for (j=0; j<N; j++){
			for (k=0; k<N; k++){
				room[i*N*N+j*N+k] = 0.0;//float32(i*N*N+j*N+k+1)
				//fmt.Println(room[i][j][k])
			}
		}
	}

	room[0] = mTotal;

	while( 1 == 0 ){//(conMin/conMax) < 0.99{
		time = time + tStep;
		//step(room [:][:][:]);
		step(room);
	}


	printf("Last Value");//, room[N-1][N-1][N-1])

}

void step(double* alt){

	int i,j,k;
	const int N = 10;

	double dCon = 0;

	//double* room [];

	for (i=0; i<N; i++) {
                for (j=0; j<N; j++){
			for (k=0; k<N; k++){
				//dCon = (D*(room[i+1][j+1][k+1]-room[i][j][k])*tStep) / (hval*hval)
				//room[i][] = room[i][j][k] + dCon
				//room[i+1][j+1][k+1] = room[i+1][j+1][k+1] - dCon

				/*if room[i][j][k] < conMin {
					conMin = room[i][j][k]
				} else if room[i][j][k] > conMax {
					conMax = 0.0
					//room[i][j][k]
				}*/

				dCon = 0.0;
			}
		}
	}

}
