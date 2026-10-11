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
  :config
  (setopt ledger-report-use-native-highlighting nil)
  (add-to-list 'ledger-reports '("trend"    "%(binary) -f %(ledger-file) -M bal Expenses") t)
  (add-to-list 'ledger-reports '("pnl"      "%(binary) -f %(ledger-file) -p %(month) bal ^Income ^Expenses") t)
  (add-to-list 'ledger-reports '("budget"   "%(binary) -f %(ledger-file) budget -p %(month)") t)
  (add-to-list 'ledger-reports '("forecast" "%(binary) -f %(ledger-file) --forecast 'd<[2027/02/01]' -M reg ^Assets:Checking") t))

(provide 'extras)
