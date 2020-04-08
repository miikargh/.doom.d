;;; ~/mac-setup/.doom.d/+bindings.el -*- lexical-binding: t; -*-
;;;
(when IS-MAC (setq mac-command-modifier 'meta
                   mac-right-option-modifier nil))

(map!
 (:leader
   (:prefix "b"
     :desc "Previous buffer" "<" #'previous-buffer
     :desc "Next buffer" ">" #'next-buffer)
   (:prefix "d"
     :desc "Autocomplete file" "d" #'company-files)))

;; (map! :n "j" 'evil-backward-char
;;       :n "k" 'evil-next-line
;;       :n "l" 'evil-previous-line
;;       :n "ö" 'evil-forward-char)

(map! (:prefix "gs" :n "s" nil))
(map! (:prefix "gs" :n "s" #'evil-avy-goto-char-timer))

(map! :after python
      :map python-mode-map
      :localleader
      (:prefix ("s" . "shell")
        :desc "Open IPython shell" "i" #'+python/open-ipython-repl
        :desc "Send region to shell" "r" #'python-shell-send-region
        :desc "Send function definition to shell" "f" #'python-shell-send-defun
        :desc "Send buffer to shell" "B" #'python-shell-send-buffer
        :desc "Send string to shell" "s" #'python-shell-send)
      (:prefix ("v" . "pyvenv")
        :desc "Work on virtual environment" "v" #'pyvenv-workon
        :desc "Deactivate virtual environmnent" "d" #'pyvenv-deactivate
        ))

;; (map! :after smartparens-mode
;;       :map paredit-mode-map
;;       (:prefix "k"
;;         :desc "Forward slurp" "s" #'paredit-forward-slurp-sexp
;;         :desc "Backward slurp" "S" #'paredit-backward-slurp-sexp))
;;
(map! :leader
      (:prefix ("k" "smartparens")
        :desc "Slurp forwards" "s" #'sp-forward-slurp-sexp
        :desc "Slurp backwards" "S" #'sp-backward-slurp-sexp
        :desc "Barf forwards" "d" #'sp-forward-barf-sexp
        :desc "Barf backwards" "D" #'sp-backward-barf-sexp))

;; Disable arrow keys for HARD mode
;; (global-unset-key (kbd "<left>"))
;; (global-unset-key (kbd "<right>"))
;; (global-unset-key (kbd "<up>"))
;; (global-unset-key (kbd "<down>"))
