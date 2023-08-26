;;; gum.el --- Gum user interface -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2023 Robert Duane Edmonds
;;
;; Author: Duane <duane.edmonds@gmail.com>
;; Maintainer: Duane <duane.edmonds@gmail.com>
;; Created: August 25, 2023
;; Modified: August 25, 2023
;; Version: 0.0.1
;; Keywords: convenience data emulations extensions faces files frames languages lisp tools
;; Homepage: https://github.com/usefulmove/gum
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description: Gum emacs user interface
;;
;;; Code:


;; custom keybinding layer
(global-set-key (kbd "C-c b") 'term)                ; (bash) terminal
(global-set-key (kbd "C-c t") 'term)                ; ( remove? same as above )
(global-set-key (kbd "C-c e") 'eros-eval-last-sexp) ; execute Elisp S-expression
(global-set-key (kbd "C-c o") 'find-file-at-point)  ; open hyperlink
(global-set-key (kbd "C-c w") 'visual-line-mode)    ; toggle word wrap


;; set rainbow parens colors
(custom-set-faces
  '(rainbow-delimiters-depth-1-face ((t (:foreground "#e9c687"))))
  '(rainbow-delimiters-depth-2-face ((t (:foreground "#858585"))))
  '(rainbow-delimiters-depth-3-face ((t (:foreground "#87ffaf"))))
  '(rainbow-delimiters-depth-4-face ((t (:foreground "#00c0ff")))))


;; load comp RPN interpreter
(load-file "/home/dedmonds/repos/support/emacs/comp.el")


;; load enc encryption library
(load-file "/home/dedmonds/repos/enc/src/enc.el")


;; load magic 8-ball advisor
(load-file "/home/dedmonds/repos/gum/src/magic.el")


;; insert special character sequences (interactive)
(defun en-dash ()
  (interactive)
  (insert "–"))

(defun em-dash ()
  (interactive)
  (insert "—"))


(provide 'gum)
;;; gum.el ends here
