(setq inhibit-startup-message t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

(setq *want-semantic* nil)

;(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;    (let* ((my-lisp-dir "~/.emacs.d/plugins/")
;           (default-directory my-lisp-dir))
;      (progn
;        (setq load-path (cons my-lisp-dir load-path))
;        (normal-top-level-add-subdirs-to-load-path))))
;(setq load-path (cons (expand-file-name "~/.emacs.d") load-path))

;(when *byte-code-cache-enabled*
;  (load "init-byte-code-cache"))

;(require 'color-theme)
;(require 'slime)
;(slime-setup)
;(setq inferior-lisp-program "sbcl")

;(color-theme-clarity)
;(add-hook 'text-mode-hook 'turn-on-auto-fill)

; jetzt ziehen wir alle register
(set-register ?e '(file . "~/.emacs"))

;;; CEDET
(when *want-semantic*
  (load "~/.emacs.d/plugins/cedet/common/cedet.el")
  (require 'semantic)
  (require 'semanticdb)
  (require 'semantic-ia)
  (require 'senator)
  (global-senator-minor-mode 1)
  (global-semantic-idle-scheduler-mode 1)        ; reparsen, wenn idle
  ;(global-semantic-decoration-mode (semantic-decoration-styles))
  ;;(global-semantic-highlight-edits-mode 1)       ; aenderungen highlighten, bis sie geparst sind
  ;(global-semantic-idle-completions-mode 1)      ; menue anzeigen, wenn idle
  ;(global-semanticdb-minor-mode 1)
  ;(global-semantic-auto-parse-mode t)
  (global-semantic-summary-mode t)
  ;(global-semantic-show-parser-state-mode 1)
  (global-semantic-idle-summary-mode 1)          ; functions-signatur zeigen, wenn idle
  ;(global-semantic-show-dirty-mode nil nil (semantic-util-modes))
  ;(global-semantic-show-unmatched-syntax-mode 1) ; unparsable code markieren
  (global-semantic-stickyfunc-mode t nil (semantic-util-modes))
  (global-semantic-summary-mode t nil (semantic-util-modes))
  (setq semanticdb-default-save-directory "~/.emacs.d/cache/semanticdb")
  (setq semanticdb-persistent-path '(always))
  (setq semanticdb-system-database-warn-level t)
  ;(semantic-load-enable-guady-code-helpers)

  (defun my-semantic-hook ()
    (local-set-key (kbd "C-/") 'semantic-ia-complete-symbol)
    ;(local-set-key (kbd "C-/") 'semantic-ia-complete-symbol-menu)
    ;(local-set-key (kbd "C-.") 'senator-completion-menu-popup)
    ;(local-set-key (kbd "C-.") 'semantic-complete-analyze-inline)
    ;(local-set-key (kbd "C-g C-g") 'senator-jump)
    )
  (add-hook 'c-mode-common-hook 'my-semantic-hook)
  (add-hook 'lisp-mode-hook 'my-semantic-hook)
  ;(add-hook 'php-mode-hook 'my-semantic-hook)
  ;(global-set-key [(control return)] 'semantic-ia-complete-symbol)
  ;(global-set-key [(control shift return)] 'semantic-ia-complete-symbol-menu)
)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))
;(add-to-list 'load-path "/opt/local/share/emacs/site-lisp")

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;(autoload 'typopunct-mode "typopunct" "Typopunct Mode" t)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;;(require 'install-elisp)
;;(setq install-elisp-repository-directory "~/.emacs.d/")

;(global-set-key (kbd "C-x C-b") 'ibuffer)
;(autoload 'ibuffer "ibuffer" "List buffers." t)

; yes.


;; Some window system specific settings.
(if window-system
  (progn
    (menu-bar-mode (if (eq system-type 'darwin) t -1))
    (tool-bar-mode -1)
    (setq line-number-mode t)
    (setq column-number-mode t))
  (menu-bar-mode -1)
)

(if (string= system-type "gnu/linux")
    (custom-set-faces
     '(default ((t (:stipple nil :background "#ffffff"
                    :foreground "#1a1a1a" :inverse-video nil
                    :box nil :strike-through nil :overline nil
                    :underline nil :slant normal :weight normal
                    :height 105 :width normal :family "terminus"))))
     '(fixed-pitch ((t nil)))
     '(linum ((t (:foreground "#555555" :background "white"
                  :height 80 :family "terminus"))))
     '(mode-line ((t (:background "#5555aa" :foreground "white"
                      :box (:line-width 1 :style released-button)
                      :height 70 :family "sans"))))
     '(variable-pitch ((t (:height 0.8 :family "sans"))))))

(if (eq system-type 'darwin)
    (custom-set-faces
     '(default ((t (:stipple nil :background "#ffffff"
                    :foreground "#1a1a1a" :inverse-video nil
                    :box nil :strike-through nil :overline nil
                    :underline nil :slant normal :weight normal
                    :height 100 :width normal :family "monaco"))))
     '(fixed-pitch ((t nil)))
     '(linum ((t (:foreground "#555555" :background "#eeeeee"
                  :height 90 :family "Helvetica"))))
     '(mode-line ((t (:background "#5555aa" :foreground "white"
                      :box (:line-width 1 :style released-button)
                      :height 110 :family "Helvetica"))))
     '(variable-pitch ((t (:height 110 :family "Helvetica"))))))

; eeePC? try some smaller fonts
(when (string-match "^brutus" system-name)
  (custom-set-faces
   '(default ((t (:stipple nil :background "#ffffff"
                           :foreground "#1a1a1a" :inverse-video nil
                           :box nil :strike-through nil :overline nil
                           :underline nil :slant normal :weight normal
                           :height 75 :width normal :family "terminus"))))
   '(linum ((t (:foreground "#999999" :background "#eeeeee"
                            :height 40 :family "terminus"))))
   '(mode-line ((t (:background "#5555aa" :foreground "white"
                                :box (:line-width 1 :style released-button)
                                :height 60 :family "sans"))))))

; LOOK
(setq-default cursor-type '(bar . 2))                 ; cursor soll ein strich sein
(blink-cursor-mode t)                                 ; und blinken
(global-hl-line-mode 1)                               ; aktive zeile markieren
(set-face-background 'hl-line "#eeeef8")              ; ... und lachsfarben anmalen
(show-paren-mode t)                                   ; klammern markieren
(setq paren-match-face 'paren-face-match-light)       ; ... die benutzte farbe setzen
(setq paren-sexp-mode t)                              ; ... auch den inhalt markieren
(setq transient-mark-mode t)                          ; markierung live anzeigen
(setq visible-bell t)                                 ; schwarzer kasten statt sound
(require 'linum)                                      ; wir setzen das jetzt mal voraus
(global-linum-mode 1)                                 ; ... wir wollen zeilennummern
(display-time-mode t)                                 ; uhrzeit anzeigen
(size-indication-mode t)                              ; groesse des files anzeigen
(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

; FEEL
(cua-mode t)                                          ; shift zum selektieren + std. keycombos
(setq cua-keep-region-after-copy t)                   ; markierung bleibt nach kopieren
(require 'redo)                                       ; wir wollen eine simple lineare geschichte
(global-set-key [(control z)] 'undo)                  ; ... mit den tastenkombinationen,
(global-set-key [(shift control z)] 'redo)            ; ... an die wir uns mittlerweile gewoehnten
(savehist-mode 1)                                     ; minibuffer-kram merken
(setq savehist-additional-variables                   ; ... eigentlich
      '(search-ring regexp-search-ring))              ; ... koennen wir uns suchen auch merken
(recentf-mode 1)                                      ; achja, die letzten offnen files. genau.
(mouse-wheel-mode t)                                  ; ein bissl rummausen
(setq mouse-wheel-scroll-amount '(1))                 ; ... aber wirklich nur ein bissl
(setq kill-whole-line t)                              ; ctrl-k laesst keine leere zeile stehen
(setq-default truncate-lines t)                       ; zeilen abschneiden, nicht umbrechen
(defalias 'yes-or-no-p 'y-or-n-p)                     ; "y or n" statt "yes or no"
(setq imenu-auto-rescan t)                            ; symbole selbst neu einlesen
(icomplete-mode t)                                    ; completion im minibuffer ohne tab
(setq-default indent-tabs-mode nil)                   ; einruecken mit space
(setq-default tab-width 4)                            ; ein tab ist 4 zeichen breit
(setq-default c-basic-offset 4)                       ; indent ist 4 zeichen breit
(setq-default show-trailing-whitespace t)             ; whitespace am zeilenende zeigen
(setq scroll-conservatively 3)                        ; bei max 3 zeilen scrollen ohne recenter

; merkt sich, wo wir in welchem file waren
(require 'saveplace)
(setq save-place-file (convert-standard-filename "~/.emacs.d/places"))
(setq-default save-place t)

; skripte automatisch ausfuehrbar machen
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(random t)

(setq backup-directory-alist `(("." . ,(expand-file-name "~/.emacs.d/backups")))
      auto-save-default nil)

(setq mumamo-chunk-coloring 'submode-colored
      nxhtml-skip-welcome t
      indent-region-mode t
      rng-nxml-auto-validate-flag nil)

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))

; (normal-erase-is-backspace-mode)
; (setq delete-key-deletes-backward t)

; i do
;(ido-mode t)
;(setq ido-enable-flex-matching -1)
;(add-hook 'ido-setup-hook
;          (lambda ()
;            (define-key ido-completion-map [tab] 'ido-complete)))

; buffer cycling
(autoload 'cycle-buffer "cycle-buffer" "Cycle forward." t)
(global-set-key [(control tab)] 'cycle-buffer)
(global-set-key (kbd "<mode-line> <wheel-up>") 'cycle-buffer)
(global-set-key (kbd "<mode-line> <wheel-down>") 'cycle-buffer-backward)

; mehrere files mit gleichem namen? verzeichnisse mit in puffernamen nehmen
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(global-set-key (kbd "C-c q") 'refill-mode)
(setq fill-column 72)

(setq backup-by-copying-when-linked t)
(setq backup-by-copying-when-mismatch t)
(setq x-select-enable-clipboard t)
(setq frame-title-format "%b — Emacs")

(defconst animate-n-steps 5)
(defun emacs-reloaded ()
  (animate-string (concat ";; Initialization successful, welcome to "
  			  (substring (emacs-version) 0 16)
			  ".")
		  0 0)
  (newline-and-indent)
  (newline-and-indent))
(add-hook 'after-init-hook 'emacs-reloaded)


;(setq default-input-method "MacOSX")

;; full screen toggle using command+[RET]
;(defun toggle-fullscreen ()
;  (interactive)
;  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
;                                           nil
;                                           'fullboth)))
;(global-set-key [(super return)] 'toggle-fullscreen)

; Terminal.app
(global-set-key (kbd "\e[h") 'beginning-of-line)
(global-set-key (kbd "\e[f") 'end-of-line)
(global-set-key (kbd "\e[5d") 'backward-word)
(global-set-key (kbd "\e[5c") 'forward-word)

; Emacs.app
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key (kbd "C-<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<end>") 'end-of-buffer)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
;(global-set-key (kbd "<delete>") 'delete-char)
(global-set-key (kbd "<kp-delete>") 'delete-char)
(global-set-key (kbd "C-<kp-delete>") 'kill-word)
(global-set-key (kbd "<backspace>") 'delete-backward-char)
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)

; Suchen
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\C-\M-s" 'isearch-forward)
(global-set-key "\C-\M-r" 'isearch-backward)
(define-key isearch-mode-map (kbd "<backspace>") 'isearch-del-char)

(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
;(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
;(global-set-key (kbd "C-x C-p") 'find-file-at-point)
;(global-set-key (kbd "C-c y") 'bury-buffer)
;(global-set-key (kbd "C-c r") 'revert-buffer)
;(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)

;(setq load-path (cons (expand-file-name "/usr/share/doc/git-core/contrib/emacs") load-path))
;(require 'vc-git)
;(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
;(require 'git)
;(autoload 'git-blame-mode "git-blame"
;          "Minor mode for incremental blame for Git." t)

; *** MAJOR MODES ***

; PHP support
(autoload 'php-mode "php-mode" "PHP editing mode" t)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php3\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php4\\'" . php-mode))
;(add-hook 'php-mode-hook
;          (lambda ()
;            (require 'flymake-php)
;            (flymake-mode t)))

;(autoload 'twitter-get-friends-timeline "twitter" nil t)
;(autoload 'twitter-status-edit "twitter" nil t)
;(global-set-key "\C-xt" 'twitter-get-friends-timeline)
;(add-hook 'twitter-status-edit-mode-hook 'longlines-mode)

;(require 'w3m-load)

(require 'bufferlist)

(global-set-key [f3] 'bufferlist)
(global-set-key [f4] 'kill-buffer-and-window)

;; ruby
;(add-to-list 'auto-mode-alist '("\\.rb" . ruby-mode))

;; ECB
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/ecb-2.32"))
;(require 'ecb)

; color-theme
; wget http://download.gna.org/color-theme/color-theme-6.6.0.zip
;(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-robin-hood)

; yasnippet
; cd ~/.emacs.d/plugins && svn checkout http://yasnippet.googlecode.com/svn/trunk/ yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(setq yas/trigger-key [f8])
(setq yas/fallback-behaviour 'return-nil)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

; hippie
(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-lisp-symbol
        try-completion))
;(global-set-key [tab] 'hippie-expand)

(require 'dabbrev)
(add-to-list 'load-path "~/.emacs.d/plugins/company")
(require 'company-mode)
(require 'company-bundled-completions)
;(company-install-bundled-completions-rules)
(setq company-complete-on-edit 4)
(setq company-idle-delay nil)
(setq company-display-style 'pseudo-tooltip)
(setq company-tooltip-delay 0.1)
(define-key company-mode-map "\t" 'ignore)
(define-key company-active-map [tab] 'company-expand-anything)

(when *want-semantic*
  (dolist (mode '(php-mode))
    (company-add-completion-rule mode
                                 'company-semantic-ctxt-current-symbol
                                 'company-semantic-completion-func)))

(company-install-dabbrev-completions)
(company-install-file-name-completions)
(company-install-lisp-completions)

(dolist (hook '(c-mode-common-hook
                css-mode-hook
                php-mode-hook
                emacs-lisp-hook
                lisp-mode-hook))
  (add-hook hook
            '(lambda ()
               (company-mode t))))

;(require 'completion-ui)
;(defun dabbrev--wrapper (prefix maxnum)
;  "Wrapper around `dabbrev--find-all-completions',
;     to use as a `completion-function'."
;  (dabbrev--reset-global-variables)
;  (let ((completions (dabbrev--find-all-expansions prefix nil)))
;    (when maxnum
;      (setq completions
;            (butlast completions (- (length completions) maxnum))))
;    completions))
;(setq-default completion-function 'dabbrev--wrapper)
;(setq completion-auto-show 'pop-up)
;(setq completion-auto-popup-frame t)

(defun smart-tab ()
  ""
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or mark-active
            (not (looking-at "\\_>")))
        (smart-indent)
        (smart-expand))))

(defun smart-expand ()
  "Expands the snippet using `yasnippet' or expands the symbol
using `company-mode' or `hippie-expand'."
  (interactive)
  (unless (yas/expand)
    (if (and (functionp 'company-mode) company-mode)
        (company-start-showing)
      (if (functionp 'complete-word-at-point)
          (complete-word-at-point)
        (dabbrev-expand)))))

(defun smart-indent ()
  "Indents region if mark is active, or current line otherwise."
  (interactive)
  (if mark-active
      (indent-region (region-beginning)
                     (region-end))
    (indent-for-tab-command)))

(defun smart-tab-must-expand (&optional prefix)
  "If PREFIX is \\[universal-argument], answers no.
Otherwise, analyses point position and answers."
  (unless (or (consp prefix)
              mark-active)
    (looking-at "\\_>")))

(global-set-key [tab] 'smart-tab)

; tabkey2
; wget http://www.emacswiki.org/cgi-bin/emacs/download/tabkey2.el
;        ("yasnippet" yas/expand (commandp 'yas/expand))
;        ("Ispell complete word" ispell-complete-word (commandp 'ispell-complete-word))
;("Semantic" senator-complete-symbol senator-minor-mode)
;(require 'tabkey2)
;(setq tabkey2-completion-functions
;      '(
;        ("Semantic" senator-complete-symbol senator-minor-mode)
;        ("Complete Emacs symbol" lisp-complete-symbol)
;        ("PHP Completion" php-complete-function)
;        ("dabbrev" dabbrev-expand (commandp 'dabbrev-expand)
;         '(lambda (setq dabbrev--last-abbrev-location nil)))
;        ))
;(tabkey2-mode t)

; bookmarks
; cd ~/.emacs.d/plugins
; http://download.savannah.gnu.org/releases/bm/bm-1.34.el
(when window-system
  (require 'bm)
  (setq-default bm-buffer-persistence t)
  (setq bm-highlight-style 'bm-highlight-only-fringe)
  (global-set-key (kbd "C-'") 'bm-toggle)
  (global-set-key (kbd "C-,") 'bm-previous)
  (global-set-key (kbd "C-.") 'bm-next)
  (global-set-key (or [left-margin mouse-1] [left-fringe mouse-1])
                  '(lambda (event)
                     (interactive "e")
                     (save-excursion (mouse-set-point event) (bm-toggle)))))

; ruby
; cd ~/.emacs.d/plugins && svn co http://svn.ruby-lang.org/repos/ruby/trunk/misc ruby
;(add-to-list 'load-path "~/.emacs.d/plugins/ruby")
;(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
;(setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
;(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
;(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process")
;(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
;(autoload 'ruby-electric-mode "ruby-electric" "Run the electric ruby minor mode")
;(add-hook 'ruby-mode-hook
;          '(lambda ()
;             (inf-ruby-keys)
;             (ruby-electric-mode t)
;             ))

; rails
; cd ~/.emacs.d/plugins
; wget http://www.kazmier.com/computer/snippet.el
; wget -O find-recursive.el http://www.webweavertech.com/ovidiu/emacs/find-recursive.txt
; git clone git://github.com/tomtt/emacs-rails.git
;(add-to-list 'load-path "~/.emacs.d/plugins/emacs-rails")
;(require 'rails)

; ri
;(autoload 'ri "ri-ruby" nil t)
;(autoload 'ri-ruby-complete-symbol "ri-ruby" nil t)
;(autoload 'ri "ri-ruby" nil t)
;(add-hook 'ruby-mode-hook (lambda ()
;                            (local-set-key [f1] 'ri)
;                            (local-set-key [tab] 'ri-ruby-complete-symbol)
;                            (local-set-key [f4] 'ri-ruby-show-args)
;                            ))

;;; nxhtml
;(load "~/.emacs.d/plugins/nxhtml/autostart.el")
;(setq
; nxhtml-global-minor-mode t
; mumamo-chunk-coloring 'submode-colored
; nxhtml-skip-welcome t
; indent-region-mode t
; rng-nxml-auto-validate-flag nil
; nxml-degraded t)
;(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-nxhtml-mumamo-mode))
;(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))


;; rhtml --> html
;(add-to-list 'auto-mode-alist '("\\.rhtml$" . nxml-mode))
;(add-to-list 'auto-mode-alist '("\\.rxml$" . ruby-mode))
;(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))

;(require 'yaml-mode)
;(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;(add-to-list 'load-path "~/.emacs.d/plugins")
;(require 'doc-mode)
;(add-hook 'c++-mode-hook 'doc-mode)
;(add-hook 'java-mode-hook 'doc-mode)
;(add-hook 'php-mode-hook 'doc-mode)

;(require 'lusty-explorer)

;(add-to-list 'load-path "~/.emacs.d/plugins/emacs-w3m")
;(when (string= system-type "darwin")
;  (setq w3m-command "/sw/bin/w3m"))
;(setq browse-url-browser-function 'w3m-browse-url)
;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
;(global-set-key "\C-xm" 'browse-url-at-point)

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))
(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'block-open 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont-nonempty 4))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-csharp-mode-hook ()
  (progn
   (setq tab-width 2)
   (setq c-basic-offset 2)
   (define-key csharp-mode-map (kbd "<return>") 'newline-and-indent)
   (define-key csharp-mode-map [tab] 'c-tab-indent-or-complete)))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

(when window-system
  (server-start))
