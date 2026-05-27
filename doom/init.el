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
       (evil +everywhere)
       (format +onsave)
       
       :emacs
       dired
       electric
       ibuffer
       undo

       :checkers
       syntax

       :tools
       (eval +overlay)
       magit

       :os
       (:if (featurep :system 'macos) macos)

       :lang
       (org +roam2 +present)
       (dart +flutter)
       kotlin
       web
       emacs-lisp
       json
       yaml
       javascript

       :config
       (default +bindings +smartparens))
