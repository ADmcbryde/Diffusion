#include<stdlib.h>
#include<stdio.h>

double mTotal, time, mSpeed, D, rSize, rDiv, tStep, hval, conMax, conMin;

#define N 10

void step (double* room);

int main(){

	mTotal = 1000000000000000000000.0;
	mSpeed = 250.0;
	hval = 5.0/N;
	D = 0.175;
	conMax = mTotal;
	conMin = 1.0;
	tStep = hval/mSpeed;

	int i,j,k;

	double tot = 0.0;

	double *room = malloc(N*N*N*sizeof(double));

	for (i=0; i<N; i++) {
		for (j=0; j<N; j++){
			for (k=0; k<N; k++){
				room[i*N*N+j*N+k] = 0.0;
			}
		}
	}

	room[0] = mTotal;

	while((conMin/conMax) < 0.99){
		time = time + tStep;
		step(room);
	}

	for (i=0; i<N; i++) {
                for (j=0; j<N; j++){
                        for (k=0; k<N; k++){
                                tot = tot + room[i*N*N+j*N+k];
                        }
                }
        }

	printf("Total molecules starting: %f\n", mTotal);
	printf("Total molecules left: %f\n", tot);
	printf("Time Simulated: %f\n", time);
	printf("min concentration: %f\n", conMin);
	printf("max concentration: %f\n", conMax);

	free(room);
}

void step(double* room){

	int i,j,k;
	
	double dCon[6];
	for(i=0;i<6;i++){dCon[i] = 0.0;}

	double coefficient = ((tStep*D) / (hval*hval));

	for (i=0; i<N; i++){
                for (j=0; j<N; j++){
			for (k=0; k<N; k++){

				//calculate the difference in concentration from flux with each cube face
				if(k==N-1){
					dCon[0] = 0;
				}else{
					dCon[0] = (room[i*N*N+j*N+k]    -room[i*N*N+j*N+k+1]) * coefficient;
					room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[0];
					room[i*N*N+j*N+k+1]     = room[i*N*N+j*N+k+1] + dCon[0];
				}
				if(j==N-1){
					dCon[1] = 0;
				}else{
					dCon[1] = (room[i*N*N+j*N+k]    -room[i*N*N+j*N+k+N]) * coefficient;
					room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[1];
					room[i*N*N+j*N+k+N]     = room[i*N*N+j*N+k+N] + dCon[1];
				}
				if(i==N-1){
					dCon[2] = 0;
				}else{
					dCon[2] = (room[i*N*N+j*N+k]-room[i*N*N+j*N+k+(N*N)]) * coefficient;
					room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[2];
					room[i*N*N+j*N+k+(N*N)] = room[i*N*N+j*N+k+(N*N)] + dCon[2];
				}
				if(k==0){
					dCon[3] = 0;
				}else{
					dCon[3] = (room[i*N*N+j*N+k]    -room[i*N*N+j*N+k-1]) * coefficient;
					room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[3];
					room[i*N*N+j*N+k-1]     = room[i*N*N+j*N+k-1] + dCon[3];
				}
				if(j==0){
					dCon[4] = 0;
				}else{
					dCon[4] = (room[i*N*N+j*N+k]    -room[i*N*N+j*N+k-N]) * coefficient;
					room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[4];
					room[i*N*N+j*N+k-N]     = room[i*N*N+j*N+k-N] + dCon[4];
				}
				if(i==0){
					dCon[5] = 0;
				}else{
					dCon[5] = (room[i*N*N+j*N+k]-room[i*N*N+j*N+k-(N*N)]) * coefficient;
					room[i*N*N+j*N+k] = room[i*N*N+j*N+k] - dCon[5];
					room[i*N*N+j*N+k-(N*N)] = room[i*N*N+j*N+k-(N*N)] + dCon[5];
				}

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
