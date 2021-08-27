;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Ben Harvey"
      user-mail-address "ben@harvey.onl")

(setq doom-font (font-spec :family "monospace" :size 14))

(setq doom-theme 'doom-acario-dark)

(setq org-directory "~/Documents/org")

(setq display-line-numbers-type 'relative)

(setq-default evil-shift-width 2 ;; I normally use 2wide for my projects.
              tab-width 2)

(after! typescript-mode
  (add-hook 'typescript-mode-hook #'flycheck-mode)
  (setq typescript-indent-level 2))

;; Make sure that tsx gets picked up by the correct mode
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(setq js-indent-level 2
      js2-basic-offset 2)
(setq typescript-indent-level 2)
(setq css-indent-offset 2)

;; Using alt key does not working mac os. Hack to get the right alt key working
(setq mac-option-modifier nil
      mac-command-modifier 'meta)

;; Module imports
(load! "+org")     ;; Org mode stuff like todos and rebindings
(load! "+email")   ;; Load email configuration
