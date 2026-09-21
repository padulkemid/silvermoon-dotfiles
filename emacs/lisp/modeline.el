;;; modeline.el --- Modeline -*- lexical-binding: t; -*-
;; Author: Fadhil Muhammad <https://github.com/padulkemid>
;;
;;; Commentary:
;; This is how my sacred modeline is being made, I need it
;; super simple and very descriptive. So I can get many information
;; from it.

;;; Code:

;; Display time settings.
(setq display-time-interval 60		; Interval to update the display time.
      display-time-format "%H:%M"	; Format the time.
      display-time-default-load-average nil ; No need to display load average.
      display-time-string-forms		    ; The string format if we hover our mouse into the clock.
      '((propertize (format-time-string display-time-format now)
                    'face 'display-time-date-and-time
                    'help-echo (format-time-string "%a %b %e, %Y" now))))

;; Enable display time mode (clock).
(display-time-mode 1)

;; Set the location position to be e.g: "[20%]·[13:51]".
;; its the position, line, and column.
(setq mode-line-percent-position '(-3 "%p")
      mode-line-position-column-line-format '(" %l:%c"))

;; Enable column number mode.
(column-number-mode 1)

;; We wanted the buffer name to not add a default 12-width padding.
;; Emacs defaults to this e.g: "[init.el      ]"
;; but we want "[init.el]".
(setq-default mode-line-buffer-identification
              (propertized-buffer-identification "%b"))

;; Buffer name.
(setq padul/mode-line-buffer
      '(" " mode-line-buffer-identification " "))

(defun padul/vc-mode-trim-leading-space (&rest _)
  (when (stringp vc-mode)
    (setq vc-mode (string-trim-left vc-mode))))

;; This will trim the `vc-mode' face (like buffer in line 13).
(advice-add 'vc-mode-line :after #'padul/vc-mode-trim-leading-space)

;; Combine everything.
(setq padul/mode-line-active-left
      '(" "
        display-time-string
        " "
        mode-line-mule-info
        mode-line-client
        mode-line-modified
        mode-line-remote
        mode-line-window-dedicated
        padul/mode-line-buffer))

(setq padul/mode-line-active-right
      '("" mode-name
        " "
        (vc-mode vc-mode)
        " "
        mode-line-position))

;; If buffer is inactive we just display the buffer name, no need to
;; display everything.
(setq padul/mode-line-inactive
      '(" " padul/mode-line-buffer))

(setq-default mode-line-format
              '((:eval (if (mode-line-window-selected-p)
                           padul/mode-line-active-left
                         padul/mode-line-inactive))
                mode-line-format-right-align
                (:eval (if (mode-line-window-selected-p)
                           padul/mode-line-active-right))))

(provide 'modeline)
;;; modeline.el ends here
