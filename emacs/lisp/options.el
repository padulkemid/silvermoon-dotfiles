;;; options.el --- Options -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; Stock Emacs knobs I actually want (Bedrock / DOOM as reference). No packages
;; here, just setopt/setq and a couple of built-in modes.

;;; Code:

;; User config, this way emacs knows me better.
(setopt user-full-name "Fadhil Muhammad"
	user-mail-address "fadhil2903@gmail.com"
	frame-title-format '("emacs@padulkemid"))

;; Turn off welcome screen.
(setopt inhibit-splash-screen t)

;; *scratch* at the beginning will use this.
(setopt initial-major-mode 'fundamental-mode)

;; Disable time load average popup.
(setopt display-time-default-load-average nil)

;; Automatically reread from disk if the underlying file
;; changes by using OS file change notification interface
;; rather than polling repeteadly.
(setopt auto-revert-avoid-polling t
	auto-revert-interval 5
	auto-revert-check-vc-info t)
(global-auto-revert-mode)

;; Save history in minibuffer.
(savehist-mode)

;; Bigger undo buffer (stock ~160KB feels like "no history"). Builtin only —
;; DOOM also uses undo-fu-session for undo *across* Emacs restarts (package).
(setq undo-limit (* 16 1024 1024)	 ; 16 MiB
      undo-strong-limit (* 48 1024 1024) ; 48 MiB
      undo-outer-limit (* 64 1024 1024)) ; 64 MiB

;; Enable recent files check.
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; Kill/yank use Emacs kill-ring only (nvim-register style).
;; Cmd+c / Cmd+v still use the macOS clipboard via clipboard-* in keymaps.
(setopt save-interprogram-paste-before-kill t
	kill-do-not-save-duplicates t
	select-enable-clipboard nil
	select-enable-primary nil)

;; Sane syntax in re-builder (M-x `re-builder') or regexp builder.
(setopt reb-re-syntax 'string)

;; Don't ping url-looking things when running find-file.
(setopt ffap-machine-p-known 'reject)

;; Reversible C-x 1 needs winner (binding lives in keymaps).
;; Drop stock C-c <left/right> — we use C-x w w / C-x w W instead.
(setopt winner-dont-bind-my-keys t)
(winner-mode +1)

;; After save prompts, ask once more before dying (same idea as DOOM).
;; `y-or-n-p' so this confirm is single-key y/n only (not global short-answers).
(setopt confirm-kill-emacs #'y-or-n-p)

;; Prefer horizontal split on landscape monitors.
(setopt split-window-preferred-direction 'longest)

;; Fix archaic defaults
;; justification: https://practicaltypography.com/one-space-between-sentences.html
(setopt sentence-end-double-space nil)

(add-hook 'before-save-hook #'whitespace-cleanup)

;; Keep *~ backups under user-emacs-directory/emacs-backup/ (not next to projects).
(defun padul/backup-file-name (fpath)
  "Return a backup path for FPATH under `user-emacs-directory'/emacs-backup/."
  (let* ((backup-root-dir (concat user-emacs-directory "emacs-backup/"))
	 (file-path (replace-regexp-in-string "[A-Za-z]:" "" fpath))
	 (backup-file-path
	  (replace-regexp-in-string
	   "//" "/" (concat backup-root-dir file-path "~"))))
    (make-directory (file-name-directory backup-file-path) t)
    backup-file-path))
(setopt make-backup-file-name-function #'padul/backup-file-name)

;; Disable bidirectional text scanning.
(setq-default bidi-display-reordering 'left-to-right
	      bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Set the default fill-column to 80.
(setq-default fill-column 80)

;; View lossage or "keystrokes", I believe I didn't need this.
;; DOOM leaves this off so I will follow.
;; (setopt view-lossage-auto-refresh t)

;; Defer fontification until I stop typing.
(setopt redisplay-skip-fontification-on-input t)

;; Increase process output buffer for LSP.
;; I disabled this but I might need it in the future
;; my DOOM config now still uses the default 64KB.
(setopt read-process-output-max (* 4 1024 1024)) ; 4MB to ease up LSPs

;; Don't render cursors in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setopt highlight-nonselected-windows nil)

;; Faster mark popping so you can Press C-u C-SPC once and then
;; spam C-SPC x 100!
(setopt set-mark-command-repeat-pop t)

;; Recenter after `save-place-mode' restores position.
(advice-add 'save-place-find-file-hook
	    :after
	    (lambda (&rest _)
	      (when buffer-file-name (ignore-errors (recenter)))))

;; Auto select help windows.
(setopt help-window-select t)

;; Use spaces not tabs. (although I liked tabs)
;; (setopt indent-tabs-mode nil)

;; Yellow minibuffer when focus leaves an active prompt (e.g. Completions).
(minibuffer-nonselected-mode -1)

;; Disable bell ringing, its uncomfortable.
(setopt ring-bell-function #'ignore
	visible-bell nil)

;; Minibuffer settings.
;; For help, see: https://www.masteringemacs.org/article/understanding-minibuffer-completion
(setopt enable-recursive-minibuffers t  ; Use the minibuffer whilst in the minibuffer.
	completion-cycle-threshold 1    ; TAB cycles candidates.
	completions-detailed t          ; Show annotations.
	tab-always-indent 'complete     ; When I hit TAB, try to complete, otherwise, indent.
	completion-styles '(basic initials substring) ; Different styles to match input to candidates.
	minibuffer-visible-completions t             ; Use ↑↓ to select candidates.
	completion-auto-help 'always                 ; Open completion always; could be `lazy' for another option.
	completions-max-height 20                    ; This is an arbitrary value.
	completions-format 'one-column               ; Makes it easier to scroll.
	completions-group t
	completion-show-help nil	; Remove the M-<arrow> help.

	;; Eager completion setup.
	completion-auto-select 'second-tab ; Much more eager
	completion-eager-display t         ; Show the *Completions* buffer immediately.
	completion-eager-update t)         ; Update display as-you-type.

;; Automatic inline completion previews if you enable this
;; but please try the settings above first because its build into
;; (emacs "30.1").
;; (completion-preview-mode)

;; Those are the default minibuffer settings, if you want it easy better to use
;; `vertico' or the builtins in emacs are also ok like `ido-mode' or `fido-mode-vertical'

;; Use `isearch' by Emacs's built-in searching system.
(use-package isearch
  :ensure nil                           ; Already installed.
  :bind
  (:map isearch-mode-map
	("C-." . isearch-forward-thing-at-point)) ; Search occurence under cursor.
  :custom
  (lazy-count-prefix-format "(%s/%s) ") ; Count format.
  (isearch-repeat-on-direction-change t) ; C-r immediately goes to previous match.
  (isearch-wrap-pause 'no-ding))         ; Automatically wrap search to top.

;; Modeline modes.
(setopt mode-line-collapse-minor-modes nil ; Collapse minor mode.
	x-underline-at-descent-line nil    ; Check this for underline later.
	switch-to-buffer-obey-display-actions t ; Make switching buffer more consistent
	show-trailing-whitespace nil)           ; Not showing whitespaces.

;; Enable horizontal scrolling.
(setopt mouse-wheel-tilt-scroll t)

;; Repeat mode makes it easier to repeat commands;
;; `C-x o C-x o' becomes `C-x o o' do check
;; See https://karthinks.com/software/it-bears-repeating/
(repeat-mode)

(provide 'options)
;;; options.el ends here
