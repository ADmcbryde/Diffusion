(write-line "Hello World")

(write-line "Learning Lisp")

(defconstant N 6)
(defvar mTotal 1000000000000000000000.0)
(defvar mSpeed 250.0)
(defvar hval (/ 5.0 N)) 
(defvar D 0.175) 
(defvar conMax mTotal) 
(defvar conMin 1.0) 
(defvar tStep (/ hval mSpeed))
(defvar totTime 0.0)
(defvar coefficient (/ (* tStep D) (* hval hval)))

(defvar tot 0.0)

(print coefficient)

(setf cube(make-array '(6 6 6)))
(setf dCon(make-array '(6)))

(dotimes (i N)
	(dotimes (j N)
		(dotimes (k N)
			(setf (aref cube i j k) 0.0)
		)
	)
)

(setf (aref cube 0 0 0) mTotal)


(loop

 	(setf totTime (+ totTime tStep))

	(print "Here")

	(dotimes (i N)
	        (dotimes (j N)
		        (dotimes (k N)
			
				(if (= k (- N 1))
					(setf (aref dCon 0) 0.0)
					(progn
					  	(setf (aref dCon 0) (* (- (aref cube i j k) (aref cube i j (+ k 1))) coefficient ) )
						(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 0)))
						(setf (aref cube i j (+ k 1)) (+ (aref cube i j (+ k 1)) (aref dCon 0)))
					)
				)
				(if (= j (- N 1))
					(setf (aref dCon 1) 0.0)
					(progn
					  	(setf (aref dCon 1) (* (- (aref cube i j k) (aref cube i (+ j 1) k)) coefficient ) )
						(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 1)))
						(setf (aref cube i (+ j 1) k) (+ (aref cube i (+ j 1) k) (aref dCon 1)))
					)
				)	
				(if (= i (- N 1))
					(setf (aref dCon 2) 0.0)
					(progn
					  	(setf (aref dCon 2) (* (- (aref cube i j k) (aref cube (+ i 1) j k)) coefficient ) )
						(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 2)))
						(setf (aref cube (+ i 1) j k) (+ (aref cube (+ i 1) j k) (aref dCon 2)))
					)
				)
				(if (= k 0)
					(setf (aref dCon 3) 0.0)
					(progn
					  	(setf (aref dCon 3) (* (- (aref cube i j k) (aref cube i j (- k 1))) coefficient ) )
						(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 3)))
						(setf (aref cube i j (- k 1)) (+ (aref cube i j (- k 1)) (aref dCon 3)))
					)
				)
				(if (= j 0)
					(setf (aref dCon 4) 0.0)
					(progn
					  	(setf (aref dCon 4) (* (- (aref cube i j k) (aref cube i (- j 1) k)) coefficient ) )
						(setf (aref cube i j k) (- (aref cube i j k) (aref dCon 4)))
						(setf (aref cube i (- j 1) k) (+ (aref cube i (- j 1) k) (aref dCon 4)))
					)
				)
				(if (= i 0)
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

	(print "here")

	(setf conMax (aref cube 0 0 0))
	(setf conMin (aref cube 0 0 0))

	(dotimes (i N)
		(dotimes (j N)
			(dotimes (k N)
			  	(if (> (aref cube i j k) conMax)
					(setf conMax (aref cube i j k))
				)
				(if (< (aref cube i j k) conMin)
				  	(setf conMin (aref cube i j k))
				)
			)
		)
	)

	(print "before when")
	
	(when (> (/ conMin conMax) 0.99) (return 0))

	(print "here again")
)

(dotimes (i N)
  	(dotimes (j N)
	  	(dotimes (k N)
		  	(setf tot (+ tot (aref cube i j k)))
		)
	)
)

(print tot)
(print totTime)
