#include<stdlib.h>
#include<stdio.h>

double mTotal, time, mSpeed, D, rSize, rDiv, tStep, hval, conMax, conMin;

#define N 10

int main(){

	mTotal = 1000000000000000000000.0;
	mSpeed = 250.0;
	hval = 5.0/10.0;
	D = 0.175;
	conMax = mTotal;
	conMin = 1.0;
	tStep = (5.0/mSpeed)/10.0;

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

	room[1+N+N*N] = mTotal;

	while ((conMin/conMax) < 0.001){
		time = time + 1;//tStep;
		//step(room [:][:][:]);
		step(room);
	}


	for (i=0; i<N; i++) {
                for (j=0; j<N; j++){
                        for (k=0; k<N; k++){
				printf("%f ",room[i*N*N+j*N+k]);
			}
			printf("\n");
		}
		printf("\n");
	}

	printf("Time Simulated: %f\n", time);
	printf("min concentration: %f\n", conMin);
	printf("max concentration: %f\n", conMax);

	free(room);
}

void step(double* room){

	int i,j,k;
	
	double dCon[6];

	//double* room [];

	conMin = mTotal;
	conMax = 0;

	for (i=1; i<N-1; i++) {
                for (j=1; j<N-1; j++){
			for (k=1; k<N-1; k++){
				dCon[0] = (D*(room[i*N*N+j*N+k+1]-room[i*N*N+j*N+k])*tStep) / (hval*hval);
				dCon[1] = (D*(room[i*N*N+j*N+k+N]-room[i*N*N+j*N+k])*tStep) / (hval*hval);
				dCon[2] = (D*(room[i*N*N+j*N+k+(N*N)]-room[i*N*N+j*N+k])*tStep) / (hval*hval);
				//dCon[3] = (D*(room[i*N*N+j*N+k+1]-room[i*N*N+j*N+k])*tStep) / (hval*hval);
				//dCon[4] = (D*(room[i*N*N+j*N+k+1]-room[i*N*N+j*N+k])*tStep) / (hval*hval);
				//dCon[5] = (D*(room[i*N*N+j*N+k+1]-room[i*N*N+j*N+k])*tStep) / (hval*hval);

				room[i*N*N+j*N+k] = room[i*N*N+j*N+k] + dCon[0] + dCon[1] + dCon[3];
				room[i*N*N+j*N+k+1] = room[i*N*N+j*N+k+1] - dCon[0];
				room[i*N*N+j*N+k+N] = room[i*N*N+j*N+k+N] - dCon[1];
				room[i*N*N+j*N+k+(N*N)] = room[i*N*N+j*N+k+(N*N)] - dCon[2];


				if (room[i*N*N+j*N+k] < conMin) {
					conMin = room[i*N*N+j*N+k];
				}
				if (room[i*N*N+j*N+k] > conMax) {
					conMax = room[i*N*N+j*N+k];
					//room[i][j][k]
				}

				//if(conMin < 1){conMin = 100000000000000000;}

				dCon[0] = 0.0;
			}
		}
	}

}
