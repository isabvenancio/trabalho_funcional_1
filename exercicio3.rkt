#lang racket
(require rackunit)

;; struct aluno
;; agrupar os dados do aluno
(struct aluno (ra nome nota1 nota2 nota3 nota4 total_faltas) #:transparent)

;; funcao media-aluno
;; calcula a media do aluno a partir das notas 1, 2, 3 e 4, somando as notas e dividindo por 4
(define (media-aluno a)
  (/ (+ (aluno-n1 a) (aluno-n2 a) (aluno-n3 a) (aluno-n4 a)) 4))

;; funcao limite-faltas
;; calcula o limite de faltas permitidas do aluno a partir da carga horaria e do percentual max
(define (limite-faltas carga-horaria perc-max)
  (* carga-horaria (/ perc-max 100)))

;; funcao reprovado-nota
;; verifica se o aluno a foi reprovado por nota, comparando a media do aluno com a nota de aprovacao
(define (reprovado-nota? a nota-aprovacao)
  (< (media-aluno a) nota-aprovacao))

;; funcao reprovado-falta
;; verifica se o aluno a foi reprovado por falta, comparando as faltas do aluno com o limite de faltas permitidas
(define (reprovado-falta? a carga-horaria perc-max-faltas)
  (> (aluno-total_faltas a) (limite-faltas carga-horaria perc-max-faltas)))

;; funcao situacao-aluno
;; verifica a situacao do aluno a, retornando uma string com a situacao do aluno
(define (situacao-aluno a nota-aprovacao carga-horaria perc-max-faltas)
  (if (and (reprovado-nota? a nota-aprovacao)(reprovado-falta? a carga-horaria perc-max-faltas))
      "Reprovado por falta e nota"
      (if (reprovado-nota? a nota-aprovacao)
          "Reprovado por nota"
          (if (reprovado-falta? a carga-horaria perc-max-faltas)
              "Reprovado por falta"
              "Aprovado"))))

;; Nossa disciplina de teste terá: Aprovação = 6.0, Carga = 60h, Máx Faltas = 25% (ou seja, 15 faltas)
(define a1 (aluno 101 "Ana" 10 10 10 10 0))   ; Aprovada (Média 10, 0 faltas)
(define a2 (aluno 102 "Isa" 5 5 5 5 0))      ; Reprovado por Nota (Média 5, 0 faltas)
(define a3 (aluno 103 "Carlos" 10 10 10 10 20)); Reprovado por Falta (Média 10, 20 faltas)
(define a4 (aluno 104 "Diana" 4 4 4 4 20))    ; Reprovado por Falta e Nota (Média 4, 20 faltas)

;; Executando os testes
(check-equal? (situacao-aluno a1 6 60 25) "Aprovado")
(check-equal? (situacao-aluno a2 6 60 25) "Reprovado por nota")
(check-equal? (situacao-aluno a3 6 60 25) "Reprovado por falta")
(check-equal? (situacao-aluno a4 6 60 25) "Reprovado por falta e nota")

;; 