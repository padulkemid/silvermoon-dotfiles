;;; ui.el --- UI -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; Look and feel — theme, faces, dividers, line numbers, paren flash. Stuff I
;; stare at all day; keep options.el for behavior and this for chrome.

;;; Code:

;; `which-key': shows a popup of available keybindings when typing a long key
;; sequence (e.g: C-x ...)
(use-package which-key
  :ensure nil
  :config
  (which-key-mode))

;; Group ibuffer by project.el roots.
(use-package ibuffer-project
  :hook (ibuffer . padul/ibuffer-project-setup))

(defun padul/ibuffer-project-setup ()
  "Regenerate ibuffer filter groups from `project.el'."
  (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
  (unless (eq ibuffer-sorting-mode 'project-file-relative)
    (ibuffer-do-sort-by-project-file-relative)))

;; Fringe VC hunks. Deferred until first prog/text buffer (org/md ⊆ text-mode).
;; Same :hook style as smartparens — use-package infers diff-hl-mode.
(use-package diff-hl
  :hook (prog-mode text-mode
		   (magit-post-refresh . diff-hl-magit-post-refresh)))

;; Blinking cursor.
(blink-cursor-mode 1)

;; Side-by-side dividers only (bottom dividers draw a hairline above the minibuffer).
;; Width 1 is a thin divider (stock default is a fat 6px block; DOOM uses 1).
(setopt window-divider-default-places 'right-only
	window-divider-default-right-width 1
	window-divider-default-bottom-width 1)
(window-divider-mode 1)

;; Display line numbers in programming mode only.
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setopt display-line-numbers-width 3
	display-line-numbers-type 'relative)

;; Visually highlights entire line in the active point (cursor).
(setopt global-hl-line-sticky-flag 'window)
(global-hl-line-mode)

;; Show matching delimiters.
(setopt show-paren-delay 0
	show-paren-style 'expression   ; default is 'parenthesis and just does delimiters.
	show-paren-context-when-offscreen 'overlay)
(show-paren-mode 1)

;; Show tab bar.
(setopt tab-bar-show 1)

;; Set theme.
(use-package almost-mono-themes         ; Monochromatic black and white, fuck syntax highlighting.
  :config
  (load-theme 'almost-mono-black t))

(provide 'ui)
;;; ui.el ends here
