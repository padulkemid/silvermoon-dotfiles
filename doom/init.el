;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (corfu +orderless)
       vertico

       :ui
       ophints
       (popup +defaults)
       (vc-gutter +pretty)
       ligatures

       :editor
       (format +onsave)
       snippets
       parinfer

       :checkers
       syntax
       
       :emacs
       dired
       ibuffer
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
