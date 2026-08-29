;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; extras
(package! leetcode)

;; lsp
(package! lsp-vtsls
  :recipe
  (:host github
   :repo "sdvcrx/lsp-vtsls"))
(package! mason)
