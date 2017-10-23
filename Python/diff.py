#!/usr/bin/python

N = 10

mTotal = 1000000000000000000000.0
tot = 0.0
mSpeed = 250.0
hval = 5.0/N
D = 0.175
conMax = mTotal
conMin = 1.0
tStep = hval/mSpeed
time = 0.0

room = [[[0.0 for k in range(N)]for j in range(N)]for i in range(N)]

dCon = [0.0 for i in range(6)]

room[0][0][0] = mTotal

coefficient = ((tStep*D) / (hval*hval))

while (conMin/conMax < 0.99):

    time += tStep

    for i in range(N):
        for j in range(N):
            for k in range(N):

                if (k==N-1):
                    dCon[0]
                else:
                    
                    dCon[0] = (room[i][j][k] - room[i][j][k+1]) * coefficient
                    room[i][j][k] = room[i][j][k] - dCon[0]
                    room[i][j][k+1] = room[i][j][k+1] + dCon[0]
                    
                if (j==N-1):
                    dCon[1]
                else:

                    dCon[1] = (room[i][j][k] - room[i][j+1][k]) * coefficient
                    room[i][j][k] = room[i][j][k] - dCon[1]
                    room[i][j+1][k] = room[i][j+1][k] + dCon[1]

                if (i==N-1):
                    dCon[2]
                else:
 
                    dCon[2] = (room[i][j][k] - room[i+1][j][k]) * coefficient
                    room[i][j][k] = room[i][j][k] - dCon[2]
                    room[i+1][j][k] = room[i+1][j][k] + dCon[2]

                if (k==0):
                    dCon[3]
                else:
                    
                    dCon[3] = (room[i][j][k] - room[i][j][k-1]) * coefficient
                    room[i][j][k] = room[i][j][k] - dCon[3]
                    room[i][j][k-1] = room[i][j][k-1] + dCon[3]

                if (j==0):
                    dCon[4]
                else:
                    
                    dCon[4] = (room[i][j][k] - room[i][j-1][k]) * coefficient
                    room[i][j][k] = room[i][j][k] - dCon[4]
                    room[i][j-1][k] = room[i][j-1][k] + dCon[4]

                if (i==0):
                    dCon[5]
                else:
                   
                    dCon[5] = (room[i][j][k] - room[i-1][j][k]) * coefficient
                    room[i][j][k] = room[i][j][k] - dCon[5]
                    room[i-1][j][k] = room[i-1][j][k] + dCon[5] 



    conMax = room[0][0][0]
    conMin = room[0][0][0]

    for i in range(N):
        for j in range(N):
            for k in range(N):
                if conMax < room[i][j][k]:
                    conMax = room[i][j][k]
                if conMin > room[i][j][k]:
                    conMin = room[i][j][k]



for i in range(N):
    for j in range(N):
        for k in range(N):
            tot+= room[i][j][k]


print "Total molecules starting", mTotal
print "\nTotal molecules left", tot
print "\nTime Simulated", time
print "\nmix concentration", conMin
print "\nmin concentration", conMax

