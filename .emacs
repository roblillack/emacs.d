(setq inhibit-startup-message t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

(setq *want-semantic* nil)
(setq *want-company* nil)
(setq *want-gtags* nil)

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

(custom-set-faces
 '(default ((default (:stipple nil :background "#ffffff"
                      :foreground "#1a1a1a" :inverse-video nil
                      :box nil :strike-through nil :overline nil
                      :underline nil :slant normal :weight normal
                      :width normal))
            (((type ns)) (:height 120 :family "monaco"))
            (((type x)) (:height 95 :family "fixed"))
            (t (:height 90 :family "DejaVu Sans Mono"))))
 '(fixed-pitch ((t nil)))
 '(trailing-whitespace ((t :background "#ffffee")))
 '(mode-line ((default (:background "#5555aa" :foreground "white"
                  :box (:line-width 1 :style released-button)))
              (((type ns)) (:height 120 :family "sans"))
              (((type x)) (:height 70 :family "Helvetica"))
              (t (:height 80 :family "sans"))))
 '(modeline-inactive ((default (:inherit modeline
                                :background "#dddddd"
                                :foreground "#777777"
                                :box (:line-width 1)))))
 '(fringe ((default (:foreground "#aa9999" :background "#f7f7f7"))))
 '(linum ((default (:inherit fringe))))
 '(variable-pitch ((t (:inherit mode-line))))
 '(font-lock-comment-face ((t (:foreground "#555555"))))
 ;'(font-lock-variable-name-face ((t (:foreground "#993333"))))
 '(font-lock-string-face ((default (:foreground "#dd2200" :background "#ffefef"))))

 '(font-lock-variable-name-face ((default (:foreground "#990000"))))
 '(php-sexp-face ((default (:foreground "#555555" :background "#efefef"))))
 '(php-variable-marker-face ((default (:foreground "#333399"))))
 '(php-property-name-face ((default (:foreground "#339933"))))
 '(php-type-access-face ((default (:foreground "#555577"))))
)

; LOOK
(setq-default cursor-type '(bar . 2))                 ; cursor soll ein strich sein
(blink-cursor-mode t)                                 ; und blinken
(global-hl-line-mode (if window-system 1 -1))         ; aktive zeile markieren
(set-face-background 'hl-line "#eeeef8")              ; ... und lachsfarben anmalen
(show-paren-mode t)                                   ; klammern markieren
(setq paren-match-face 'paren-face-match-light)       ; ... die benutzte farbe setzen
(when window-system
  (setq show-paren-style 'expression))                ; ... den kompletten content markieren
(custom-set-faces
 '(show-paren-match-face
   ((t (:background "#ccffee")))))
(setq parse-sexp-ignore-comments t)                   ; ignore comments when balancing stuff
(setq transient-mark-mode t)                          ; markierung live anzeigen
(setq visible-bell t)                                 ; schwarzer kasten statt sound
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
(add-hook 'c-mode-common-hook
          (lambda () (c-subword-mode t)))             ; CamelCase als EinzelWorte

; copy'n'paste behaviour
(when (eq window-system 'x)
  (setq mouse-drag-copy-region nil)                   ; mouse selection does NOT go into kill ring
  (setq x-select-enable-primary nil)                  ; NO killing/yanking with with primary X11 selection
  (setq x-select-enable-clipboard t)                  ; killing/yanking with clipboard X11 selection
  (setq select-active-regions t)                      ; active region sets primary X11 selection
  (when (>= emacs-major-version 23)
    (global-set-key [mouse-2] 'mouse-yank-primary)))  ; middle mouse button only pastes primary X11 selection


(defun toggle-show-trailing-whitespace ()
  "Toggle the display of trailing whitespace, by changing the
buffer-local variable `show-trailing-whitespace'."
  (interactive)
  (save-excursion
    (setq show-trailing-whitespace
          (not show-trailing-whitespace))
    (redraw-display)
    (message (concat "Display of trailing whitespace "
                     (if show-trailing-whitespace
                         "enabled" "disabled")))))

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
(global-set-key (kbd "<mode-line> <mouse-4>") 'cycle-buffer)
(global-set-key (kbd "<mode-line> <mouse-5>") 'cycle-buffer-backward)

; frame switching
(global-set-key (kbd "C-`") 'next-multiframe-window)

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
(setq frame-title-format "%b — Emacs")

(defconst animate-n-steps 5)
(defun emacs-reloaded ()
  (animate-string (concat ";; Initialization successful, welcome to "
  			  (substring (emacs-version) 0 16)
			  ".")
		  0 0)
  (newline-and-indent)
  (newline-and-indent))
(when window-system
  (add-hook 'after-init-hook 'emacs-reloaded))


;(setq default-input-method "MacOSX")

;; full screen toggle using command+[RET]
;; http://www.emacswiki.org/cgi-bin/wiki/FullScreen
(defun toggle-fullscreen ()
  (interactive)
  (if (eq system-type 'darwin)
      (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                               nil
                                             'fullboth))
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                           '(2 "_NET_WM_STATE_FULLSCREEN" 0))))
(global-set-key [(super return)] 'toggle-fullscreen)
(global-set-key [f11] 'toggle-fullscreen)

; tab is tab
(define-key key-translation-map "\t" (kbd "<tab>"))

; Terminal.app
(global-set-key (kbd "\e[h") 'beginning-of-line)
(global-set-key (kbd "\e[f") 'end-of-line)
(global-set-key (kbd "\e[5d") 'backward-word)
(global-set-key (kbd "\e[5c") 'forward-word)

; Screen
(if (null key-translation-map) (setq key-translation-map (make-sparse-keymap)))
(define-key key-translation-map (kbd "M-O A") (kbd "<up>"))
(define-key key-translation-map (kbd "M-O B") (kbd "<down>"))
(define-key key-translation-map (kbd "M-O C") (kbd "<right>"))
(define-key key-translation-map (kbd "M-O D") (kbd "<left>"))

(define-key key-translation-map (kbd "\e[1;5A") (kbd "<C-up>"))
(define-key key-translation-map (kbd "\e[1;5B") (kbd "<C-down>"))
(define-key key-translation-map (kbd "\e[1;5C") (kbd "<C-right>"))
(define-key key-translation-map (kbd "\e[1;5D") (kbd "<C-left>"))

(define-key key-translation-map (kbd "\e[1;2A") (kbd "<S-up>"))
(define-key key-translation-map (kbd "\e[1;2B") (kbd "<S-down>"))
(define-key key-translation-map (kbd "\e[1;2C") (kbd "<S-right>"))
(define-key key-translation-map (kbd "\e[1;2D") (kbd "<S-left>"))

(define-key key-translation-map (kbd "\e[1~") (kbd "<home>"))
(define-key key-translation-map (kbd "\e[4~") (kbd "<end>"))
(define-key key-translation-map (kbd "\e[3~") (kbd "<deletechar>"))
(define-key key-translation-map (kbd "\e[3;5~") (kbd "<C-delete>"))
(define-key key-translation-map (kbd "\e[5~") (kbd "<prior>"))
(define-key key-translation-map (kbd "\e[6~") (kbd "<next>"))
(define-key key-translation-map (kbd "\e[5;5~") (kbd "<C-prior>"))
(define-key key-translation-map (kbd "\e[5;6~") (kbd "<C-next>"))

; thx, http://www.emacswiki.org/emacs/BackwardDeleteWord
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

; stolen from simple.el
(defun delete-line (arg)
  "Deletes the rest of the rest of the current line
the same way `kill-line' does (including the interpretation
of `kill-whole-line'."
  (interactive "p")
  (delete-region (point)
                 ;; It is better to move point to the other end of the kill
                 ;; before killing.  That way, in a read-only buffer, point
                 ;; moves across the text that is copied to the kill ring.
                 ;; The choice has no effect on undo now that undo records
                 ;; the value of point from before the command was run.
                 (progn
                   (if arg
                       (forward-visible-line (prefix-numeric-value arg))
                     (if (eobp)
                         (signal 'end-of-buffer nil))
                     (let ((end
                            (save-excursion
                              (end-of-visible-line) (point))))
                       (if (or (save-excursion
                                 ;; If trailing whitespace is visible,
                                 ;; don't treat it as nothing.
                                 (unless show-trailing-whitespace
                                   (skip-chars-forward " \t" end))
                                 (= (point) end))
                               (and kill-whole-line (bolp)))
                           (forward-visible-line 1)
                         (goto-char end))))
                   (point))))

(dolist (cmd
 '(delete-word backward-delete-word delete-line))
  (put cmd 'CUA 'move)
)

(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key (kbd "C-<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<end>") 'end-of-buffer)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-n") 'new-frame)
;(global-set-key (kbd "<delete>") 'delete-char)
(global-set-key (kbd "<kp-delete>") 'delete-char)
(global-set-key (kbd "C-<kp-delete>") 'delete-word)
(global-set-key (kbd "<backspace>") 'delete-backward-char)
(global-set-key (kbd "C-<backspace>") 'backward-delete-word)
(global-set-key (kbd "C-w") 'backward-delete-word)
(global-set-key (kbd "C-k") 'delete-line)
(global-set-key (kbd "S-C-k") 'kill-line)

; Suchen
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\C-\M-s" 'isearch-forward)
(global-set-key "\C-\M-r" 'isearch-backward)
(define-key isearch-mode-map (kbd "<backspace>") 'isearch-del-char)
(define-key isearch-mode-map (kbd "<escape>") 'isearch-abort)

; moving in panes/„windows“
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-<delete>") 'delete-window)
(global-set-key (kbd "M-<backspace>") 'delete-window)
(global-set-key (kbd "M-<space>") 'split-window-horizontally)
(global-set-key (kbd "M-<insert>") 'split-window-horizontally)
(global-set-key (kbd "M-+") 'enlarge-window-horizontally)
(global-set-key (kbd "M-=") 'enlarge-window-horizontally)
(global-set-key (kbd "M--")  'shrink-window-horizontally)
(global-set-key (kbd "S-M-<insert>")  'split-window-vertically)

(global-set-key "\C-j" 'imenu)

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

; Org+Remember
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("/org/.*$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org"))
(setq org-CUA-compatible t)
(org-remember-insinuate)
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cr" 'org-remember)
(setq org-clock-persist t)
(org-clock-persistence-insinuate)
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)

; Clojure support
(autoload 'clojure-mode "clojure-mode/clojure-mode.el" "A major mode for Clojure" t)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

; PHP support
(autoload 'php-mode "php-mode" "PHP editing mode" t)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php3\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php4\\'" . php-mode))

(add-hook 'php-mode-hook
          (lambda ()
            (c-set-style "user")
            (define-key php-mode-map (kbd "C-.") nil)))
;            (require 'flymake-php)
;            (flymake-mode t)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;(autoload 'twitter-get-friends-timeline "twitter" nil t)
;(autoload 'twitter-status-edit "twitter" nil t)
;(global-set-key "\C-xt" 'twitter-get-friends-timeline)
;(add-hook 'twitter-status-edit-mode-hook 'longlines-mode)

;(require 'w3m-load)

(require 'bufferlist)

; line numbering
; wget http://stud4.tuwien.ac.at/~e0225855/linum/linum.el
(autoload 'linum-mode "linum" nil t)
(autoload 'global-linum-mode "linum" nil t)

(global-set-key [f2] 'linum-mode)
(global-set-key (kbd "S-<f2>") 'global-linum-mode)
(global-set-key [f3] 'bufferlist)
(global-set-key [f4] 'kill-buffer-and-window)
(global-set-key [f7] 'shell)

; my bufferlist rocks, but sometimes i'm in the mood for ...
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

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
(setq yas/next-field-key [S-tab])
(setq yas/fallback-behaviour 'return-nil)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

; hippie
(require 'dabbrev)
(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-lisp-symbol))
        ;try-completion))
;(global-set-key [tab] 'hippie-expand)

(when *want-company*
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
  (define-key company-active-map [S-return] 'company-expand-top)

  (when *want-semantic*
    (dolist (mode '(php-mode))
      (company-add-completion-rule mode
                                   'company-semantic-ctxt-current-symbol
                                   'company-semantic-completion-func)))

  (company-install-dabbrev-completions)
  (company-install-file-name-completions)
  (company-install-lisp-completions)
  (when *want-gtags*
    (require 'company-gtags-completions))

  (dolist (hook '(c-mode-common-hook
                  css-mode-hook
                  php-mode-hook
                  emacs-lisp-hook
                  lisp-mode-hook))
    (add-hook hook
              '(lambda ()
                 (company-mode t)))))

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
    (if *want-company*
        (call-interactively 'company-start-showing)
      (call-interactively 'hippie-expand))))
;      (if (functionp 'complete-word-at-point)
;          (complete-word-at-point)
;        (hippie-expand)))))

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

(when *want-gtags*
  (require 'gtags)
  (dolist (hook '(c-mode-hook
                  php-mode-hook
                  emacs-lisp-hook
                  lisp-mode-hook))
    (add-hook hook
              '(lambda ()
                 (gtags-mode t))))
  (global-set-key (kbd "C-j") 'gtags-find-tag)
;(global-set-key (kbd "C-j left") 'gtags-pop-stack)
)

; bookmarks
; cd ~/.emacs.d/plugins
; http://download.savannah.gnu.org/releases/bm/bm-1.34.el
(when window-system
  (require 'bm)
  (setq-default bm-buffer-persistence t)
  (setq bm-highlight-style 'bm-highlight-line-and-fringe)
  (custom-set-faces
   '(bm-fringe-persistent-face ((t (:background "#ccccff" :foreground "black"))))
   '(bm-persistent-face ((t (:background "#ccccff" :foreground "black")))))
  (global-set-key (kbd "C-'") 'bm-toggle)
  (global-set-key (kbd "C-#") 'bm-toggle)
  (global-set-key (kbd "C-,") '(lambda () (interactive) (cua--deactivate) (bm-previous)))
  (global-set-key (kbd "C-.") '(lambda () (interactive) (cua--deactivate) (bm-next)))
  (defun bm-mouse-toggle (event)
    (interactive "e")
    (save-excursion (mouse-set-point event) (bm-toggle)))
  (global-set-key [left-margin mouse-1] 'bm-mouse-toggle)
  (global-set-key [left-fringe mouse-1] 'bm-mouse-toggle))

; highlight-symbol
; cd ~/.emacs.d/plugins
; wget http://nschum.de/src/emacs/highlight-symbol/highlight-symbol.el
(require 'highlight-symbol)
(defun highlight-symbol-mouse-toggle (event)
  (interactive "e")
  (save-excursion (mouse-set-point event) (highlight-symbol-at-point)))
(global-set-key (kbd "C-\"") 'highlight-symbol-at-point)
(global-set-key (kbd "C-<") '(lambda () (interactive) (cua--deactivate) (highlight-symbol-prev)))
(global-set-key (kbd "C->") '(lambda () (interactive) (cua--deactivate) (highlight-symbol-next)))
(global-set-key [(control shift mouse-1)] 'highlight-symbol-mouse-toggle)

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
