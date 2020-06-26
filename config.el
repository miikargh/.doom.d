;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Miika Moilanen"
      user-mail-address "mamoilanen@gmail.com")

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
 python-shell-interpreter "/home/miikargh/miniconda3/bin/python" ;; Set before company mode
 python-environment-directory "/home/miikargh/miniconda3/envs"
 )
(setenv "WORKON_HOME" "/home/miikargh/miniconda3/envs")

(def-package! lsp-python-ms
  :after (pyvenv)
  :config
  (add-hook 'pyvenv-post-activate-hooks 'lsp)
  )

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
(def-package! flycheck-clj-kondo
  :after clojure-mode)
(add-hook! clojure-mode-hook 'aggressive-indent-mode)
(add-hook! clojure-mode-hook 'paredit-mode)
(add-hook! clojure-mode-hook (lambda () (add-hook 'before-save-hook '+format/buffer)))

;; ORG
(add-hook 'org-mode-hook #'+word-wrap-mode)

(setq
 projectile-project-search-path '("~/projects" "~/work" "~/learning" "~/kaggles")
 )

;; Company
(def-package! company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
        company-show-numbers t
        company-tooltip-limit 10
        company-tooltip-align-annotations t
        company-tooltip-flip-when-above t)
  (global-company-mode t)
  )

(def-package! company-lsp
  :after (company)
  :config
  (setq company-lsp-enable-snippet nil)
  (add-to-list 'company-backends 'company-lsp)
  )

(setq company-lsp-enable-snippet nil
      lsp-enable-snippet nil)

;; Docker
;; (add-to-list '+format-on-save-enabled-modes 'dockerfile-mode)

;; Misc
(def-package! nyan-mode
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
