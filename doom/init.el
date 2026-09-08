;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (corfu +orderless)
       vertico

       :ui
       (popup +defaults)
       (vc-gutter +pretty)
       ligatures

       :editor
       (format +onsave)
       (whitespace +guess +trim)
       snippets
       parinfer

       :checkers
       (syntax +flymake)

       :emacs
       dired
       ibuffer
       electric
       undo

       :tools
       (lsp +eglot)
       (eval +overlay)
       lookup
       magit
       tree-sitter

       :os
       (:if (featurep :system 'macos) macos)

       :lang
       (org +roam +present)
       (clojure +lsp +tree-sitter)
       (json +tree-sitter)
       (yaml +tree-sitter)
       (markdown +tree-sitter)
       emacs-lisp

       :config
       (default +bindings +smartparens))
