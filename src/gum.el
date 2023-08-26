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


; load magic 8 ball plugin
(defun magic8 ()
  "Magic 8-ball advice"
  (interactive)
  (let ((magic8-hash (make-hash-table :test 'equal)))
    (puthash 0 "it is certain." magic8-hash)
    (puthash 1 "it is decidedly so." magic8-hash)
    (puthash 2 "without a doubt." magic8-hash)
    (puthash 3 "yes definitely." magic8-hash)
    (puthash 4 "you may rely on it." magic8-hash)
    (puthash 5 "as I see it, yes." magic8-hash)
    (puthash 6 "most likely." magic8-hash)
    (puthash 7 "outlook good." magic8-hash)
    (puthash 8 "yes." magic8-hash)
    (puthash 9 "signs point to yes." magic8-hash)
    (puthash 10 "reply hazy, try again." magic8-hash)
    (puthash 11 "ask again later." magic8-hash)
    (puthash 12 "better not tell you now." magic8-hash)
    (puthash 13 "cannot predict now." magic8-hash)
    (puthash 14 "concentrate and ask again." magic8-hash)
    (puthash 15 "don't count on it." magic8-hash)
    (puthash 16 "my reply is no." magic8-hash)
    (puthash 17 "my sources say no." magic8-hash)
    (puthash 18 "outlook not so good." magic8-hash)
    (puthash 19 "very doubtful." magic8-hash)
      (message (concat "magic8: "(gethash (random (hash-table-count magic8-hash)) magic8-hash)))))

; custom keybinding layer
(global-set-key (kbd "C-c b") 'term)                ; (bash) terminal
(global-set-key (kbd "C-c t") 'term)                ; ( remove? same as above )
(global-set-key (kbd "C-c e") 'eros-eval-last-sexp) ; execute Elisp S-expression
(global-set-key (kbd "C-c o") 'org-open-at-point)   ; open hyperlink
(global-set-key (kbd "C-c w") 'visual-line-mode)    ; toggle word wrap

; set rainbow parens colors
(custom-set-faces
  '(rainbow-delimiters-depth-1-face ((t (:foreground "#e9c687"))))
  '(rainbow-delimiters-depth-2-face ((t (:foreground "#858585"))))
  '(rainbow-delimiters-depth-3-face ((t (:foreground "#87ffaf"))))
  '(rainbow-delimiters-depth-4-face ((t (:foreground "#00c0ff")))))

; load comp RPN interpreter
(load-file "/home/dedmonds/repos/support/emacs/comp.el")

; load enc encryption library
(load-file "/home/dedmonds/repos/enc/src/enc.el")

; insert special character sequences (interactive)
(defun en-dash ()
  (interactive)
  (insert "–"))

(defun em-dash ()
  (interactive)
  (insert "—"))


(provide 'gum)
;;; gum.el ends here
