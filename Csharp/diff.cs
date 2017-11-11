/* CSC 330
 * Assignment 2 - Diffusion
 *
 * Author: Devin McBryde
 *
 *
 */

using System;
class Diffusion{

	static public void Main(string[] args){


		//Prompts for size of room	
		Console.WriteLine("Enter Number of Divisions in Room");

		string input = Console.ReadLine();

		//The initialization of all necessary variables for the programs
		
		//Determines the number of divisions used in each dimension of the room
		int N = 10;

		//Try to parse input, if failure occurs uses N = 10
		if(!Int32.TryParse(input,out N)){
			N = 10;
		}

		//The number of molcules that will be placed in the room
		double mTotal = 1000000000000000000000.0;
		double tot = 0.0;
		double mSpeed = 250.0;
		double hval = 5.0/(double)N;
		double D = 0.175;
		double conMax = mTotal;
		double conMin = 1.0;
		double tStep = hval/mSpeed;
		double time = 0.0;

		//Will control when the partition is added to the simulation of the room
		bool partition = false;

		//A 3 dimensional array that will operate as a rank 3 tensor used 
		//	to represent the room 
		double[,,] room = new double[N,N,N];

		//This array will store the different values of 
		//	change in concentration between two cells
		//	The name means concentration difference
		double[]dCon = new double[6];

		//Following for loops will initialize the room tensor with 0 values 
		//	when partioning is turned off, otherwise locations that 
		//	represent the partion in the room will be initialized
		//	to the value -1
		for(int i = 0; i < N; i++){
			for(int j = 0; j < N; j++){
				for(int k = 0; k< N; k++){
					if(j == (N/2)-1 && i >= (N/2)-1 && partition){
						room[i,j,k] = -1.0;
					}else{
						room[i,j,k] = 0.0;
					}
				}
			}
		}
	
		//Provides the room with the gas material to be dispersed
		//	to be understood as the "upper corner" of the room
		room[0,0,0]  = mTotal;

		//Every time we check to see the flux of gas between cells
		//	we would also need to multiply several values,
		//	slowing the speed of computation. By calculating the
		//	value once we only need to perform a single
		//	multiplication each time afterwards for each cell
		//	instead of several
		double coefficient = ((tStep * D)/(hval * hval));

		//We want the simulation to stop when the room has become sufficiently
		//	diffuse with the gas, thus we check if the ratio of lowest
		//	concentration to highest is less than 0.99, and when it is 
		//	higher we know the gas has diffused
		while (conMin/conMax < 0.99){

			time += tStep;

			for(int i = 0; i < N; i++){
				for(int j = 0; j < N; j++){
					for(int k = 0; k< N; k++){
	
						//calculate the difference in concentration from flux with each cube face
						//	The 6 faces of the cube are represented with different address values
						//	and an if is used to determine if it is safe to move molecules
						//	if a value = N-1  or 0 then we have hit a face of the cube and do not calculate
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

			//after resetting the concentration values we then find the values of min and max
			//	in order to tell when the loop shall end
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

		//Here we total the values stored in all of the cells to check
		//	for any signifcant amount of lost or gained matter
		for(int i = 0; i < N; i++){
			for(int j = 0; j < N; j++){
				for(int k = 0; k< N; k++){
					tot += room[i,j,k];
				}
			}
		}

		//output of the simulation detailing 5 vaules
		//	How many molecules did we start with
		//	How many molecules did we end with
		//	The total amount of time it took for the room to become diffused
		//	The minimum concentration in the room
		//	the maximum concentration in the room
		Console.WriteLine("Total molecules starting: " + mTotal);
		Console.WriteLine("Total molecules left: " + tot);
		Console.WriteLine("Time Simulated: " + time);
		Console.WriteLine("min concentration: " + conMin);
		Console.WriteLine("max concentration: " + conMax);


	}

}
