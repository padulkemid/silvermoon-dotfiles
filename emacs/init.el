;;; init.el --- Init -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; This is my initial vanilla config that mimics new ((emacs "31.1"))
;; via Emacs Bedrock (https://codeberg.org/ashton314/emacs-bedrock)
;; copyright to Ashton Wiersdorf for the fantastic kickstarter.
;;
;; A new journey involved because I wanted more control over DOOM Emacs
;; that I've been using for a year, right now its tailored by myself
;; and my aim was to make this minimal as possible and fast for typing,
;; coding (especially lisp-family languages), and writing notes.

;;; Code:

;; Package initialization.
(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

;; My modules.
(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))
(require 'options)
(require 'keymaps)
(require 'ui)
(require 'modeline)
(require 'dev)
(require 'clojure)
(require 'notes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Built-in customization framework
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(almost-mono-themes cider clojure-ts-mode diff-hl ibuffer-project magit
                        markdown-mode mason smartparens)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "black"))))
 '(line-number ((t (:background "black" :foreground "dark gray"))))
 '(line-number-current-line ((t (:background "black" :foreground "white" :weight bold))))
 '(mode-line ((t (:box nil :underline nil :overline nil :background "black" :foreground "white"))))
 '(mode-line-active ((t (:box nil :underline nil :overline nil :background "black" :foreground "white"))))
 '(mode-line-highlight ((t (:box nil :underline nil :overline nil))))
 '(mode-line-inactive ((t (:box nil :underline nil :overline nil :background "black" :foreground "dark gray"))))
 '(region ((t (:background "dark cyan"))))
 '(tab-bar ((t (:background unspecified))))
 '(tab-bar-tab ((t (:background unspecified))))
 '(show-paren-match-expression ((t (:background "dark slate gray")))))


;; DOOM-style startup line (echo area + *Messages*).
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "padul emacs loaded %d packages in %.03fs"
                     (length package-activated-list)
                     (float-time
                      (time-subtract after-init-time before-init-time)))))

;;; init.el ends here
