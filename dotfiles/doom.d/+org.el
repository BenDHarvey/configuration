;;; $DOOMDIR/+org.el -*- lexical-binding: t; -*-

;; Allow for org-mode to know about plantuml
(setq org-plantuml-jar-path (expand-file-name "/usr/local/bin/plantuml.jar"))

(setq org-refile-targets '((org-agenda-files :maxlevel . 5)))
;(setq org-agenda-files (list "~/org/projects/work/main.org"
;                             "~/org/projects/personal/main.org"
;                             "~/org/notes/main.org"
;                             "~/org/notes/personal/index.org"
;                             "~/org/notes/work/index.org"))

;(after! org
;;  (setq +org-capture-journal-file
;;        (expand-file-name "my_journal.org"  org-directory)
;;  )
;
;  (add-to-list 'org-capture-templates
;               '("k" "Journal" entry (file+olp+datetree +org-capture-journal-file) "* %T %?\n%i\n%a" :prepend t)
;                ;("j" "jira task" entry (file+headline "~/org/notes/main.org" "Jira Tasks") "** TODO %^{Task Description}" :prepend t)
;                ("m" "Meeting" entry (file+headline "~/org/MeetingNotes/main.org" "Meeting Notes") ,my/org-meeting-template)
;  )
;)

;; I picked up this neat trick from the Venerable Sacha Chua
(defvar my/org-meeting-template "** Meeting about %^{something}
SCHEDULED: %<%Y-%m-%d %H:%M>
*Attendees:*
- [X] Ben Harvey
- [ ] %?
*Agenda:*
-
-
*Notes:*
" "Meeting Template")

;(after! org
;  (add-to-list org-capture-templates
;      `(;; Note the backtick here, it's required so that the defvar based tempaltes will work!
;        ;;http://comments.gmane.org/gmane.emacs.orgmode/106890
;
;        ("t" "To-do" entry (file+headline "~/org/notes/main.org" "Tasks")
;         "** TODO %^{Task Description}\nCreated From: %a\n" :prepend t)
;
;        ("j" "jira task" entry (file+headline "~/org/notes/main.org" "Jira Tasks")
;         "** TODO %^{Task Description}" :prepend t)
;
;        ("m" "Meeting" entry (file+headline "~/org/MeetingNotes/main.org" "Meeting Notes")
;         ,my/org-meeting-template)
;        ))
;  )

;;; Recompute effort of a parent headline from the efforts of the children if
;;; they sum to a higher value.
;;(defun my-org-update-heading-effort-from-children (pt)
;;  "Compute the sum of efforts for each child of the heading at point PT. If
;;the sum is greater than the current effort for this heading, offer to update
;;it. This function is called recursively on each child, so the entire tree's
;;efforts may be updated by this function."
;;  (save-excursion
;;    (save-restriction
;;      (goto-char pt)
;;      (org-back-to-heading)
;;      (org-narrow-to-subtree)
;;      (outline-show-all)
;;      (let*
;;          ((current-effort
;;            (org-duration-to-minutes
;;             (or (org-entry-get (point) org-effort-property) 0)))
;;           (children-effort 0))
;;        (while (outline-next-heading)
;;          (let ((x (my-org-update-heading-effort-from-children (point))))
;;            (setq children-effort (+ children-effort (nth 0 x)))
;;            (goto-char (nth 1 x))))
;;        (goto-char pt)
;;        (let ((children-effort-duration
;;               (org-duration-from-minutes children-effort)))
;;          (when (and (< current-effort children-effort)
;;                 (y-or-n-p-with-timeout
;;                  (format "Update effort to children's sum (%s)?"
;;                          children-effort-duration)
;;                  60 nil))
;;            (org-entry-put (point) org-effort-property
;;                           children-effort-duration)
;;            (setq current-effort children-effort)))
;;        (list current-effort (point-max))))))
;;(defun my-org-effort-from-children-hook ()
;;  "Update effort of a heading from its children before clocking in."
;;  (my-org-update-heading-effort-from-children (point))
;;  nil)
;;(add-hook 'org-clock-in-prepare-hook 'my-org-effort-from-children-hook)
