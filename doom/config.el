;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; EVIL
;; OG keymaps
(setq evil-kill-on-visual-paste nil)
(evil-ex-define-cmd "W" "w")
(evil-ex-define-cmd "Q" "q")
(map! :nv "H" #'evil-first-non-blank
      :n "L" #'evil-end-of-line
      :v "L" #'evil-last-non-blank)

;;; SETTINGS
;; User settings
(setq user-full-name "Fadhil Muhammad"
      user-mail-address "fadhil2903@gmail.com"
      load-prefer-newer t)

(add-to-list 'default-frame-alist '(undecorated-round . t))

;; Doom settings
(setq doom-theme 'doom-homage-black
      doom-font (font-spec :family "Comic Code Ligatures" :size 20)
      doom-variable-pitch-font (font-spec :family "Inter" :size 14)
      doom-serif-font (font-spec :family "IBM Plex Serif"))

;; Emacs settings
(setq frame-title-format '("%b - @padulemacs")
      display-line-numbers-type nil
      display-time-format '%H:%M)

(blink-cursor-mode 1)

;; Plantuml settings
(setq plantuml-jar-path "~/.local/share/jars/plantuml.jar"
      plantuml-default-exec-mode 'jar
      plantuml-svg-background "white")

(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))

;; Org settings
(setq org-src-window-setup 'current-window
      org-plantuml-jar-path "~/.local/share/jars/plantuml.jar"
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
      org-babel-load-languages '((emacs-lisp . t)
                                 (kotlin .t)
                                 (typescript . t)
                                 (js . t)
                                 (dart . t)
                                 (plantuml . t)))

(after! org
  (require 'org-habit)
  (set-font-ligatures! 'org-mode
    "|||+" "<===" "===>" "===" "==" "!==" "!=" "--" "---" "->" "=>"
    ">>" "<<" "<=" ">=" "=>" "||" "&&" "::" "->" "<-" "<->" "-->"
    "<--" "<-->" "-<" ">-" ">>-" "-<<" "<<-" "<-<" ">->" "<-|" "|->"
    "-|" "|-" "||-" "<!--" "<#--" "<=" "=>" "==>" "<==" "<=>" "<==>"
    "=<<" ">>=" "=+=" "!==" "!!" "||=" "|=" "::=" ":=" ":-" ":+"
    "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++"
    "+++" "<!--" "<!---")
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
           "** TODO [#%^{Priority|A|B|C}] =[%^{Ticket}]= %^{Title} \nSCHEDULED: %^T\n%?"
           :empty-lines 1)
          ("s" "Work: Production Support"
           entry (file+headline "~/Work/personal-journal/work.org" "Production Support")
           "** ONGOING =[%^{Ticket}]= %^{Title} \n%?"
           :empty-lines 1)
          ("b" "Work: Side Quest"
           entry (file+headline "~/Work/personal-journal/work.org" "Side Quest")
           "** TODO [#%^{Priority|A|B|C}] =[%^{Ticket}]= %^{Title} \nSCHEDULED: %^T\n%?"
           :empty-lines 1)
          ("m" "Meetings"
           entry (file "~/Work/personal-journal/meetings.org")
           "* SETUP [#%^{Priority|A|B|C}] %^{Title} \nSCHEDULED: %^T\n%?"
           :empty-lines-before 1)
          ("r" "Reminders"
           entry (file+headline "~/Work/personal-journal/habits.org" "Reminders")
           "** NEXT %^{Title} %^g \nSCHEDULED: %^T\n%?"
           :empty-lines 1)
          )))


(add-hook! 'org-mode-hook
  (setq-local fill-column 40
              visual-line-mode nil))

(add-hook! 'org-mode-hook 'turn-on-auto-fill)

;; Consult settings
(after! flycheck
  (map! :leader
        :prefix "s"
        :desc "Flycheck diagnostics" "g" #'consult-flycheck))

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
         :empty-lines 1)
        ))

(after! org-roam
  (map! :map org-roam-mode-map
        :leader
        :prefix "n r"
        :desc "Sync database" "S" #'org-roam-db-sync
        :desc "Search org-roam notes" "s" #'padul/org-roam-rg-search))

;; Magit settings
(setq magit-git-executable "/opt/homebrew/bin/git")

;;; COLORS
(custom-set-faces!
  '(fringe :background "black")
  '(line-number :background "black" :foreground "dark gray")
  '(line-number-current-line :background "black" :foreground "white" :weight bold)
  '(mode-line-active :background "white" :foreground "black" :box nil)
  '(mode-line-inactive :background "dark gray" :foreground "black" :box nil)

  ;; corfu + doom-homage-black isn't good that is why I added this
  '(corfu-default :background "black" :foreground "white")
  '(corfu-current :background "white" :foreground "black"))

;;; UTILITIES
;; Disable 'cl warning
(defadvice! fixed-do-after-load-evaluation (abs-file)
  :override #'do-after-load-evaluation
  (dolist (a-l-element after-load-alist)
    (when (and (stringp (car a-l-element))
               (string-match-p (car a-l-element) abs-file))
      (mapc #'funcall (cdr a-l-element))))
  (run-hook-with-args 'after-load-functions abs-file))

;;; MODELINE
(defvar padul-check-selected-window (frame-selected-window))
(defun padul-set-selected-window (&rest _args)
  (when (not (minibuffer-window-active-p (frame-selected-window)))
    (setq padul-check-selected-window (frame-selected-window))
    (force-mode-line-update)))
(defun padul-unset-selected-window ()
  (setq padul-check-selected-window nil)
  (force-mode-line-update))
(defun padul-line-selected-window-active-p ()
  (eq padul-check-selected-window (selected-window)))

(add-hook! 'window-configuration-change-hook #'padul-set-selected-window)
(add-hook! 'window-selection-change-functions #'padul-set-selected-window)

(setq padul/mode-line-right-side '(:eval (when (mode-line-window-selected-p)
                                           (list
                                            " "
                                            mode-line-misc-info
                                            mode-line-position
                                            "C%c "))))

(setq padul/mode-line-left-side '(" "
                                  (:eval (format-time-string "%H:%M"))
                                  "  "
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

(setq-default mode-line-format
              `(
                ,@padul/mode-line-left-side
                mode-line-format-right-align))

;; ,padul/mode-line-right-side))
