;;; post-init.el --- POST INIT -*- lexical-binding: t; -*-

;;; AUTHOR's note: this is pretty much insane config, I threw it all out at
;; once, very bad.

;;; PLUGINS
;; Native compilation enhances Emacs performance by converting Elisp code into
;; native machine code, resulting in faster execution and improved
;; responsiveness.
;;
;; Ensure adding the following compile-angel code at the very beginning
;; of your `~/.emacs.d/post-init.el` file, before all other packages.
(use-package compile-angel
  :ensure t
  :demand t
  :init
  ;; Set `compile-angel-verbose` to nil to suppress output from compile-angel.
  ;; Drawback: The minibuffer will not display compile-angel's actions.
  (setq compile-angel-verbose t)

  :config
  ;; The following directive prevents compile-angel from compiling your init
  ;; files. If you choose to remove this push to `compile-angel-excluded-files'
  ;; and compile your pre/post-init files, ensure you understand the
  ;; implications and thoroughly test your code. For example, if you're using
  ;; `use-package', you'll need to explicitly add `(require 'use-package)' at
  ;; the top of your init file.
  (push "/init.el" compile-angel-excluded-files)
  (push "/early-init.el" compile-angel-excluded-files)
  (push "/pre-init.el" compile-angel-excluded-files)
  (push "/post-init.el" compile-angel-excluded-files)
  (push "/pre-early-init.el" compile-angel-excluded-files)
  (push "/post-early-init.el" compile-angel-excluded-files)

  ;; A local mode that compiles .el files whenever the user saves them.
  ;; (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)

  ;; A global mode that compiles .el files before they are loaded.
  (compile-angel-on-load-mode))

;; Corfu enhances in-buffer completion by displaying a compact popup with
;; current candidates, positioned either below or above the point. Candidates
;; can be selected by navigating up or down.
(use-package corfu
  :ensure t
  :commands (corfu-mode global-corfu-mode)
  :bind (:map corfu-map
              ("M-o" . corfu-info-documentation)
              ("TAB" . corfu-next)
              ([tab] . corfu-next)
              ("S-TAB" . corfu-previous)
              ([backtab] . corfu-previous))
  
  :hook ((prog-mode . corfu-mode)
         (org-mode . corfu-mode))

  :init
  ;; Enable automatic popup
  (setq corfu-auto t
        corfu-cycle t
        corfu-preselect 'prompt)
  ;; (corfu-auto-delay 0.1)
  ;; (corfu-auto-prefix 0.1)
  ;; Hide commands in M-x which do not apply to the current mode.
  (setq read-extended-command-predicate #'command-completion-default-include-p)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  (setq text-mode-ispell-word-completion nil)
  (setq tab-always-indent 'complete)

  ;; Enable Corfu
  :config
  (global-corfu-mode))

;; Cape, or Completion At Point Extensions, extends the capabilities of
;; in-buffer completion. It integrates with Corfu or the default completion UI,
;; by providing additional backends through completion-at-point-functions.
(use-package cape
  :ensure t
  :commands (cape-dabbrev cape-file cape-elisp-block)
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; Vertico provides a vertical completion interface, making it easier to
;; navigate and select from completion candidates (e.g., when `M-x` is pressed).
(use-package vertico
  ;; (Note: It is recommended to also enable the savehist package.)
  :ensure t
  :config
  (vertico-mode))

;; Vertico leverages Orderless' flexible matching capabilities, allowing users
;; to input multiple patterns separated by spaces, which Orderless then
;; matches in any order against the candidates.
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless flex basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia allows Embark to offer you preconfigured actions in more contexts.
;; In addition to that, Marginalia also enhances Vertico by adding rich
;; annotations to the completion candidates displayed in Vertico's interface.
(use-package marginalia
  :ensure t
  :commands (marginalia-mode marginalia-cycle)
  :hook (after-init . marginalia-mode))

;; Consult offers a suite of commands for efficient searching, previewing, and
;; interacting with buffers, file contents, and more, improving various tasks.
(use-package consult
  :ensure t
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:". consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s r" . consult-ripgrep)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))

  ;; Enable automatic preview at point in the *Completions* buffer.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init
  ;; Optionally configure the register formatting. This improves the register
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Aggressive asynchronous that yield instantaneous results. (suitable for
  ;; high-performance systems.) Note: Minad, the author of Consult, does not
  ;; recommend aggressive values.
  ;; Read: https://github.com/minad/consult/discussions/951
  ;;
  ;; However, the author of minimal-emacs.d uses these parameters to achieve
  ;; immediate feedback from Consult.
  ;; (setq consult-async-input-debounce 0.02
  ;;       consult-async-input-throttle 0.05
  ;;       consult-async-refresh-delay 0.02)

  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

;; Use flycheck not flymake
(use-package consult-flycheck
  :ensure t
  :after (consult flycheck)
  :bind (("C-c e g" . consult-flycheck)))

;; Use mason from neovim
(let ((mason-bin-path (expand-file-name "~/.local/share/nvim/mason/bin/")))
  (when (file-directory-p mason-bin-path)
    (add-to-list 'exec-path mason-bin-path)))

;; Set up the Language Server Protocol (LSP) servers using Eglot.
(use-package eglot
  :ensure nil
  :hook (
         (typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (js-ts-mode . eglot-ensure)
         (js-jsx-mode . eglot-ensure))
  :commands (eglot-ensure
             eglot-rename
             eglot-format-buffer)

  :bind ("C-c C-a" . eglot-code-actions)
  :config
  (add-to-list 'eglot-server-programs
               '((tsx-ts-mode typescript-ts-mode js-jsx-mode javascript-mode) . ("vtsls" "--stdio"))))

;; Flycheck is a package that "should" replace flymake of its async checker
;; and linter for major programming modes. it will ran with some of the
;; installed linter.
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-javascript-eslint-executable "eslint_d"))

;; To integrate with Eglot, we need to disable Flymake because that is the
;; default code-type-lint checking from Emacs
(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :custom (flycheck-eglot-exclusive nil)
  :config
  (global-flycheck-eglot-mode 1))

;; The markdown-mode package provides a major mode for Emacs for syntax
;; highlighting, editing commands, and preview support for Markdown documents.
;; It supports core Markdown syntax as well as extensions like GitHub Flavored
;; Markdown (GFM).

(use-package markdown-mode
  :commands (gfm-mode
             gfm-view-mode
             markdown-mode
             markdown-view-mode)

  :mode (("\.markdown\'" . markdown-mode)
         ("\.md\'" . markdown-mode)
         ("\.md\.asc\'" . markdown-mode)
         ("README\.md\'" . gfm-mode))

  :bind
  (:map markdown-mode-map
        ("C-c C-e" . markdown-do)))

;; This will initialize your PATH variable from shell into your emacs
;; system so that it won't get out again like 'pdflatex' are not
;; recognizable command from.

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


;; Modes for org-babel
(use-package kotlin-ts-mode
  :ensure t
  :mode (("\.kt\'" . kotlin-ts-mode)
         ("\.kts\'" . kotlin-ts-mode)))

(use-package ob-kotlin
  :ensure t
  :after org

  :config
  (add-to-list 'org-babel-load-languages '(kotlin . t))
  (add-to-list 'org-src-lang-modes '("kotlin" . kotlin-ts-mode)))

(use-package ob-typescript
  :ensure t
  :after org

  :config
  (add-to-list 'org-babel-load-languages '(typescript . t))
  (add-to-list 'org-src-lang-modes '("typescript" . typescript-ts-mode))
  (add-to-list 'org-src-lang-modes '("ts" . typescript-ts-mode))
  (add-to-list 'org-src-lang-modes '("tsx" . tsx-ts-mode)))


;; Org mode is a major mode designed for organizing notes, planning, task
;; management, and authoring documents using plain text with a simple and
;; expressive markup syntax. It supports hierarchical outlines, TODO lists,
;; scheduling, deadlines, time tracking, and exporting to multiple formats
;; including HTML, LaTeX, PDF, and Markdown.
(use-package org
  :ensure t
  :commands (org-mode org-version)
  :mode
  ("\.org\'" . org-mode)
  
  :bind (:map org-mode-map
              ("C-c a" . org-agenda)
              ("C-c c" . org-capture)
              ("C-c l" . org-store-link))
  :hook
  (org-mode . (lambda ()
                "Set column and auto-fill."
                (setq fill-column 60)
                (auto-fill-mode t)))

  :config
  (setq org-hide-leading-stars t
        org-startup-indented t
        org-adapt-indentation nil
        org-edit-src-content-indentation 0
        org-startup-truncated t
        org-return-follows-link t
        org-hide-emphasis-markers t
        org-directory "~/Work/personal-journal/"
        org-agenda-files '("~/Work/personal-journal/work.org"
                           "~/Work/personal-journal/home.org")
        org-latex-compiler "xelatex"
        org-log-done 'time)
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((emacs-lisp . t)
                                 (kotlin . t)
                                 (typescript . t)))

  (setq org-src-lang-modes
        (append org-src-lang-modes
                '(("kotlin" . kotlin-ts)
                  ("typescript" . typescript-ts)
                  ("ts" . typescript-ts))))
  
  (setq org-todo-keyword-faces
        '(("TODO" . "red")
          ("IN_PROGRESS" . "magenta")
          ("DONE" . "spring green")
          ("CANCELLED" . "dark olive green"))))

;; Org-roam is an extension for org-mode as a dispose of zettelkasten method
;; to build your own brain for journaling and stuff.
(use-package org-roam
  :ensure t
  :mode ("\.org\'" . org-mode)
  :init
  (setq org-roam-directory (file-truename "~/Work/personal-journal/roam/")
        org-roam-dailies-capture-templates
        '(("d" "default" entry "* %?"
           :if-new (file+head "%<%Y/%m/%d>.org" "#+title: %^{Title}\n#+date: <%<%Y-%m-%d %a %H:%M>>\n#+filetags::coding:")
           :unnarrowed t
           :empty-lines-before 1
           )))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*}" " " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

;; Tree-sitter in Emacs is an incremental parsing system introduced in Emacs 29
;; that provides precise, high-performance syntax highlighting. It supports a
;; broad set of programming languages, including Bash, C, C++, C#, CMake, CSS,
;; Dockerfile, Go, Java, JavaScript, JSON, Python, Rust, TOML, TypeScript, YAML,
;; Elisp, Lua, Markdown, and many others.
(use-package treesit-auto
  :ensure t
  :init
  (setq treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Helpful is an alternative to the built-in Emacs help that provides much more
;; contextual information.
(use-package helpful
  :ensure t
  :commands (helpful-callable
             helpful-variable
             helpful-key
             helpful-command
             helpful-at-point
             helpful-function)
  :bind
  ([remap describe-command] . helpful-command)
  ([remap describe-function] . helpful-callable)
  ([remap describe-key] . helpful-key)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  :init
  (setq helpful-max-buffers 7))

;; Enables automatic indentation of code while typing
(use-package aggressive-indent
  :ensure t
  :commands aggressive-indent-mode
  :hook
  (emacs-lisp-mode . aggressive-indent-mode))

;; Highlights function and variable definitions in Emacs Lisp mode
(use-package highlight-defined
  :ensure t
  :commands highlight-defined-mode
  :hook
  (emacs-lisp-mode . highlight-defined-mode))

;; Prevent parenthesis imbalance
;; (use-package paredit
;;   :ensure t
;;   :commands paredit-mode
;;   :hook
;;   (emacs-lisp-mode . paredit-mode)
;;   :config
;;   (define-key paredit-mode-map (kbd "RET") nil)
;;   (define-key paredit-mode-map (kbd "M-s") nil))

;; Prevent parenthesis imbalance (improved) using 'smartparens'
(use-package smartparens
  :ensure t
  :hook (prog-mode text-mode markdown-mode)
  :config
  (require 'smartparens-config)
  (add-hook 'prog-mode-hook #'smartparens-strict-mode))


;; Displays visible indicators for page breaks
(use-package page-break-lines
  :ensure t
  :commands (page-break-lines-mode
             global-page-break-lines-mode)
  :hook
  (emacs-lisp-mode . page-break-lines-mode))

;; Provides functions to find references to functions, macros, variables,
;; special forms, and symbols in Emacs Lisp
(use-package elisp-refs
  :ensure t
  :commands (elisp-refs-function
             elisp-refs-macro
             elisp-refs-variable
             elisp-refs-special
             elisp-refs-symbol))

;; Killer git porcelain
(use-package magit
  :ensure t
  :commands (magit-status)
  :bind (("C-x g" . magit-status)))

;; Apheleia is an Emacs package designed to run code formatters (e.g., Shfmt,
;; Black and Prettier) asynchronously without disrupting the cursor position.
(use-package apheleia
  :ensure t
  :config
  (setf (alist-get 'prettierd apheleia-formatters)
        '("prettierd" "--stdin-filepath" filepath))
  (setf (alist-get 'jq apheleia-formatters)
        '("jq" "."))
  (add-to-list 'apheleia-mode-alist '(tsx-ts-mode . prettierd))
  (add-to-list 'apheleia-mode-alist '(typescript-ts-mode . prettierd))
  (add-to-list 'apheleia-mode-alist '(js-ts-mode . prettierd))
  (add-to-list 'apheleia-mode-alist '(js-jsx-mode . prettierd))
  (add-to-list 'apheleia-mode-alist '(json-ts-mode . jq))
  (apheleia-global-mode +1))


;;; BUILT-INS
;; Auto-revert
(setq auto-revert-interval 3)
(setq auto-revert-remote-files nil)
(setq auto-revert-use-notify t)
(setq auto-revert-avoid-polling nil)
(setq auto-revert-verbose t)
(global-auto-revert-mode 1)

;; recentf
(setq recentf-max-saved-items 300)
(setq recentf-max-menu-items 15)
(setq recentf-auto-cleanup (if (daemonp) 300 'never))
(setq recentf-exclude
      (list "\.tar$" "\.tbz2$" "\.tbz$" "\.tgz$" "\.bz2$"
            "\.bz$" "\.gz$" "\.gzip$" "\.xz$" "\.zip$"
            "\.7z$" "\.rar$"
            "COMMIT_EDITMSG'"
            "\.\(?:gz\|gif\|svg\|png\|jpe?g\|bmp\|xpm\)$"
            "-autoloads\.el$" "autoload\.el$"))
(recentf-mode 1)
(add-hook 'kill-emacs-hook #'recentf-cleanup -90)

;; savehist
(setq history-length 300)
(setq savehist-autosave-interval 600)
(setq savehist-additional-variables
      '(kill-ring                        ; clipboard
        register-alist                   ; macros
        mark-ring global-mark-ring       ; marks
        search-ring regexp-search-ring))
(savehist-mode 1)

;; saveplace
(setq save-place-limit 400)
(save-place-mode 1)

;; epg
(with-eval-after-load 'epg
  (setq epg-pinentry-mode 'loopback))







;;; SETTINGS
(setq set-fringe-style "no-fringes")
(setq read-file-name-completion-ignore-case t)           ;; vertico+orderless ignorecase                 
(setq display-line-numbers-type 'relative)               ;; relative-line-number
(setq display-time-format "%H:%M")                       ;; time format
(setq vc-display-status t)                               ;; display status for version control
(setq vc-handled-backends '(Git))                        ;; disable vc (version control) I already have magit
(global-display-line-numbers-mode 1)                     ;; line-number
(display-time)                                           ;; display time

;;; COLORS
(set-face-attribute 'fringe nil :background "black")
(set-face-attribute 'line-number nil
                    :background "black"
                    :foreground "dark gray")
(set-face-attribute 'line-number-current-line nil
                    :background "black"
                    :foreground "white"
                    :weight 'bold)
(set-face-attribute 'mode-line-active nil
                    :background "white"
                    :foreground "black"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :background "dark gray"
                    :foreground "black"
                    :box nil)



;;; MODELINE
;; (defun my/mode-line-time ()
;;   "Get current time in [HH:MM] format for mode-line."
;;   (concat "[" (format-time-string "%H:%M") "]"))
;; 
;; (defun my/mode-line-vc ()
;;   "Format vc-mode to show [branch] instead of Git:branch."
;;   (when vc-mode
;;     (let ((branch (substring-no-properties vc-mode)))
;;       ;; Remove the "Git:" or "Git-" prefix and add brackets
;;       (if (string-match "^ Git[:-]\\(.+\\)" branch)
;;           (concat "[" (match-string 1 branch) "]")
;;         (concat "[" (string-trim branch) "]")))))
;; 
;; (defun my/mode-line-major-mode ()
;;   "Get major mode in brackets."
;;   (concat "[" (symbol-name major-mode) "]"))
;; 
;; (defun my/mode-line-position ()
;;   "Get position info in Neovim style."
;;   (let* ((line (line-number-at-pos))
;;          (col (current-column)))
;;     (format "[%d:%d]" line col)))
;; 
;; (setq-default mode-line-format
;;               '(""
;;                 (eldoc-mode-line-string (" " eldoc-mode-line-string " ")) 
;;                 "%e"
;;                 mode-line-front-space
;;                 (:propertize
;;                  ("" mode-line-mule-info mode-line-client mode-line-modified mode-line-remote
;;                   mode-line-window-dedicated)
;;                  display (min-width (6.0)))
;;                 mode-line-frame-identification 
;;                 (:eval (my/mode-line-vc))
;;                 (:eval (my/mode-line-major-mode))
;;                 (:eval (propertize " " 'display '(space :align-to (- center 15))))
;;                 "[" mode-line-buffer-identification "]"
;;                 (:eval (propertize " " 'display '(space :align-to (- right 15))))
;;                 (:eval (my/mode-line-position))
;;                 (:eval (my/mode-line-time))
;;                 (:eval (if mode-line-misc-info (concat " " mode-line-misc-info) ""))
;;                 mode-line-end-spaces))

;;; DEFAULT MODELINE
;; (setq-default mode-line-format 
;;   '("" (eldoc-mode-line-string (" " eldoc-mode-line-string " ")) "%e"
;;     mode-line-front-space
;;     (:propertize
;;      ("" mode-line-mule-info mode-line-client mode-line-modified mode-line-remote
;;       mode-line-window-dedicated)
;;      display (min-width (6.0)))
;;     mode-line-frame-identification mode-line-buffer-identification "   "
;;     mode-line-position (project-mode-line project-mode-line-format)
;;     (vc-mode vc-mode) "  " mode-line-modes mode-line-misc-info mode-line-end-spaces))
