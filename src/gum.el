;;; gum.el --- Gum user interface -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Duane Edmonds
;;
;; Author: Duane <duane.edmonds@gmail.com>
;; Maintainer: Duane <duane.edmonds@gmail.com>
;; Created: August 25, 2023
;; Modified: August 31, 2023
;; Version: 0.0.4
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

(global-set-key (kbd "C-c b") 'term)                ; open (bash) terminal
(global-set-key (kbd "C-c e") 'eros-eval-last-sexp) ; execute Elisp S-expression
(global-set-key (kbd "C-c l") 'org-insert-link)     ; insert link (org-mode)
(global-set-key (kbd "C-c m") 'gum-move-line-to-end-of-buffer) ; move line to eob
(global-set-key (kbd "C-c o") 'org-open-at-point)   ; open hyperlink (org-mode)
(global-set-key (kbd "C-c w") 'visual-line-mode)    ; toggle word wrap


;; set rainbow parens colors
(custom-set-faces
  '(rainbow-delimiters-depth-1-face ((t (:foreground "#fff670"))))
  '(rainbow-delimiters-depth-2-face ((t (:foreground "#858585"))))
  '(rainbow-delimiters-depth-3-face ((t (:foreground "#87ffaf"))))
  '(rainbow-delimiters-depth-4-face ((t (:foreground "#00c0ff")))))


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


(defun gum-move-line-to-end-of-buffer ()
  "Move the current line to the end of the buffer."
  (interactive)
  ; kill (cut) the line
  (kill-whole-line)
  ; go to the end of the buffer
  (goto-char (point-max))
  ; insert a newline if not at the beginning of a line (bol)
  (unless (bolp)
    (insert "\n"))
  ; yank (paste) the line
  (yank))



(provide 'gum)
;;; gum.el ends here
