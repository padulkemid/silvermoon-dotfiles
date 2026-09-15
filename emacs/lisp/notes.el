;;; notes.el --- Org notes -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; This is the holy grail of my taking notes setup. It will combine
;; the technique of Zettelkasten for daily journal and mental health check.
;; `org-agenda' integration with `org-roam' and then tracking the habits.
;;
;; Global keys from (org) Activation — not bound by Emacs itself.
;; `:bind' keeps Org deferred until first press.
;; Named `notes' so we never shadow the built-in `org' library on load-path.
;; Options + roam ported from DOOM `config.el'.

;;; Code:

(defun padul/org-mode-setup ()
  "Narrow fill + no visual-line (same as DOOM org-mode-hook)."
  (setq-local fill-column 40)
  (setq-local display-line-numbers nil)
  (auto-fill-mode 1)
  (visual-line-mode -1))

(use-package org
  :ensure nil				; Built-in.
  :bind (;; Used: daily capture + agenda.
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  :hook (org-mode . padul/org-mode-setup)
  :init
  ;; Need these before first agenda/capture press.
  (setopt
   ;; Used: where the journal lives + what agenda scans.
   org-directory "~/Work/personal-journal/"
   org-agenda-files '("~/Work/personal-journal/work.org"
		      "~/Work/personal-journal/habits.org"
		      "~/Work/personal-journal/meetings.org")
   ;; Used: src edit in same window (babel/elisp+clj blocks).
   org-src-window-setup 'current-window
   org-babel-load-languages '((emacs-lisp . t)
			      (clojure . t))
   ;; Used: how Org buffers look while I write.
   org-hide-leading-stars t
   org-startup-indented t
   org-adapt-indentation nil
   org-startup-truncated t
   org-return-follows-link t
   org-hide-emphasis-markers t
   ;; Used: DONE stamps + state notes go in a drawer, not littering the tree.
   org-log-into-drawer t
   org-log-state-notes-insert-after-drawers t
   org-log-done 'time)
  :config
  (require 'org-habit)			; Used: habits.org + consistency graph.
  ;; Keywords live in the journal files (`#+TODO:'); faces only paint them.
  (setopt
   ;; Used: colors for the keywords I actually type in the journal.
   org-todo-keyword-faces
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
   org-tags-column -40			; Used: tags hug the right edge.
   org-attach-dir-relative t		; Used: attachments relative to the note.
   org-habit-show-habits-only-for-today nil ; Used: show habit graph beyond today.
   ;; Used: the capture menu behind `C-c c'.
   org-capture-templates
   '(("w" "Work: Oxygen"
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

;; Org-roam — MELPA, not builtin. Used: Zettelkasten under personal-journal/roam/.
;; Yesterday/tomorrow = dailies goto (not `org-roam-node-find').
;; DOOM consult-ripgrep search skipped until Consult lands; db autosyncs.
(use-package org-roam
  :bind (("C-c n t" . org-roam-dailies-capture-today)
	 ("C-c n y" . org-roam-dailies-goto-yesterday)
	 ("C-c n m" . org-roam-dailies-goto-tomorrow))
  :init
  (setopt org-roam-directory (file-truename "~/Work/personal-journal/roam/")
	  ;; Used: daily coding log + tumbuh mental-health log.
	  org-roam-dailies-capture-templates
	  '(("d" "default" entry "* %?"
	     :if-new (file+head "%<%Y/%m/%d>.org"
				"#+title: %^{Title}\n#+date: <%<%Y-%m-%d %a %H:%M>>\n#+filetags::coding:")
	     :unnarrowed t
	     :empty-lines 1)
	    ("t" "tumbuh" entry "* %?"
	     :if-new (file+head "tumbuh-logs/%<%Y/%m/%d>.org"
				"#+title: %^{Title}\n#+date: <%<%Y-%m-%d %a %H:%M>>\n#+filetags::tumbuh:")
	     :unnarrowed t
	     :empty-lines 1)))
  :config
  (org-roam-db-autosync-mode))

(provide 'notes)
;;; notes.el ends here
