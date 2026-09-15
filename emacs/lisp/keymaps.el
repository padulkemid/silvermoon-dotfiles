;;; keymaps.el --- Keymaps -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; Custom keymaps derived from other configs (rexim, jamescherti, joshuablais,
;; agzam) and DOOM — plus small commands that only exist to be bound.

;;; Code:

;; Move through windows with C-<arrow>.
(windmove-default-keybindings 'control)

;; Cmd+c / Cmd+v still use the macOS clipboard (kill-ring stays Emacs-only).
(keymap-global-set "s-c" #'clipboard-kill-ring-save)
(keymap-global-set "s-v" #'clipboard-yank)

;; Restore your windows.
(keymap-global-set "C-x w w" #'winner-undo)
(keymap-global-set "C-x w W" #'winner-redo)

;; Open recent files
(keymap-global-set "M-s M-f" #'recentf-open)

;; Format whole buffer (instead of C-x h M-q). Save still runs Apheleia
;; globally; this key is manual: cljfmt in Clojure, else indent-region.
(defun indent-buffer ()
  "Format Clojure via Apheleia; otherwise run `indent-region' on the buffer."
  (interactive)
  (if (derived-mode-p 'clojure-mode)	; includes clojure-ts-* on Emacs 30+
      (progn
	(require 'apheleia)
	(if-let* ((fmt (apheleia--get-formatters)))
	    (apheleia-format-buffer fmt)
	  (indent-region (point-min) (point-max))))
    (indent-region (point-min) (point-max))))

(keymap-global-set "C-x M-q" #'indent-buffer)

;; `ibuffer' (built-in) instead of list-buffers; selects the list window.
(keymap-global-set "C-x C-b" #'ibuffer)

;; TAB acts more like in shell.
(keymap-set minibuffer-mode-map "TAB" #'minibuffer-complete)

;; `isearch' uses `rgrep'.
(keymap-global-set "M-s r" #'rgrep)

;; Duplicate line, extended from "rexim/tsoding".
(defun padul/duplicate-line ()
  "Duplicate line by yanking and putting it to the next line.
Derived from tsoding, this is the best duplicate since vim's `yyp'"
  (interactive)
  (let ((col (- (point) (pos-bol)))
	(line (let ((s (thing-at-point 'line t)))
		(if s (string-remove-suffix "\n" s)
		  ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char col)))

(keymap-global-set "C-," #'padul/duplicate-line)

(provide 'keymaps)
;;; keymaps.el ends here
