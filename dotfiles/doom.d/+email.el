(add-to-list 'load-path "~/.nix-profile/share/emacs/site-lisp/mu4e/")

(use-package mu4e
  :defer 20 ; Wait until 20 seconds after startup
  :config

  ;; Load org-mode integration
  (require 'org-mu4e)

  ;; Refresh mail using isync every 10 minutes
  ;;  (setq mu4e-update-interval (* 10 60))
  ;;  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")

  ;; Make sure that moving a message (like to Trash) causes the
  ;; message to get a new file name.  This helps to avoid the
  ;; dreaded "UID is N beyond highest assigned" error.
  ;; See this link for more info: https://stackoverflow.com/a/43461973
  (setq mu4e-change-filenames-when-moving t)

  ;; Set up contexts for email accounts
  (setq mu4e-contexts
        `(,(make-mu4e-context
            :name "Fastmail"
            :match-func (lambda (msg) (when msg
                                        (string-prefix-p "/Fastmail" (mu4e-message-field msg :maildir))))
            :vars '(
                    (user-full-name . "Ben Harvey")
                    (user-mail-address . "ben@harvey.onl")
                    (mu4e-sent-folder . "/ben@harvey.onl/Sent")
                    (mu4e-trash-folder . "/ben@harvey.onl/Trash")
                    (mu4e-drafts-folder . "/ben@harvey.onl/Drafts")
                    (mu4e-refile-folder . "/ben@harvey.onl/Archive")
                    (mu4e-sent-messages-behavior . sent)
                    ))
          ;;          ,(make-mu4e-context
          ;;            :name "Personal"
          ;;            :match-func (lambda (msg) (when msg
          ;;                                        (string-prefix-p "/Personal" (mu4e-message-field msg :maildir))))
          ;;            :vars '(
          ;;                    (mu4e-sent-folder . "/Personal/Sent")
          ;;                    (mu4e-trash-folder . "/Personal/Deleted")
          ;;                    (mu4e-refile-folder . "/Personal/Archive")
          ;;                    ))
          ))
  (setq mu4e-context-policy 'pick-first)

  ;; Prevent mu4e from permanently deleting trashed items
  ;; This snippet was taken from the following article:
  ;; http://cachestocaches.com/2017/3/complete-guide-email-emacs-using-mu-and-/
  (defun remove-nth-element (nth list)
    (if (zerop nth) (cdr list)
      (let ((last (nthcdr (1- nth) list)))
        (setcdr last (cddr last))
        list)))
  (setq mu4e-marks (remove-nth-element 5 mu4e-marks))
  (add-to-list 'mu4e-marks
               '(trash
                 :char ("d" . "▼")
                 :prompt "dtrash"
                 :dyn-target (lambda (target msg) (mu4e-get-trash-folder msg))
                 :action (lambda (docid msg target)
                           (mu4e~proc-move docid
                                           (mu4e~mark-check-target target) "-N"))))

  ;; Display options
  (setq mu4e-view-show-images t)
  (setq mu4e-view-show-addresses 't)

  ;; Composing mail
  (setq mu4e-compose-dont-reply-to-self t)

  ;; Use mu4e for sending e-mail
  (setq mail-user-agent 'mu4e-user-agent
        message-send-mail-function 'smtpmail-send-it
        smtpmail-smtp-server "smtp.fastmail.com"
        smtpmail-smtp-service 465
        smtpmail-stream-type  'ssl)

  ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
  ;; additional non-Gmail addresses and want assign them different
  ;; behavior.)

  ;; setup some handy shortcuts
  ;; you can quickly switch to your Inbox -- press ``ji''
  ;; then, when you want archive some messages, move them to
  ;; the 'All Mail' folder by pressing ``ma''.
  ;;  (setq mu4e-maildir-shortcuts
  ;;        '(("/Fastmail/INBOX"       . ?i)
  ;;          ("/Fastmail/Lists/*"     . ?l)
  ;;          ("/Fastmail/Sent Mail"   . ?s)
  ;;          ("/Fastmail/Trash"       . ?t)))

  ;;  (add-to-list 'mu4e-bookmarks
  ;;               (make-mu4e-bookmark
  ;;                :name "All Inboxes"
  ;;                :query "maildir:/Fastmail/INBOX OR maildir:/Personal/Inbox"
  ;;                :key ?i))

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)

  ;; Start mu4e in the background so that it syncs mail periodically
  (mu4e t))
