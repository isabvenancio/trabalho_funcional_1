#lang racket
(require rackunit)

;Topo
(define (topo pilha)
  (cond
    [(empty? pilha) "A pilha está vazia"]
    [else (first pilha)]))
  
;Empilhar
(define (empilhar pilha valor)
  (cons valor pilha))

;Desempilhar
(define (desempilhar pilha)
  (cond
    [(empty? pilha) "A pilha está vazia"]
    [else (rest pilha)]))

; Testes
(define pilha '(1 2 3 4 5))
(check-equal? (topo pilha) 1)
(check-equal? (empilhar pilha 0) '(0 1 2 3 4 5))
(check-equal? (desempilhar pilha) '(2 3 4 5))