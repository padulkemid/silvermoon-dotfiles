;;; clojure.el --- Clojure -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; Clojure / ClojureScript. Lean cut of what I ran under DOOM
;; (`clojure' +lsp +tree-sitter): tree-sitter major mode, CIDER for
;; the REPL, Eglot for clojure-lsp (Mason).
;; Formatting is Apheleia in dev.el (cljfmt via Mason).
;;
;; Per clojure-ts-mode README: classic clojure-mode still needed for some
;; CIDER APIs; remapping (default) sends buffers to the TS modes. Grammars
;; install on first open when git + a C compiler are on PATH.

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Major mode (tree-sitter)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; DOOM also :defer's this — remaps go in :init so .clj hits TS without
;; loading the whole package at startup. (:demand was the blunt fix.)
(use-package clojure-ts-mode
  :defer t
  :init
  (setopt clojure-ts-auto-remap nil)	; we install remaps ourselves
  (dolist (entry '((clojure-mode . clojure-ts-mode)
		   (clojurescript-mode . clojure-ts-clojurescript-mode)
		   (clojurec-mode . clojure-ts-clojurec-mode)
		   (clojuredart-mode . clojure-ts-clojuredart-mode)
		   (edn-mode . clojure-ts-mode)
		   (jank-mode . clojure-ts-jank-mode)
		   (joker-mode . clojure-ts-joker-mode)))
    (add-to-list 'major-mode-remap-defaults entry)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   CIDER (REPL / eval / test)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Pulls clojure-mode as a dependency (APIs not fully ported yet). README:
;; enable cider-mode on the TS hooks yourself.
(use-package cider
  :defer t
  :hook ((clojure-ts-mode . cider-mode)
	 (clojure-ts-clojurescript-mode . cider-mode)
	 (clojure-ts-clojurec-mode . cider-mode)
	 (clojure-ts-clojuredart-mode . cider-mode)
	 (clojure-ts-jank-mode . cider-mode)
	 (clojure-ts-joker-mode . cider-mode))
  :custom
  (cider-repl-display-help-banner nil)
  (cider-repl-pop-to-buffer-on-connect 'display-only))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   LSP (Eglot + Mason's clojure-lsp)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Eglot lives in dev.el; hooks only here. mason-setup puts bin/ on exec-path.
;; Built-in eglot maps clojure-ts-mode → clojure-lsp; add the dialect majors.
(with-eval-after-load 'eglot
  (add-to-list
   'eglot-server-programs
   '((clojure-ts-clojurescript-mode
      clojure-ts-clojurec-mode
      clojure-ts-clojuredart-mode
      clojure-ts-jank-mode
      clojure-ts-joker-mode)
     . ("clojure-lsp"))))

(add-hook 'clojure-ts-mode-hook #'eglot-ensure)
(add-hook 'clojure-ts-clojurescript-mode-hook #'eglot-ensure)
(add-hook 'clojure-ts-clojurec-mode-hook #'eglot-ensure)
(add-hook 'clojure-ts-clojuredart-mode-hook #'eglot-ensure)
(add-hook 'clojure-ts-jank-mode-hook #'eglot-ensure)
(add-hook 'clojure-ts-joker-mode-hook #'eglot-ensure)

(provide 'clojure)
;;; clojure.el ends here
