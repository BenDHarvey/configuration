;;; +org.el --- additional org mode configuration -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Ben Harvey
;;
;; Author: Ben Harvey <https://github.com/BenDHarvey>
;; Maintainer: Ben Harvey <ben@harvey.onl>
;; Created: October 22, 2021
;; Modified: October 22, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/ben/+org
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  additional org mode configuration
;;
;;; Code:

(provide '+org)
;;; +org.el ends here

;;; $DOOMDIR/+org.el -*- lexical-binding: t; -*-

;; Allow for org-mode to know about plantuml
(setq org-plantuml-jar-path (expand-file-name "/usr/local/bin/plantuml.jar"))

(setq org-refile-targets '((org-agenda-files :maxlevel . 5)))
