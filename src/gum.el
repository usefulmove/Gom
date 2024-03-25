;;; gum.el --- Gum user interface -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Duane Edmonds
;;
;; Author: Duane Edmonds <duane.edmonds@gmail.com>
;; Maintainer: Duane Edmonds <duane.edmonds@gmail.com>
;; Created: August 25, 2023
;; Modified: March 24, 2024
;; Version: 0.1.13
;; Keywords: convenience data emulations extensions faces files frames languages lisp tools
;; Homepage: https://github.com/usefulmove/gum
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description: Gum user interface for Emacs
;;
;;; Code:



;; set rainbow parens colors
(defun gum-color-rainbow-parens ()
  (interactive)
  (custom-set-faces
    '(rainbow-delimiters-depth-1-face ((t (:foreground "#fff670"))))
    '(rainbow-delimiters-depth-2-face ((t (:foreground "#c792ea"))))
    '(rainbow-delimiters-depth-3-face ((t (:foreground "#87ffaf"))))
    '(rainbow-delimiters-depth-4-face ((t (:foreground "#00c0ff"))))))

(gum-color-rainbow-parens)


;; insert special character sequences (interactive)
(defun gum-en-dash ()
  "Insert en-dash."
  (interactive)
  (insert "–"))


(defun gum-em-dash ()
  "Insert em-dash."
  (interactive)
  (insert "—"))


(defun gum-move-line-to-eob ()
  "Move the current line to the end of the buffer."
  (interactive)
  (kill-whole-line)
  (let ((return-point (point)))
    (goto-char (point-max))
    (unless (bolp) ; insert a newline if not at the beginning of a line (bol)
      (insert "\n"))
    (yank) ; paste (yank) the line at eob
    (goto-char return-point))) ; move back to original point


(defun gum-insert-eval-last-sexp (arg)
  "Evaluate the last S-expression and insert the result into the buffer."
  (interactive "P")
  (forward-char)
  (insert (concat " ; " (format "%s" (eval-last-sexp arg)))))


(defun gum-copy-sexp-at-point ()
  "Copy the s-expression at the point."
  (interactive)
  (let ((sexp (thing-at-point 'sexp t)))
    (if sexp (do ; add the sexp to the top of the kill ring without
               (kill-new sexp) ; ... removing it from the buffer
               (message "Copied s-expression."))
        (message "No s-expression under point."))))


;; load comp RPN interpreter
(load-file "/home/dedmonds/repos/gum/src/comp.el")

;; load magic 8-ball advisor
(load-file "/home/dedmonds/repos/gum/src/magic.el")

;; load enc encryption library
(load-file "/home/dedmonds/repos/enc/src/enc.el")



(provide 'gum)
;;; gum.el ends here
