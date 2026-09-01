;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; extras
(package! leetcode)
(package! almost-mono-themes)

;; lsp
(package! lsp-vtsls
  :recipe
  (:host github
   :repo "sdvcrx/lsp-vtsls"))
(package! mason)
