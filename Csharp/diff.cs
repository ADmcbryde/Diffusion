using System;
class Diffusion{

	static public void Main(string[] args){

		const int N = 10;

		double mTotal = 1000000000000000000000.0;
		double tot = 0.0;
		double mSpeed = 250.0;
		double hval = 5.0/(double)N;
		double D = 0.175;
		double conMax = mTotal;
		double conMin = 1.0;
		double tStep = hval/mSpeed;
		double time = 0.0;

		bool partition = true;

		double[,,] room = new double[N,N,N];
		double[] dCon = new double[6];

		for(int i = 0; i < N; i++){
			for(int j = 0; j < N; j++){
				for(int k = 0; k< N; k++){
					if(j == (N/2) && i >= (N/2) && partition){
						room[i,j,k] = -1.0;
					}else{
						room[i,j,k] = 0.0;
					}
				}
			}
		}

		Console.WriteLine(1 == 1.0);

		room[0,0,0]  = mTotal;

		double coefficient = ((tStep * D)/(hval * hval));

		while (conMin/conMax < 0.99){

			time += tStep;

			for(int i = 0; i < N; i++){
				for(int j = 0; j < N; j++){
					for(int k = 0; k< N; k++){
						
						if(room[i,j,k] != -1){
						
							if(k==N-1 || room[i,j,k+1] == -1){
								dCon[0] = 0;
							}else{
								dCon[0] = (room[i,j,k]    -room[i,j,k+1]) * coefficient;
								room[i,j,k] = room[i,j,k] - dCon[0];
								room[i,j,k+1]     = room[i,j,k+1] + dCon[0];
							}
							if(j==N-1 || room[i,j+1,k] == -1){
								dCon[1] = 0;
							}else{
								dCon[1] = (room[i,j,k]    -room[i,j+1,k]) * coefficient;
								room[i,j,k] = room[i,j,k] - dCon[1];
								room[i,j+1,k]     = room[i,j+1,k] + dCon[1];
							}
							if(i==N-1 || room[i+1,j,k] == -1){
								dCon[2] = 0;
							}else{
								dCon[2] = (room[i,j,k]-room[i+1,j,k]) * coefficient;
								room[i,j,k] = room[i,j,k] - dCon[2];
								room[i+1,j,k] = room[i+1,j,k] + dCon[2];
							}
							if(k==0 || room[i,j,k-1] == -1){
								dCon[3] = 0;
							}else{
								dCon[3] = (room[i,j,k]    -room[i,j,k-1]) * coefficient;
								room[i,j,k] = room[i,j,k] - dCon[3];
								room[i,j,k-1]     = room[i,j,k-1] + dCon[3];
							}
							if(j==0 || room[i,j-1,k] == -1){
								dCon[4] = 0;
							}else{
								dCon[4] = (room[i,j,k]    -room[i,j-1,k]) * coefficient;
								room[i,j,k] = room[i,j,k] - dCon[4];
								room[i,j-1,k]     = room[i,j-1,k] + dCon[4];
							}
							if(i==0 || room[i-1,j,k] == -1){
								dCon[5] = 0;
							}else{
								dCon[5] = (room[i,j,k]-room[i-1,j,k]) * coefficient;
								room[i,j,k] = room[i,j,k] - dCon[5];
								room[i-1,j,k] = room[i-1,j,k] + dCon[5];
							}
						}
					}
				}
			}

			conMax = room[0,0,0];
			conMin = room[0,0,0];

			for(int i = 0; i < N; i++){
				for(int j = 0; j < N; j++){
					for(int k = 0; k< N; k++){
						if(conMax < room[i,j,k] && room[i,j,k] != -1){
							conMax = room[i,j,k];
						}
						if(conMin > room[i,j,k] && room[i,j,k] != -1){
							conMin = room[i,j,k];
						}	
					}
				}
			}

		}

		for(int i = 0; i < N; i++){
			for(int j = 0; j < N; j++){
				for(int k = 0; k< N; k++){
					tot += room[i,j,k];
				}
			}
		}

		Console.WriteLine("Total molecules starting: " + mTotal);
		Console.WriteLine("Total molecules left: " + tot);
		Console.WriteLine("Time Simulated: " + time);
		Console.WriteLine("max concentration: " + conMax);
		Console.WriteLine("min concentration: " + conMin);


	}

}
