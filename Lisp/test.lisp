#!/usr/bin/sbcl --script
(defvar test)

(setf test(make-array '(5)))

(print  (aref test 5))
