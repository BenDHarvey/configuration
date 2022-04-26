;;; +dev.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Ben Harvey
;;
;; Author: Ben Harvey <https://github.com/ben>
;; Maintainer: Ben Harvey <ben@harvey.onl>
;; Created: September 24, 2021
;; Modified: September 24, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/ben/+dev
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

;; web, js, css
(setq css-indent-offset 2
      js2-basic-offset 2
      js-switch-indent-offset 2
      js-indent-level 2
      typescript-indent-level 2
      js2-mode-show-parse-errors nil
      js2-mode-show-strict-warnings nil
      web-mode-attr-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-markup-indent-offset 2
      web-mode-enable-current-element-highlight t
      web-mode-enable-current-column-highlight t)

(after! typescript-mode
  (add-hook 'typescript-mode-hook #'flycheck-mode)
  (setq typescript-indent-level 2))

;; Borrowed a lot from here https://www.cheng92.com/emacs/doom-emacs-with-org/#headline-110
;; Make sure that tsx gets picked up by the correct mode
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.js\\(x\\)?\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[a-z]+rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode))
(add-to-list 'auto-mode-alist '("[Mm]akefile" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("\\.mak$" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("\\.make$" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("[._]bash.*" . shell-script-mode))


;; SETUP PRETTIER
;; The has been copied from here: https://www.cheng92.com/emacs/doom-emacs-with-org/
;; Try and find / use a prettierrc file if it exists
(defun +dev-maybe-use-prettier ()
  "Enable prettier-js-mode if an rc file is located."
  (if (locate-dominating-file default-directory ".prettierrc")
      (prettier-js-mode +1)))
(add-hook 'typescript-mode-hook '+dev-maybe-use-prettier)
(add-hook 'js2-mode-hook '+dev-maybe-use-prettier)
(add-hook 'web-mode-hook '+dev-maybe-use-prettier)
(add-hook 'rjsx-mode-hook '+dev-maybe-use-prettier)

;; Try and find / use a prettierjs file if it exists
;;(defun maybe-use-prettierjs ()
;;  "Enable prettier-js-mode if an rc file is located."
;;  (if (locate-dominating-file default-directory "prettierrc.js")
;;      (prettier-js-mode +1)))
;;(add-hook 'typescript-mode-hook 'maybe-use-prettierjs)
;;(add-hook 'js2-mode-hook 'maybe-use-prettierjs)
;;(add-hook 'web-mode-hook 'maybe-use-prettierjs)
;;(add-hook 'rjsx-mode-hook 'maybe-use-prettierjs)
;; END PRETTIER SETUP

(set-formatter! 'black "black -q -S -")

(provide '+dev)
;;;
