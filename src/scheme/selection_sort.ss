(define minst
  (lambda (s)
    (cond ((null? (cdr s)) (car s))
          ((< (car s) (minst (cdr s))) (car s))
          (else 
            (minst (cdr s))))))

(define remove-item
  (lambda (i s)
    (cond ((null? s) '())
          ((= i (car s)) (remove-item i (cdr s)))
          (else
            (cons (car s) (remove-item i (cdr s)))))))

(define selection-sort
  (lambda (s)
    (cond ((null? s) '())
          (else (cons (minst s)
                      (selection-sort (remove-item (minst s) s)))))))

(display (selection-sort '(7 1 0 5 3 8 4 2 9 6)))
