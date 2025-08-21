;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; SETTINGS
;; User settings
(setq user-full-name "Fadhil Muhammad"
      user-mail-address "fadhil2903@gmail.com")

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
(setq org-hide-leading-stars t
      org-startup-indented t
      org-adapt-indentation nil
      org-edit-src-content-indentation 0
      org-startup-truncated t
      org-return-follows-link t
      org-hide-emphasis-markers t
      org-latex-compiler "lualatex"
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
          ("CANCELLED" . "dark olive green"))))


;; Org Roam settings
(setq org-roam-directory (file-truename "~/Work/personal-journal/roam/"))

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %?"
         :if-new (file+head "%<%Y/%m/%d>.org" "#+title: %^{Title}\n#+date: <%<%Y-%m-%d %a %H:%M>>\n#+filetags::coding:")
         :unnarrowed t
         :empty-lines-before 1
         )))

;; Consult settings
(after! flycheck
  (map! :leader
        :prefix "s"
        "g" #'consult-flycheck))


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
