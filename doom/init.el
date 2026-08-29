;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (corfu +orderless)
       vertico

       :ui
       doom
       hl-todo
       ophints
       (popup +defaults)
       (vc-gutter +pretty)
       ligatures
       window-select

       :editor
       ;; I was using this but I want to understand
       ;; Emacs completely
       ;; (evil +everywhere) 
       (format +onsave)
       snippets
       parinfer

       :checkers
       syntax
       
       :emacs
       dired
       electric
       undo

       :tools
       magit
       lsp
       tree-sitter
       (eval +overlay)

       :os
       (:if (featurep :system 'macos) macos)

       :lang
       (org +roam +present)
       (javascript +lsp +tree-sitter)
       (clojure +lsp +tree-sitter)
       emacs-lisp

       :config
       (default +bindings +smartparens))
