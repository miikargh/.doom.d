;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Miika Moilanen"
      user-mail-address "miika.moilanen@utopiaanalytics.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;

(load! "+bindings")


;; python
(setq
 python-shell-interpreter "/home/miika/miniconda3/bin/python" ;; Set before company mode
 python-environment-directory "/home/miika/miniconda3/envs"
 lsp-pyls-plugins-pylint-enabled nil
 lsp-pyls-plugins-flake8-config "/home/miika/setup.cfg"
 lsp-pyls-plugins-flake8-enabled t
 lsp-pyls-plugins-pyflakes-enabled nil
 lsp-pyls-plugins-pylint-enabled nil
 ;; lsp-pyls-plugins-pylint-args ["--rcfile" "/home/miika/setup.cfg"]
 lsp-pyls-plugins-autopep8-enabled nil
 lsp-pyls-plugins-pycodestyle-enabled nil
 lsp-pyls-plugins-yapf-enabled nil
 )

(set-formatter! 'black "black -q --config /home/miika/.config/black.toml -")

(setenv "WORKON_HOME" "/home/miika/miniconda3/envs")

(use-package! lsp-python-ms
  :after (pyvenv)
  :config
  (add-hook 'pyvenv-post-activate-hooks 'lsp)
  )


;; (setq gc-cons-threshold 100000000)
;; javascript
(add-hook 'js-mode-hook 'prettier-js-mode)
(add-hook 'js-mode-hook  'emmet-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'emmet-mode)

(setq
 prettier-js-args '(
                    "--trailing-comma" "es5"
                    ;; "--bracket-spacing" "true"
                    "--tab-width" "4"
                    ;; "--use-tabs" "true"
                    ;; "--print-width" "120"
                    "--single-quote" "true"
                    "--jsx-single-quote" "true"
                    "--arrow-parens" "avoid"
                    )

 typescript-indent-level 4
 javascript-indent-level 4
 )

;; Clojure
(use-package! flycheck-clj-kondo
  :after clojure-mode)
(add-hook! clojure-mode-hook 'aggressive-indent-mode)
(add-hook! clojure-mode-hook 'paredit-mode)
(add-hook! clojure-mode-hook (lambda () (add-hook 'before-save-hook '+format/buffer)))

;; ORG
(add-hook 'org-mode-hook #'+word-wrap-mode)
;; (add-to-list 'load-path "<path-where-you-cloned>/emacs-reveal")
;; (setq emacs-reveal-managed-install-p nil)
;; (use-package! emacs-reveal)

(setq
 projectile-project-search-path '("~/projects" "~/code" "~/mounts" "~/presentations", "~/notes"))


(use-package! protobuf-mode)

;; Company
(use-package! company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
        company-show-numbers t
        company-tooltip-limit 10
        company-tooltip-align-annotations t
        company-tooltip-flip-when-above t)
  (global-company-mode t)
  )

(use-package! company-lsp
  :after (company)
  :config
  (setq company-lsp-enable-snippet nil)
  (add-to-list 'company-backends 'company-lsp)
  )

(setq company-lsp-enable-snippet nil
      lsp-enable-snippet nil)

;; Docker
;; (add-to-list '+format-on-save-enabled-modes 'dockerfile-mode)

;; Add TOC to markdown files on save.
(defun markdown-update-toc ()
  "Update TOC in a markdown file."
  (when (eq major-mode 'markdown-mode)
    (message "Creating TOC...")
    (shell-command-to-string (format "markdown-toc -i %s" buffer-file-name))))

(add-hook! markdown-mode-hook (lambda () (add-hook 'before-save-hook #'markdown-update-toc)))

;; Misc
(use-package! nyan-mode
  :config
  (nyan-mode)
  (nyan-start-animation))

(display-time) ;; Show time on modeline
(display-battery-mode)
(global-emojify-mode)

;; UTF-8 as default encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Fix for the dead-grave but on Pop!_OS
(global-set-key [S-dead-grave] "`")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((eval set-formatter!
           (quote black)
           "black -q --config /home/miika/projects/image-classifier/black.toml -")
     (eval setq black-config-file "/home/miika/projects/image-classifier/black.toml")
     (black-config-file "/home/miika/projects/image-classifier/black.toml")
     (eval conda-env-activate "gekko4")
     (eval conda-env-activate "image-classifier")
     (eval conda-env-activate "image-fetcher")
     (eval conda-env-activate "image-moderator-tf")
     (eval conda-env-activate "image-moderator-tf-p3.7")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
