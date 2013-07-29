#lang info

(define collection "honu")
(define deps '("macro-debugger"
               "base"
               "parser-tools-lib"
               "rackunit-lib"))
(define build-deps '("scribble-lib"
                     "at-exp-lib"
                     "sandbox-lib"
                     "racket-doc"))

;; Make honu.vim easier to find by copying it to the "share" directory:
(define copy-shared-files '("contrib/honu.vim"))