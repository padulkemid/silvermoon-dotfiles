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
                         "~/Work/personal-journal/home.org")
      org-babel-load-languages '((emacs-lisp . t)
                                 (kotlin .t)
                                 (typescript . t)
                                 (js . t)))

;; TODO: (setq org-capture-templates)
(after! org
  (setq org-todo-keyword-faces
        '(("TODO" . "red")
          ("IN PROGRESS" . "magenta")
          ("DONE" . "spring green")
          ("CANCELLED" . "dark olive green"))
        org-tags-column 65
        org-attach-dir-relative t))

(after! org-latex
  (setq org-latex-pdf-process (list "latexmk -f xelatex %f")))

(add-hook! 'org-mode-hook
  (setq-local fill-column 65
              visual-line-mode nil
              auto-fill-mode t))

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
