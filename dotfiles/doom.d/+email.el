 ;;;;; ../.personal_config/assets/doom.d/+email.el -*- lexical-binding: t; -*-
 ;;
 ;;(use-package mu4e
 ;;  :ensure nil
 ;;  :config
 ;;
 ;;  ;; This is set to 't' to avoid mail syncing issues when using mbsync
 ;;  (setq mu4e-change-filenames-when-moving t)
 ;;
 ;;  ;; Refresh mail using isync every 10 minutes
 ;;  (setq mu4e-update-interval (* 10 60))
 ;;  (setq mu4e-get-mail-command "mbsync -a")
 ;;  (setq mu4e-maildir "~/.mail")
 ;;
 ;;  (setq mu4e-contexts
 ;;        (list
 ;;         ;; Work account
 ;;         (make-mu4e-context
 ;;          :name "Personal"
 ;;          :match-func
 ;;            (lambda (msg)
 ;;              (when msg
 ;;                (string-prefix-p "/ben@harvy.ninja" (mu4e-message-field msg :maildir))))
 ;;          :vars '((user-mail-address . "ben@harvy.ninja")
 ;;                  (user-full-name    . "Ben Harvey")
 ;;                  (mu4e-compose-signature . "---\n Ben Harvey")
 ;;                  (mu4e-drafts-folder  . "/ben@harvy.ninja/Drafts")
 ;;                  (mu4e-sent-folder  . "/ben@harvy.ninja/Sent")
 ;;                  (mu4e-refile-folder  . "/ben@harvy.ninja/All Mail")
 ;;                  (mu4e-trash-folder  . "/ben@harvy.ninja/Trash")))))
 ;;
 ;;;;  (setq mu4e-maildir-shortcuts
 ;;;;        '(("/Gmail/Inbox"             . ?i)
 ;;;;          ("/Gmail/[Gmail]/Sent Mail" . ?s)
 ;;;;          ("/Gmail/[Gmail]/Trash"     . ?t)
 ;;;;          ("/Gmail/[Gmail]/Drafts"    . ?d)
 ;;;;          ("/Gmail/[Gmail]/All Mail"  . ?a)))
 ;;  )
