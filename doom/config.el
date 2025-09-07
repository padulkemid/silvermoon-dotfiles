;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; SETTINGS
;; User settings
(setq user-full-name "Fadhil Muhammad"
      user-mail-address "fadhil2903@gmail.com"
      load-prefer-newer t)

;; Doom settings
(setq doom-theme 'modus-vivendi
      doom-font (font-spec :family "BerkeleyMono Nerd Font Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Inter" :size 14)
      doom-serif-font (font-spec :family "IBM Plex Serif"))

;; Emacs settings
(setq frame-title-format '("%b - @padulemacs")
      display-line-numbers-type nil
      display-time-format '%H:%M)


;; Org settings
(setq org-src-window-setup 'current-window
      org-preview-latex-image-directory "/tmp/ltximg/"
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
                                 (js . t)))

(after! org
  (require 'org-habit)
  (setq org-todo-keyword-faces
        '(("TODO" . "red")
          ("ONGOING" . "magenta")
          ("DONE" . "spring green")
          ("CANCELLED" . "dark olive green")
          ("RUNNING" . "cyan")
          ("FINISHED" . "slate blue")
          ("SETUP" . "aquamarine")
          ("NEXT" . "deep sky blue"))
        org-tags-column 65
        org-attach-dir-relative t)
  (setq org-habit-show-habits-only-for-today nil)
  (setq org-capture-templates
        '(
          ("w" "Work: MSG"
           entry (file+headline "~/Work/personal-journal/work.org" "MSG")
           "** TODO [#%^{Priority|A|B|C}] %^{Title} %^g \nSCHEDULED: %^T\n\n%?"
           :empty-lines-after 1)
          ("b" "Work: Other"
           entry (file+headline "~/Work/personal-journal/work.org" "Other")
           "** TODO [#%^{Priority|A|B|C}] %^{Title} %^g \nSCHEDULED: %^T\n\n%?"
           :empty-lines-after 1)
          ("m" "Meetings"
           entry (file "~/Work/personal-journal/meetings.org")
           "* SETUP [#%^{Priority|A|B|C}] %^{Title} %^g \nSCHEDULED: %^T\n\n%?"
           :empty-lines-before 1)
          ("r" "Reminders"
           entry (file+headline "~/Work/personal-journal/habits.org" "Reminders")
           "** NEXT %^{Title} %^g \nSCHEDULED: %^T\n\n%?"
           :empty-lines-after 1)
          )))


(after! org-latex
  (setq org-latex-pdf-process '("LC_ALL=en_US.UTF-8 latexmk -f -pdf -xelatex -shell-escape -interaction=nonstopmode")))

(after! ox-latex
  (let* ((article-sections '(("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
         (book-sections (append '(("\\chapter{%s}" . "\\chapter*{%s}"))
                                article-sections))
         (hanging-secnum-preamble "\\renewcommand\\sectionformat{\\llap{\\thesection\\autodot\\enskip}}
\\renewcommand\\subsectionformat{\\llap{\\thesubsection\\autodot\\enskip}}
\\renewcommand\\subsubsectionformat{\\llap{\\thesubsubsection\\autodot\\enskip}}")
         (big-chap-preamble "\\RedeclareSectionCommand[afterindent=false, beforeskip=0pt, afterskip=0pt, innerskip=0pt]{chapter}
\\setkomafont{chapter}{\\normalfont\\Huge}
\\renewcommand*{\\chapterheadstartvskip}{\\vspace*{0\\baselineskip}}
\\renewcommand*{\\chapterheadendvskip}{\\vspace*{0\\baselineskip}}
\\renewcommand*{\\chapterformat}{%
  \\fontsize{60}{30}\\selectfont\\rlap{\\hspace{6pt}\\thechapter}}
\\renewcommand*\\chapterlinesformat[3]{%
  \\parbox[b]{\\dimexpr\\textwidth-0.5em\\relax}{%
    \\raggedleft{{\\large\\scshape\\bfseries\\chapapp}\\vspace{-0.5ex}\\par\\Huge#3}}%
    \\hfill\\makebox[0pt][l]{#2}}"))
    (setcdr (assoc "article" org-latex-classes)
            `(,(concat "\\documentclass{scrartcl}" hanging-secnum-preamble)
              ,@article-sections))
    (add-to-list 'org-latex-classes
                 `("report" ,(concat "\\documentclass{scrartcl}" hanging-secnum-preamble)
                   ,@article-sections))
    (add-to-list 'org-latex-classes
                 `("book" ,(concat "\\documentclass[twoside=false]{scrbook}"
                                   big-chap-preamble hanging-secnum-preamble)
                   ,@book-sections))
    (add-to-list 'org-latex-classes
                 `("blank" "[NO-DEFAULT-PACKAGES]\n[NO-PACKAGES]\n[EXTRA]"
                   ,@article-sections))
    (add-to-list 'org-latex-classes
                 `("bmc-article" "\\documentclass[article,code,maths]{bmc}\n[NO-DEFAULT-PACKAGES]\n[NO-PACKAGES]\n[EXTRA]"
                   ,@article-sections))
    (add-to-list 'org-latex-classes
                 `("bmc" "\\documentclass[code,maths]{bmc}\n[NO-DEFAULT-PACKAGES]\n[NO-PACKAGES]\n[EXTRA]"
                   ,@book-sections))))


(add-hook! 'org-mode-hook
  (setq-local fill-column 65
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
      '(("d" "default" entry "* %?"
         :if-new (file+head "%<%Y/%m/%d>.org" "#+title: %^{Title}\n#+date: <%<%Y-%m-%d %a %H:%M>>\n#+filetags::coding:")
         :unnarrowed t
         :empty-lines-before 1
         )))

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
  '(mode-line-inactive :background "dark gray" :foreground "black" :box nil))



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
                mode-line-format-right-align
                ,padul/mode-line-right-side))

