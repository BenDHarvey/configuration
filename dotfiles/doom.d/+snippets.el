;;; snippets.el Snippets -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Ben Harvey
;;
;; Author: Ben Harvey <https://github.com/BenDHarvey>
;; Maintainer: Ben Harvey <ben@harvey.onl>
;; Created: November 04, 2021
;; Modified: November 04, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/ben/snippets
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Setting up yasnippets with some extra bits and pieces
;;
;;; Code:

(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.snippets")))

;; Work in progress
;; Here are some notes about things that we need to do
;; Update the snippet directory to point to something in ~/.configuration

(provide 'snippets)
;;; snippets.el ends here
