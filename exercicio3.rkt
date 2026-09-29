#lang racket
(require rackunit)

;; item a)
;; struct aluno
;; agrupar os dados do aluno
(struct aluno (ra nome nota1 nota2 nota3 nota4 total_faltas) #:transparent)


;; item b)
;; funcao situacao-aluno
;; verifica a situacao do aluno a, retornando uma string com a situacao do aluno
(define (situacao-aluno a nota-aprovacao carga-horaria perc-max-faltas)
  (if (and (< (/ (+ (aluno-n1 a)(aluno-n2 a)(aluno-n3 a)(aluno-n4 a)) 4) nota-aprovacao)(> (aluno-total_faltas a) (* carga-horaria (/ perc-max-faltas 100))))
        "Reprovado por falta e nota"
        (if (< (/ (+ (aluno-n1 a) (aluno-n2 a) (aluno-n3 a) (aluno-n4 a)) 4) nota-aprovacao) ;; verifica se a media do aluno é menor que a nota de aprovacao
            "Reprovado por nota"
            (if (> (aluno-total_faltas a) (* carga-horaria (/ perc-max-faltas 100))) ;; verifica se o total de faltas do aluno é maior que o limite de faltas permitidas
                "Reprovado por falta"
                "Aprovado"))))

;; Nossa disciplina de teste terá: Aprovação = 6.0, Carga = 60h, Máx Faltas = 25% (ou seja, 15 faltas)
(define a1 (aluno 101 "Ana" 10 10 10 10 0))   ; Aprovada (Média 10, 0 faltas)
(define a2 (aluno 102 "Isa" 5 5 5 5 0))      ; Reprovado por Nota (Média 5, 0 faltas)
(define a3 (aluno 103 "Carlos" 10 10 10 10 20)); Reprovado por Falta (Média 10, 20 faltas)
(define a4 (aluno 104 "Diana" 4 4 4 4 20))    ; Reprovado por Falta e Nota (Média 4, 20 faltas)

;; testes
(check-equal? (situacao-aluno a1 6 60 25) "Aprovado")
(check-equal? (situacao-aluno a2 6 60 25) "Reprovado por nota")
(check-equal? (situacao-aluno a3 6 60 25) "Reprovado por falta")
(check-equal? (situacao-aluno a4 6 60 25) "Reprovado por falta e nota")

;; item c)
