;;; config.el --- Basic additional config -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Ben Harvey
;;
;; Author: Ben Harvey <https://github.com/BenDHarvey>
;; Maintainer: Ben Harvey <ben@harvey.onl>
;; Created: October 22, 2021
;; Modified: October 22, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/ben/config
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Basic additional config
;;
;;; Code:
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Ben Harvey"
      user-mail-address "ben@harvey.onl"
      doom-font (font-spec :family "monospace" :size 14)
      doom-theme 'doom-gruvbox

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
;;(load! "+email")   ;; Load email configuration
(load! "+dev")     ;; Load development related configuration
(load! "+snippets")     ;; Load email configuration
;;(load! "+slack")    ;; Load email configuration

(provide 'config)
;;; config.el ends here
