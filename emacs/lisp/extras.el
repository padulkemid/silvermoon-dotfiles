;;; extras.el --- Extras -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; Extras contains something else that I haven't quite figure it out yet.
;;
;; e.g for this specific reason, I wanted to install `ledger'.
;; this is ledger specific configurations that I want to alter from
;; John Wiegly himself. it has a specific mode tailored to Emacs
;; but I need to install `ledger-mode' and then its CLI program
;; `ledger'; so it can interact with Emacs and then the command line.

;;; Code:

;; this will install the required mode for `ledger'
(use-package ledger-mode
  :ensure t
  :mode ("\\.ledger\\'" "\\.dat\\'" "\\.lgr\\'")
  )

(provide 'extras)
