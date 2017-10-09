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
	tStep = hval/mSpeed;

	int i,j,k;

	float tot = 0.0;

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

	while ((conMin/conMax) < 0.99){
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

	for (i=0; i<N; i++) {
                for (j=0; j<N; j++){
                        for (k=0; k<N; k++){
                                tot = tot + room[i*N*N+j*N+k];
                        }
                }
        }

	printf("Total molecules left: %f\n", tot);
	printf("Total molecules left: %f\n", mTotal);
	printf("Time Simulated: %f\n", time);
	printf("min concentration: %f\n", conMin);
	printf("max concentration: %f\n", conMax);

	printf("D coefficient: %f", ((tStep*D)/(hval*hval)));

	free(room);
}

void step(double* room){

	int i,j,k;
	
	double dCon[6];
	for(i=0;i<6;i++){dCon[i] = 0.0;}

	conMin = mTotal;
	conMax = 0;

	for (i=0; i<N; i++) {
                for (j=0; j<N; j++){
			for (k=0; k<N; k++){

				//calculate the difference in concentration from flux with each cube face
				if(k==N){dCon[0] = 0;}else{dCon[0] = (room[i*N*N+j*N+k]    -room[i*N*N+j*N+k+1]) * (tStep*D) / (hval*hval);}
				if(j==N){dCon[1] = 0;}else{dCon[1] = (room[i*N*N+j*N+k]    -room[i*N*N+j*N+k+N]) * (tStep*D) / (hval*hval);}
				if(i==N){dCon[2] = 0;}else{dCon[2] = (room[i*N*N+j*N+k]-room[i*N*N+j*N+k+(N*N)]) * (tStep*D) / (hval*hval);}
				if(k==0){dCon[3] = 0;}else{dCon[3] = (room[i*N*N+j*N+k]    -room[i*N*N+j*N+k-1]) * (tStep*D) / (hval*hval);}
				if(j==0){dCon[4] = 0;}else{dCon[4] = (room[i*N*N+j*N+k]    -room[i*N*N+j*N+k-N]) * (tStep*D) / (hval*hval);}
				if(i==0){dCon[5] = 0;}else{dCon[5] = (room[i*N*N+j*N+k]-room[i*N*N+j*N+k-(N*N)]) * (tStep*D) / (hval*hval);}

				//Apply the difference for each cube touching the current cube, and change the value in the current cube
				room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[0];
				room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[1];
			       	room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[2];
 			        room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[3];
			        room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[4];
			       	room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[5];

				if(k!=N){room[i*N*N+j*N+k+1]     = room[i*N*N+j*N+k+1] + dCon[0];}
				if(j!=N){room[i*N*N+j*N+k+N]     = room[i*N*N+j*N+k+N] + dCon[1];}
				if(i!=N){room[i*N*N+j*N+k+(N*N)] = room[i*N*N+j*N+k+(N*N)] + dCon[2];}
				if(k!=0){room[i*N*N+j*N+k-1]     = room[i*N*N+j*N+k-1] + dCon[3];}
				if(j!=0){room[i*N*N+j*N+k-N]     = room[i*N*N+j*N+k-N] + dCon[4];}
				if(i!=0){room[i*N*N+j*N+k-(N*N)] = room[i*N*N+j*N+k-(N*N)] + dCon[5];}

				//reset dCon values
				dCon[0] = 0.0;
				dCon[1] = 0.0;
				dCon[2] = 0.0;
				dCon[3] = 0.0;
                                dCon[4] = 0.0;
                                dCon[5] = 0.0;
			}
		}
	}

	conMin = room[0];
	conMax = room[0];

	for (i=0; i<N; i++) {
                for (j=0; j<N; j++){
                        for (k=0; k<N; k++){
				if (room[i*N*N+j*N+k] < conMin) {
                                        conMin = room[i*N*N+j*N+k];
                                }
                                if (room[i*N*N+j*N+k] > conMax) {
                                        conMax = room[i*N*N+j*N+k];
                                }	
			}
		}
	}

}
