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

       :editor
       (evil +everywhere)
       (format +onsave)
       
       :emacs
       dired
       electric
       undo

       :tools
       magit

       :os
       (:if (featurep :system 'macos) macos)

       :lang
       (org +roam +present)
       emacs-lisp

       :config
       (default +bindings +smartparens))
