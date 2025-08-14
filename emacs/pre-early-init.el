;;; pre-early-init.el --- Pre Early Init -*- lexical-binding: t; -*-

;; Emacs-plus no border
(add-to-list 'default-frame-alist '(undecorated . t))

;; Font
(add-to-list 'default-frame-alist '(font . "BerkeleyMono Nerd Font Mono-14"))

;; Debug mode
(setq debug-on-error t)

;; Reducing clutter
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
