;;; gum.el --- Gum user interface -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Duane Edmonds
;;
;; Author: Duane <duane.edmonds@gmail.com>
;; Maintainer: Duane <duane.edmonds@gmail.com>
;; Created: August 25, 2023
;; Modified: September 15, 2023
;; Version: 0.0.11
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


;; custom keybinding layer
(map! :leader
      (:prefix "d"
       :desc "Open (bash) terminal."
             "b"
             #'term
       :desc "Evaluate last S-expression (sexp)."
             "e"
             #'eros-eval-last-sexp
       :desc "Open file at link."
             "f"
             #'find-file-at-point
       :desc "Insert the result of the evaluation of the last S-expression (sexp)."
             "i"
             #'gum-insert-eval-last-sexp
       :desc "Insert org-mode link."
             "l"
             #'org-insert-link
       :desc "Move current line to the end of the current buffer (eob)."
             "m"
             #'gum-move-line-to-eob
       :desc "Open org-mode link."
             "o"
             #'org-open-at-point
       :desc "Toggle visual-line-mode (word wrap)."
             "w"
             #'visual-line-mode))


;; set rainbow parens colors
(defun gum-color-rainbow-parens ()
  (custom-set-faces
    '(rainbow-delimiters-depth-1-face ((t (:foreground "#fff670"))))
    '(rainbow-delimiters-depth-2-face ((t (:foreground "#c792ea"))))
    '(rainbow-delimiters-depth-3-face ((t (:foreground "#87ffaf"))))
    '(rainbow-delimiters-depth-4-face ((t (:foreground "#00c0ff"))))))

(gum-color-rainbow-parens)

'((((()))))


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


;; load comp RPN interpreter
(load-file "/home/dedmonds/repos/gum/src/comp.el")

;; load magic 8-ball advisor
(load-file "/home/dedmonds/repos/gum/src/magic.el")

;; load enc encryption library
(load-file "/home/dedmonds/repos/enc/src/enc.el")



(provide 'gum)
;;; gum.el ends here
