;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load in.
;; Remember to run 'doom sync' after modifying it!

(doom! :input

       :completion
       company           ; the ultimate code completion backend
       (helm +fuzzy)            ; the *other* search engine for love and life

       :ui
       ;;deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;;hydra
       indent-guides     ; highlighted indent columns
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
       ;;neotree           ; a project drawer, like NERDTree for vim
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       ;;pretty-code       ; replace bits of code with pretty symbols
       ;; tabs              ; an tab bar for Emacs
       treemacs          ; a project drawer, like neotree but cooler
       unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces
       (emoji +ascii
              +github
              +unicode)

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       snippets          ; my elves. They type so I don't have to

       :emacs
       undo
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       vc                ; version-control and Emacs, sitting in a tree

       :term
       ;;eshell            ; a consistent, cross-platform shell (WIP)

       term              ; terminals in Emacs
       ;;vterm             ; another terminals in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       spell             ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       ansible
       ;;debugger          ; FIXME stepping through code, to help you add bugs
       ;;direnv
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       lookup              ; navigate your code and its documentation
       lsp
       (magit
        +forge)             ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       ;;pdf               ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       rgb               ; creating color strings
       terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       upload            ; map local to remote projects via ssh/ftp

       :lang
 ;;      (csharp +lsp)       ; unity, .NET, and mono shenanigans
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       (go
        +lsp)                ; the hipster dialect
       (javascript
         +lsp
         +onsave )        ; all(hope(abandon(ye(who(enter(here))))))
       markdown          ; writing docs for people to ignore
       (org              ; organize your plain life in plain text
        +dragndrop       ; drag & drop files/images into org buffers
        +present)        ; using org-mode for presentations
       plantuml          ; diagrams for confusing people more
       (python
        +lsp)            ; beautiful is better than ugly
       sh                ; she sells {ba,z,fi}sh shells on the C xor
       (web
         +lsp)               ; the tubes
       (dart
         +lsp
         +flutter)

       :email
       (mu4e
        +org
        +gmail)

       :app
       (rss +org)        ; emacs as an RSS reader

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       (:if IS-MAC tty
        +osx)
       (:if IS-LINUX tty)

       :config
       ;;literate
       (default +bindings +smartparens))
