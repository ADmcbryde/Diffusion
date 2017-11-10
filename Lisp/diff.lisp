; CSC 330
;Assignment 2 - Diffusion
;
;Author: Devin McBryde
;
;
;

#!/usr/bin/sbcl --script

;Initialization of all necessary variables for the programs

;Determines the number of divisions used in each dimension of the room
(defconstant N 10)
(defvar mTotal 1000000000000000000000.0)
(defvar mSpeed 250.0)
(defvar hval (/ 5.0 N)) 
(defvar D 0.175) 
(defvar conMax mTotal) 
(defvar conMin 1.0) 
(defvar tStep (/ hval mSpeed))
(defvar totTime 0.0)

;Every time we check to see the flux of gas between cells
;	we would also need to multiply several values,
;	slowing the speed of computation. By calculating the
;	value once we only need to perform a single
;	multiplication each time afterwards for each cell
;	instead of several
(defvar coefficient (/ (* tStep D) (* hval hval)))

;Will be used to sum up the total molecules left after the simulation
;	Uesd to check for matter consistency
(defvar tot 0.0)
(defvar partition t)

;Declaration of the cube in memory
;	The variable is declared cube instead of room in Lisp
;	since room is a keyword in the language
(defvar cube)
(defvar dCon)

;Here we total the values stored in all of the cells to check
;	for any signifcant amount of lost or gained matter
(setf cube(make-array (list N N N)))
(setf dCon(make-array '(6)))

;Following for loops will initialize the room tensor with 0 values 
	;	when partioning is turned off, otherwise locations that 
	;	represent the partion in the room will be initialized
	;	to the value -1
(dotimes (i N)
	(dotimes (j N)
		(dotimes (k N)
			(if (and partition (= j (- (/ N 2) 1)) (>= i (- (/ N 2) 1)) )
				(setf (aref cube i j k) -1.0)
				(setf (aref cube i j k) 0.0)
			)
		)
	)
)

;Provides the room with the gas material to be dispersed
	;	to be understood as the "upper corner" of the room
(setf (aref cube 0 0 0) mTotal)

;We want the simulation to stop when the room has become sufficiently
	;diffuse with the gas, thus we check if the ratio of lowest
	;concentration to highest is greater than 0.99, and then we break
	;the loop
(loop

 	(setf totTime (+ totTime tStep))


	(dotimes (i N)
	        (dotimes (j N)
		        (dotimes (k N)
				(if (/= (aref cube i j k) -1.0)
				  	(progn
					(if (or (= k (- N 1)) (= (aref cube i j (+ k 1)) -1.0) )
						(setf (aref dCon 0) 0.0)
						(progn
						  	(setf (aref dCon 0) (* (- (aref cube i j k) (aref cube i j (+ k 1))) coefficient ) )
							(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 0)))
							(setf (aref cube i j (+ k 1)) (+ (aref cube i j (+ k 1)) (aref dCon 0)))
						)
					)
					(if (or (= j (- N 1)) (= (aref cube i (+ j 1) k) -1.0) )
						(setf (aref dCon 1) 0.0)
						(progn
						  	(setf (aref dCon 1) (* (- (aref cube i j k) (aref cube i (+ j 1) k)) coefficient ) )
							(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 1)))
							(setf (aref cube i (+ j 1) k) (+ (aref cube i (+ j 1) k) (aref dCon 1)))
						)
					)	
					(if (or (= i (- N 1)) (= (aref cube (+ i 1) j k) -1.0) )
						(setf (aref dCon 2) 0.0)
						(progn
						  	(setf (aref dCon 2) (* (- (aref cube i j k) (aref cube (+ i 1) j k)) coefficient ) )
							(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 2)))
							(setf (aref cube (+ i 1) j k) (+ (aref cube (+ i 1) j k) (aref dCon 2)))
						)
					)
					(if (or (= k 0) (= (aref cube i j (- k 1)) -1.0) )
						(setf (aref dCon 3) 0.0)
						(progn
						  	(setf (aref dCon 3) (* (- (aref cube i j k) (aref cube i j (- k 1))) coefficient ) )
							(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 3)))
							(setf (aref cube i j (- k 1)) (+ (aref cube i j (- k 1)) (aref dCon 3)))
						)
					)
					(if (or (= j 0) (= (aref cube i (- j 1) k) -1.0) )
						(setf (aref dCon 4) 0.0)
						(progn
						  	(setf (aref dCon 4) (* (- (aref cube i j k) (aref cube i (- j 1) k)) coefficient ) )
							(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 4)))
							(setf (aref cube i (- j 1) k) (+ (aref cube i (- j 1) k) (aref dCon 4)))
						)
					)
					(if (or (= i 0) (= (aref cube (- i 1) j k) -1.0) )
						(setf (aref dCon 5) 0.0)
						(progn
						  	(setf (aref dCon 5) (* (- (aref cube i j k) (aref cube (- i 1) j k)) coefficient ) )
							(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 5)))
							(setf (aref cube (- i 1) j k) (+ (aref cube (- i 1) j k) (aref dCon 5)))
						)
					)
					)
				)
			)
		)
	)

	(setf conMax (aref cube 0 0 0))
	(setf conMin (aref cube 0 0 0))

	(dotimes (i N)
		(dotimes (j N)
			(dotimes (k N)
			  	(if (and (> (aref cube i j k) conMax) (/= (aref cube i j k) -1.0) )
					(setf conMax (aref cube i j k))
				)
				(if (and (< (aref cube i j k) conMin) (/= (aref cube i j k) -1.0) )
				  	(setf conMin (aref cube i j k))
				)
			)
		)
	)


	
	(when (>= (/ conMin conMax) 0.99) (return 0))

)

;Here we total the values stored in all of the cells to check
	;for any signifcant amount of lost or gained matter
(dotimes (i N)
  	(dotimes (j N)
	  	(dotimes (k N)
		  	(setf tot (+ tot (aref cube i j k)))
		)
	)
)

;output of the simulation detailing 5 vaules
	;How many molecules did we start with
	;How many molecules did we end with
	;The total amount of time it took for the room to become diffused
	;The minimum concentration in the room
	;the maximum concentration in the room
(print mTotal)
(print tot)
(print totTime)
(print conMax)
(print conMin)
