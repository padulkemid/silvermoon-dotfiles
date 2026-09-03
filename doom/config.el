;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; SETTINGS
;; User settings
(setq user-full-name "Fadhil Muhammad"
      user-mail-address "fadhil2903@gmail.com")

;; Doom settings
(setq doom-theme 'almost-mono-black
      doom-font (font-spec :family "Comic Code Ligatures" :size 20)
      doom-variable-pitch-font (font-spec :family "Inter" :size 14)
      doom-serif-font (font-spec :family "IBM Plex Serif"))

;; Emacs settings
(setq frame-title-format "@padulemacs")
(blink-cursor-mode 1)

;; Org settings
(setq org-src-window-setup 'current-window
      org-hide-leading-stars t
      org-startup-indented t
      org-adapt-indentation nil
      org-edit-src-content-indentation 0
      org-startup-truncated t
      org-return-follows-link t
      org-hide-emphasis-markers t
      org-log-into-drawer t
      org-log-state-notes-insert-after-drawers t
      org-log-done 'time
      org-directory "~/Work/personal-journal/"
      org-agenda-files '("~/Work/personal-journal/work.org"
                         "~/Work/personal-journal/habits.org"
                         "~/Work/personal-journal/meetings.org")
      org-babel-load-languages '((emacs-lisp . t)))

(after! org
  (require 'org-habit)
  (set-font-ligatures! 'org-mode
    "!=" "--" "->" "=>" "=>" "::" "->" "<-" "<->" "=>" "<=>")
  (setq org-todo-keyword-faces
        '(("TODO" . "red")
          ("ONGOING" . "magenta")
          ("REVIEW" . "orange")
          ("DONE" . "spring green")
          ("CANCELLED" . "dark olive green")
          ("RUNNING" . "cyan")
          ("FINISHED" . "slate blue")
          ("SETUP" . "aquamarine")
          ("OFF" . "tomato")
          ("NEXT" . "deep sky blue"))
        org-tags-column 65
        org-attach-dir-relative t)
  (setq org-habit-show-habits-only-for-today nil)
  (setq org-capture-templates
        '(
          ("w" "Work: Oxygen"
           entry (file+headline "~/Work/personal-journal/work.org" "Oxygen")
           "** TODO [#%^{Priority|A|B|C}] =[%^{Ticket}]= %^{Title} \nSCHEDULED: %^T\nLINK: [[%^{URL}][%\\2]]\n%?"
           :empty-lines 1)
          ("s" "Work: Production Support"
           entry (file+headline "~/Work/personal-journal/work.org" "Production Support")
           "** ONGOING =[%^{Ticket}]= %^{Title}\nLINK: [[%^{URL}][%\\1]]\n%?"
           :empty-lines 1)
          ("b" "Work: Side Quest"
           entry (file+headline "~/Work/personal-journal/work.org" "Side Quest")
           "** TODO [#%^{Priority|A|B|C}] =[%^{Ticket}]= %^{Title} \nSCHEDULED: %^T\n%?"
           :empty-lines 1)
          ("m" "Meetings"
           entry (file "~/Work/personal-journal/meetings.org")
           "* SETUP [#%^{Priority|A|B|C}] %^{Title} \nSCHEDULED: %^T\n%?"
           :empty-lines-before 1))))

(add-hook! 'org-mode-hook
  (setq-local fill-column 40)
  (turn-on-auto-fill)
  (visual-line-mode -1)
  (display-line-numbers-mode -1))

(defun padul/org-roam-rg-search ()
  "Search org-roam directory using consult-ripgrep with live preview."
  (interactive)
  (consult-ripgrep org-roam-directory ""))

;; Org Roam settings
(setq org-roam-directory (file-truename "~/Work/personal-journal/roam/"))
(setq org-roam-dailies-capture-templates
      '(
        ("d" "default" entry "* %?"
         :if-new (file+head "%<%Y/%m/%d>.org" "#+title: %^{Title}\n#+date: <%<%Y-%m-%d %a %H:%M>>\n#+filetags::coding:")
         :unnarrowed t
         :empty-lines 1)
        ("t" "tumbuh" entry "* %?"
         :if-new (file+head "tumbuh-logs/%<%Y/%m/%d>.org" "#+title: %^{Title}\n#+date: <%<%Y-%m-%d %a %H:%M>>\n#+filetags::tumbuh:")
         :unnarrowed t
         :empty-lines 1)))


(after! org-roam
  (map! :map org-roam-mode-map
        :leader
        :prefix "n r"
        :desc "Sync database" "S" #'org-roam-db-sync
        :desc "Search org-roam notes" "s" #'padul/org-roam-rg-search))

;; Eglot settings
(after! eglot
  (setq eglot-code-action-indications '(left-fringe)))

;;; APPS
;; Magit settings
(setq magit-git-executable "/opt/homebrew/bin/git")

;; use xref other than better-jumper (because we're not using evil)
;; I believe it will be remove when 'doom/compat later has moved on
(after! better-jumper
  (map! [remap xref-go-back]          #'xref-go-back
        [remap xref-pop-marker-stack] #'xref-pop-marker-stack
        [remap xref-go-forward]       #'xref-go-forward))

;;; LSP
;; mason settings
(use-package! mason
  :config
  (mason-setup))

;;; COLORS
(custom-set-faces!
  ;; modeline and fringes/margins
  '(fringe :background "black")
  '(line-number :background "black" :foreground "dark gray")
  '(line-number-current-line :background "black" :foreground "white" :weight bold)
  '(mode-line-active :background "black" :foreground "white" :overline "white" :box nil)
  '(mode-line-inactive :background "black" :foreground "dark gray" :overline "gray20" :box nil)

  ;; corfu + doom-homage-black isn't good that is why I added this
  '(corfu-default :background "black" :foreground "white")
  '(corfu-current :background "white" :foreground "black"))

;;; MODELINE
(setq display-time-interval 60)
(setq display-time-format "%H:%M")
(setq display-time-default-load-average nil)
(display-time-mode 1)

(setq padul/mode-line-active '(" "
                               display-time-string
                               (:propertize
                                (""
                                 mode-line-mule-info
                                 mode-line-client
                                 mode-line-modified
                                 mode-line-remote
                                 mode-line-window-dedicated)
                                display (min-width (6.0)))
                               " "
                               mode-line-buffer-identification
                               (vc-mode vc-mode)
                               mode-line-process))

(setq padul/mode-line-inactive
      '(" " mode-line-buffer-identification))

(setq-default mode-line-format
              '((:eval (if (mode-line-window-selected-p)
                           padul/mode-line-active
                         padul/mode-line-inactive))))
