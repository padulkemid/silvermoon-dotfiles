;;; dev.el --- Developer Setup -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; This file will list every settings that I need to start develop
;; and do programming. Every Emacs package that will help me to
;; write "elisp" and "lisp" families language in general, or just
;; basic programming.
;;
;; For around Emacs, everything is stable enough so no "duplicates"
;; of known packages or plugin is good enough to rival the stable one
;; or which is that already being maintained and put in ELPA.

;; This file will use bedrock's format in which everything will be
;; typed using `use-package'.

;;; Code:

;; Basic emacs + tree-sitter config.
(use-package emacs
  :ensure nil				; Built-in no need to download, its Emacs itself lol.
  :config
  (setopt treesit-enabled-modes t)	; Enable tree-sitter in all available modes.
  (setopt treesit-font-lock-level 4)	; Enable maximum boldness for variables.
  (setopt treesit-auto-install-grammar 'ask)) ; Manually `ask' in grammar installation.

;; Auto pairs, barf, slurp, everything.
(use-package smartparens
  :hook (prog-mode text-mode)
  :config
  (require 'smartparens-config))

;; Magit, your one stop shop Git client.
(use-package magit
  :bind (("C-x g" . magit-status))
  :config
  (setq magit-git-executable "/opt/homebrew/bin/git"))

;; Mason — PATH for LSP/formatters. :defer 0 = first idle after init (not in INIT secs).
(use-package mason
  :defer 0
  :config
  (mason-setup))

(use-package eglot
  :ensure nil
  :defer t
  :custom
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)
  :config
  (setopt eglot-code-action-indicator "h")
  (setq eglot-code-action-indications '(left-fringe))
  (fset #'jsonrpc--log-event #'ignore)
  (setopt eglot-workspace-configuration
	  '((clojure (maxCompletions . 100)))))

;; Format-on-save. First idle after init — keeps INIT message honest.
(use-package apheleia
  :ensure nil
  :load-path ("/Users/padulkemid/Work/personal-projects/apheleia")
  :defer 0
  :config
  (setf (alist-get 'clojurescript-mode apheleia-mode-alist) 'cljfmt)
  (setf (alist-get 'clojurec-mode apheleia-mode-alist) 'cljfmt)
  (setf (alist-get 'clojure-ts-clojurescript-mode apheleia-mode-alist) 'cljfmt)
  (setf (alist-get 'clojure-ts-clojurec-mode apheleia-mode-alist) 'cljfmt)
  (apheleia-global-mode +1))

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode)))

(provide 'dev)
;;; dev.el ends here
