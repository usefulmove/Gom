;;; comp.el --- RPN interpreter -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2023 Duane Edmonds
;;
;; Author: Duane Edmonds
;; Maintainer: Duane Edmonds <duane.edmonds@gmail.com>
;; Created: August 01, 2023
;; Modified: September 15, 2023
;; Version: 0.0.3
;; Keywords: convenience data tools
;; Homepage: https://github.com/dedmonds/comp
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description:  RPN interpreter
;;
;;; Code:

(load-file "~/repos/cora/src/cora.el")


;; create-unary-stack-function :: (number -> number) -> ([string] -> [string])
(defun create-unary-stack-function (f)
  "Create a numerical unary function that can be applied to a stack. Returns a
decorated function that applies the unary function (F) to the element on the top
of the stack and pushes the result back onto the stack."
  (lambda (stack)
    (let ((a (string-to-number (car stack)))
          (rst (cdr stack)))
      (thread (call f a) ; call function on argument
        'number-to-string
        (_ (cons % rst)))))) ; push the result back onto the stack


;; create-binary-stack-function :: (number -> number -> number) -> ([string] -> [string])
(defun create-binary-stack-function (f)
  "Create a numerical binary function that can be applied to a stack. Returns a
decorated function that applies the binary function (F) to the elements on the top
of the stack and pushes the result back onto the stack."
  (lambda (stack)
    (let ((b (string-to-number (car stack)))
          (a (string-to-number (cadr stack)))
          (rst (cddr stack)))
      (thread (call f a b) ; call function on arguments
        'number-to-string
        (_ (cons % rst)))))) ; push the result back onto the stack


;; apply-swap :: [string] -> [string]
(defun apply-swap (stack)
  "Apply the swap transformation on STACK. Swap the top elements and return
updated stack."
  (let ((b (car stack))
        (a (cadr stack))
        (rst (cddr stack)))
    (cons a (cons b rst))))


;; apply-iota :: [string] -> [string]
(defun apply-iota (stack)
  "Apply the iota transformation on STACK. Add numbers from 1 to the number on
the top of the stack to the stack."
  (let ((a (string-to-number (car stack)))
        (rst (cdr stack)))
    (thread (range 1 (inc a))
      (lambda (lst) ; convert numbers to strings
        (map 'number-to-string lst))
      (lambda (lst) ; add to top of stack
        (append lst rst)))))


;; apply-sum :: [string] -> [string]
(defun apply-sum (stack)
  (let ((res (fold
               (lambda (acc a)
                 (+ acc (string-to-number a)))
               0
               stack)))
    (list (number-to-string res)))) ; return new stack


;; apply-prod :: [string] -> [string]
(defun apply-prod (stack)
  (let ((res (fold
               (lambda (acc a)
                 (* acc (string-to-number a)))
               1
               stack)))
    (list (number-to-string res)))) ; return new stack

;; TODO CONTINUE CODE REVIEW

; define primitive commands
(defvar cmds nil)

(add-to-list 'cmds `("abs"  . ,(create-unary-stack-function 'abs)))
(add-to-list 'cmds `("inv"  . ,(create-unary-stack-function (_ (/ 1.0 %)))))
(add-to-list 'cmds `("sqrt" . ,(create-unary-stack-function 'sqrt)))
(add-to-list 'cmds `("+"    . ,(create-binary-stack-function '+)))
(add-to-list 'cmds `("-"    . ,(create-binary-stack-function '-)))
(add-to-list 'cmds `("*"    . ,(create-binary-stack-function '*)))
(add-to-list 'cmds `("x"    . ,(create-binary-stack-function '*)))
(add-to-list 'cmds `("/"    . ,(create-binary-stack-function '/)))
(add-to-list 'cmds `("^"    . ,(create-binary-stack-function 'expt)))
(add-to-list 'cmds `("mod"  . ,(create-binary-stack-function 'mod)))
(add-to-list 'cmds `("%"    . ,(create-binary-stack-function 'mod)))
(add-to-list 'cmds `("dup"  . ,(lambda (stack) (cons (car stack) stack))))
(add-to-list 'cmds `("pi"   . ,(lambda (stack) (cons (number-to-string pi) stack))))
(add-to-list 'cmds `("iota" . ,'apply-iota))
(add-to-list 'cmds `("io"   . ,'apply-iota))
(add-to-list 'cmds `("swap" . ,'apply-swap))
(add-to-list 'cmds `("sum"  . ,'apply-sum))
(add-to-list 'cmds `("prod" . ,'apply-prod))

; process-op :: string -> [string] -> [string]
(defun process-op (stack op)
  (let ((cmd (assoc op cmds)))
    (if cmd
        (funcall (cdr cmd) stack)
        (cons op stack))))  ; op is not command, add to stack

; evaluate-ops :: string -> [string] -> [string]
(defun evaluate-ops (ops stack)
  (fold 'process-op stack ops))

; evaluate-sexp :: string -> nil (side-effects)
(defun evaluate-sexp (s-exp)
  (let ((result (evaluate-ops (split-string s-exp) '())))
    (kill-new (car result))  ; copy to clipboard
    (message "%s" result)))  ; display as user message

; cmp :: string -> nil (side-effects)
(fset 'cmp #'evaluate-sexp)

; interactive command
(defun comp ()
  "Evaluate RPN expression"
  (interactive)
  (let ((sexp (read-string "Enter expression: ")))
    (evaluate-sexp sexp)))


(provide 'comp)
;; end of comp.el
