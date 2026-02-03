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
       zen

       :editor
       fold
       (format +onsave)
       
       :emacs
       dired
       electric
       ibuffer
       undo
       vc

       :checkers
       syntax

       :tools
       (eval +overlay)
       (lookup +dictionary +docsets)
       lsp
       magit
       tree-sitter

       :os
       (:if (featurep :system 'macos) macos)
       ;;tty

       :lang
       emacs-lisp
       (json +tree-sitter)
       (javascript +tree-sitter)
       (dart +flutter)
       kotlin
       markdown
       (org +pandoc +roam2 +dragndrop +present +gnuplot)
       (latex +latexmk)
       web
       (yaml +tree-sitter)

       :config
       (default +bindings +smartparens))
