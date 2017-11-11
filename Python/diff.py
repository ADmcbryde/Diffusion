# CSC 330
# Assignment 2 - Diffusion
#
# Author: Devin McBryde
#
#
#

#!/usr/bin/python

#This defines the number of divisions in our room

N = input("Enter Number of Divisions in Room ")

#Here we initialize all of the necessary values to simulate the room
#   and its molecules
mTotal = 1000000000000000000000.0
tot = 0.0
mSpeed = 250.0
hval = 5.0/N
D = 0.175
conMax = mTotal
conMin = 1.0
tStep = hval/mSpeed
time = 0.0

#This controls whether or not a partition is loaded when the
#   room is initialized
partition = True

#A 3 dimensional array that will operate as a rank 3 tensor used 
#	to represent the room 
room = [[[0.0 for k in range(N)]for j in range(N)]for i in range(N)]

#Following for loops will initialize the room tensor with 0 values 
#    when partioning is turned off, otherwise locations that 
#    represent the partion in the room will be initialized
#    to the value -1
for i in range(N):
    for j in range(N):
        for k in range(N):
            if (j==(N/2)-1 and i>=(N/2)-1 and partition):
                room[i][j][k] = -1.0

#This array will store the different values of 
#    change in concentration between two cells
#    The name means concentration difference
dCon = [0.0 for i in range(6)]

room[0][0][0] = mTotal

#Every time we check to see the flux of gas between cells
#    we would also need to multiply several values,
#    slowing the speed of computation. By calculating the
#    value once we only need to perform a single
#    multiplication each time afterwards for each cell
#    instead of several
coefficient = ((tStep*D) / (hval*hval))

#We want the simulation to stop when the room has become sufficiently
    #diffuse with the gas, thus we check if the ratio of lowest
    #concentration to highest is less than 0.99, and when it is 
    #higher we know the gas has diffused
while (conMin/conMax < 0.99):

    time += tStep

    for i in range(N):
        for j in range(N):
            for k in range(N):
                if (room[i][j][k] != -1):
                    
                    #calculate the difference in concentration from flux with each cube face
                        #The 6 faces of the cube are represented with different address values
                        #and an if is used to determine if it is safe to move molecules
                        #if a value = N-1  or 0 then we have hit a face of the cube and do not calculate

                    if (k==N-1 or room[i][j][k+1] == -1.0):
                        dCon[0]
                    else:
                        
                        dCon[0] = (room[i][j][k] - room[i][j][k+1]) * coefficient
                        room[i][j][k] = room[i][j][k] - dCon[0]
                        room[i][j][k+1] = room[i][j][k+1] + dCon[0]
                        
                    if (j==N-1 or room[i][j+1][k] == -1):
                        dCon[1]
                    else:
    
                        dCon[1] = (room[i][j][k] - room[i][j+1][k]) * coefficient
                        room[i][j][k] = room[i][j][k] - dCon[1]
                        room[i][j+1][k] = room[i][j+1][k] + dCon[1]
    
                    if (i==N-1 or room[i+1][j][k] == -1):
                        dCon[2]
                    else:
     
                        dCon[2] = (room[i][j][k] - room[i+1][j][k]) * coefficient
                        room[i][j][k] = room[i][j][k] - dCon[2]
                        room[i+1][j][k] = room[i+1][j][k] + dCon[2]
    
                    if (k==0 or room[i][j][k-1] == -1):
                        dCon[3]
                    else:
                        
                        dCon[3] = (room[i][j][k] - room[i][j][k-1]) * coefficient
                        room[i][j][k] = room[i][j][k] - dCon[3]
                        room[i][j][k-1] = room[i][j][k-1] + dCon[3]
    
                    if (j==0 or room[i][j-1][k] == -1):
                        dCon[4]
                    else:
                        
                        dCon[4] = (room[i][j][k] - room[i][j-1][k]) * coefficient
                        room[i][j][k] = room[i][j][k] - dCon[4]
                        room[i][j-1][k] = room[i][j-1][k] + dCon[4]
    
                    if (i==0 or room[i-1][j][k] == -1):
                        dCon[5]
                    else:
                       
                        dCon[5] = (room[i][j][k] - room[i-1][j][k]) * coefficient
                        room[i][j][k] = room[i][j][k] - dCon[5]
                        room[i-1][j][k] = room[i-1][j][k] + dCon[5] 
                
    #after resetting the concentration values we then find the values of min and max
        #in order to tell when the loop shall end

    conMax = room[0][0][0]
    conMin = room[0][0][0]

    

    for i in range(N):
        for j in range(N):
            for k in range(N):
                if conMax < room[i][j][k] and room[i][j][k] != -1:
                    conMax = room[i][j][k]
                if conMin > room[i][j][k] and room[i][j][k] != -1:
                    conMin = room[i][j][k]

#Here we total the values stored in all of the cells to check
    #for any signifcant amount of lost or gained matter

for i in range(N):
    for j in range(N):
        for k in range(N):
            tot+= room[i][j][k]


#output of the simulation detailing 5 vaules
    #How many molecules did we start with
    #How many molecules did we end with
    #The total amount of time it took for the room to become diffused
    #The minimum concentration in the room
    #the maximum concentration in the room

print "Total molecules starting", mTotal
print "Total molecules left", tot
print "Time Simulated", time
print "max concentration", conMin
print "min concentration", conMax

