;;; 1.1 ;;;

(list (cdr (cdr (cdr (quote (1 2 3 4))))) (car (cdr (quote (1 2 3 4)))))
    (cdr (cdr (cdr (quote (1 2 3 4)))))
         (cdr (cdr (quote (1 2 3 4))))
              (cdr (quote (1 2 3 4)))
                   (quote (1 2 3 4))
                   ==> (1 2 3 4)
              ==> (2 3 4)
         ==> (3 4)
    ==> (4)

    (car (cdr (quote (1 2 3 4))))
         (cdr (quote (1 2 3 4)))
              (quote (1 2 3 4))
              ==> (1 2 3 4)
         ==> (2 3 4)
    ==> 2
==> ((4) 2)

;;; 1.2 ;;;

(if (< (car (cdr (quote (5 -3 4 -2)))) (- 2 6)) 0 1)
    (< (car (cdr (quote (5 -3 4 -2)))))
       (car (cdr (quote (5 -3 4 -2))))
            (cdr (quote (5 -3 4 -2)))
                 (quote (5 -3 4 -2))
                 ==> (5 -3 4 -2)
            ==> (-3 4 -2)
       ==> -3
       (- 2 6)
       ==> -4
    ==> #f
    1
    ==> 1
==> 1

;;; 1.3 ;;;

(cons (cdr (quote (1 . 2)))
      (cdr (quote (1 2 . 3))))
==> (2 2 . 3)

;;; 1.4 ;;;

(map (lambda (x) (if (pair? x) (cdr x) x))
     (quote (lambda (x) (if (pair? x) (cdr x) x))))
==> (lambda () ((pair? x) (cdr x) x))
; ja, wir wissen auch warum :)

;;; 1.5 ;;;

(filter (curry < 5)
        (reverse (quote (1 3 5 7 9))))
==> (9 7)

;;; 1.6 ;;;
(filter (compose negative?
                 (lambda (x) (- x 5)))
        (quote (1 3 5 7 9)))
==> (1 3)

