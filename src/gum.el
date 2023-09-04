;;; gum.el --- Gum user interface -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Duane Edmonds
;;
;; Author: Duane <duane.edmonds@gmail.com>
;; Maintainer: Duane <duane.edmonds@gmail.com>
;; Created: August 25, 2023
;; Modified: September 3, 2023
;; Version: 0.0.7
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

(global-set-key (kbd "C-c b") 'term)
(global-set-key (kbd "C-c e") 'eros-eval-last-sexp)
(global-set-key (kbd "C-c f") 'find-file-at-point)
(global-set-key (kbd "C-c i") 'gum-insert-eval-last-sexp)
(global-set-key (kbd "C-c l") 'org-insert-link)
(global-set-key (kbd "C-c m") 'gum-move-line-to-eob)
(global-set-key (kbd "C-c o") 'org-open-at-point)
(global-set-key (kbd "C-c w") 'visual-line-mode)


;; set rainbow parens colors
(custom-set-faces
  '(rainbow-delimiters-depth-1-face ((t (:foreground "#fff670"))))
  '(rainbow-delimiters-depth-2-face ((t (:foreground "#c792ea"))))
  '(rainbow-delimiters-depth-3-face ((t (:foreground "#87ffaf"))))
  '(rainbow-delimiters-depth-4-face ((t (:foreground "#00c0ff")))))
'((((()))))


;; load comp RPN interpreter
(load-file "/home/dedmonds/repos/gum/src/comp.el")

;; load magic 8-ball advisor
(load-file "/home/dedmonds/repos/gum/src/magic.el")

;; load enc encryption library
(load-file "/home/dedmonds/repos/enc/src/enc.el")


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
  (goto-char (point-max))
  (unless (bolp) ; insert a newline if not at the beginning of a line (bol)
    (insert "\n"))
  (yank)) ; paste (yank) the line at eob


(defun gum-insert-eval-last-sexp (arg)
  "Evaluate the last S-expression and insert the result into the buffer."
  (interactive "P")
  (insert (concat " ; " (format "%s" (eval-last-sexp arg)))))





(provide 'gum)
;;; gum.el ends here
