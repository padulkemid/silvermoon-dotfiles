;;; early-init.el --- Early-Init -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; This is the entry before the initialization came. So all operations
;; that will fast up booting and everything will be executed here first including
;; garbage collection vars, min-maxing outputs, etc.

;;; Code:
;; GC during startup (from minimal-emacs.d): raise hard here, restore on
;; emacs-startup-hook. Bedrock's end-of-init reset to ~800KB caused extra GC
;; while packages were still loading.
(defvar padul-gc-cons-threshold (* 32 1024 1024)
  "Post-startup `gc-cons-threshold' (32 MiB).")
(defvar padul-gc-cons-percentage 0.1
  "Post-startup `gc-cons-percentage'.")

(setq gc-cons-threshold (if noninteractive
			    (* 256 1024 1024) ; 256 MiB in batch
			  most-positive-fixnum)
      gc-cons-percentage 1.0)

(defun padul--restore-gc ()
  "Restore GC knobs after startup."
  (setq gc-cons-threshold padul-gc-cons-threshold
	gc-cons-percentage padul-gc-cons-percentage))
(add-hook 'emacs-startup-hook #'padul--restore-gc 105)

;; Trim file-name handlers during startup (minimal-emacs.d). Restored after.
(defvar padul--file-name-handler-alist (default-toplevel-value 'file-name-handler-alist))
(unless (or noninteractive init-file-debug)
  (set-default-toplevel-value
   'file-name-handler-alist
   (if (locate-file-internal "calc-loaddefs.el" load-path)
       nil
     (list (rassq 'jka-compr-handler padul--file-name-handler-alist))))
  (add-hook 'emacs-startup-hook
	    (lambda ()
	      (set-default-toplevel-value
	       'file-name-handler-alist
	       (delete-dups
		(append file-name-handler-alist
			padul--file-name-handler-alist))))
	    101))

(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
;; Mute async native-comp warnings on normal boots (same idea as DOOM's
;; early-init). Set to t when debugging compile issues.
(setq native-comp-async-report-warnings-errors nil)

;; Silence stupid startup message
(advice-add #'display-startup-echo-area-message :override #'ignore)

;; Tell use-package to install if missing by default
;; Use `:ensure nil' in packages you *don't* want to install
(setq use-package-always-ensure t)

;; Concatenate package autoloads — big win after `package-quickstart-refresh'.
(setq package-quickstart t)

;; Frame: avoid expensive resize/font work during startup (minimal-emacs.d).
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      inhibit-compacting-font-caches t)

;; Disable tool-bar-mode.
(tool-bar-mode -1)

;; These settings apply to *all* frames.
;; `font` here so the first frame never flashes the system default.
(setq default-frame-alist
      '((font . "Comic Code Ligatures-20") ; Sets default font.
	(vertical-scroll-bars . nil)	   ; Hides the vertical scrollbar.
	(horizontal-scroll-bars . nil)	   ; Hides the horizontal scrollbar.
	(ns-appearance . dark)		   ; Appearance follows `dark' not system.
	(ns-transparent-titlebar . t)))	   ; Transparent titlebar.

;; One family everywhere (help keys use fixed-pitch; some UI still uses serif face).
(set-face-attribute 'fixed-pitch nil :family "Comic Code Ligatures")
(set-face-attribute 'fixed-pitch-serif nil :family "Comic Code Ligatures")

;;; early-init.el ends here
