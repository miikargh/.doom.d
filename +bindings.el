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

;; (defun insert-python-breakpoint ()
;;   "Adds a IPython breakpoint to where the cursor is."
;;   (insert "from IPython.core.debugger import set_trace; set_trace()"))
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
        )
      (:prefix ("f" . "format")
       :desc "Format all buffer" "a" #'format-all-buffer)
      ;; (:prefix ("f" . "format")
      ;;  :desc "Format buffer" "a" #'py-yapf-buffer)
      )


;; (map! :after smartparens-mode
;;       :map paredit-mode-map
;;       (:prefix "k"
;;         :desc "Forward slurp" "s" #'paredit-forward-slurp-sexp
;;         :desc "Backward slurp" "S" #'paredit-backward-slurp-sexp))

(map! :leader
      (:prefix ("k" "smartparens")
        :desc "Slurp forwards" "s" #'sp-forward-slurp-sexp
        :desc "Slurp backwards" "S" #'sp-backward-slurp-sexp
        :desc "Barf forwards" "d" #'sp-forward-barf-sexp
        :desc "Barf backwards" "D" #'sp-backward-barf-sexp))

(global-set-key (kbd "C-S-C") #'copy-to-clipboard)
(global-set-key (kbd "C-S-V") #'paste-from-clipboard)


;; (semi) HARD MODE
;; (define-minor-mode my-override-mode
;;   "Overrides all major and minor mode keys" t)

;; (defvar my-override-map (make-sparse-keymap "my-override-map")
;;   "Override all major and minor mode keys")

;; (add-to-list 'emulation-mode-map-alists
;;   `((my-override-mode . ,my-override-map)))

;; (define-key my-override-map (kbd "<left>")
;;   (lambda ()
;;     (interactive)
;;     (message "Use Vim keys: h for Left")))

;; (define-key my-override-map (kbd "<right>")
;;   (lambda ()
;;     (interactive)
;;     (message "Use Vim keys: l for Right")))

;; (define-key my-override-map (kbd "<up>")
;;   (lambda ()
;;     (interactive)
;;     (message "Use Vim keys: k for Up")))

;; (define-key my-override-map (kbd "<down>")
;;   (lambda ()
;;     (interactive)
;;     (message "Use Vim keys: j for Down")))

;; (evil-make-intercept-map my-override-map)
;; HARD MODE END
