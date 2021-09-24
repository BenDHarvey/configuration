;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Ben Harvey"
      user-mail-address "ben@harvey.onl"
      doom-font (font-spec :family "monospace" :size 14)
      doom-theme 'doom-acario-dark

      org-directory "~/Documents/org"
      display-line-numbers-type 'relative
      auth-sources '("~/.authinfo.gpg")

      evil-shift-width 2
      tab-width 2

      ;; Using alt key does not working mac os. Hack to get the right alt key working
      mac-option-modifier nil
      mac-command-modifier 'meta)

(setq-default evil-shift-width 2 ;; I normally use 2wide for my projects.
              tab-width 2)

;; Module imports
(load! "+org")     ;; Org mode stuff like todos and rebindings
(load! "+email")   ;; Load email configuration
(load! "+dev")     ;; Load email configuration
;; (load! "+slack")    ;; Load email configuration
