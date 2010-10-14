(setq inhibit-startup-message t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

(setq *want-semantic* nil)
(setq *want-company* nil)
(setq *want-gtags* t)
(setq *want-ac* t)

(when *is-a-mac*
  (setenv "PATH" (concat
                  (expand-file-name "~/bin")
                  ":/opt/local/bin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin")))

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
(setq inferior-lisp-program "sbcl")
;(setq inferior-lisp-program "java -cp /home/rob/dev/clojure/clojure.jar clojure.main")

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

; emacs-jabber: http://emacs-jabber.sourceforge.net/
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/emacs-jabber"))
(require 'jabber-autoloads)
(setq jabber-roster-buffer "ROSTER")
(setq jabber-roster-show-title nil)
(setq jabber-roster-show-bindings nil)
(setq jabber-show-resources nil)
(setq jabber-chat-buffer-show-avatar nil)
(setq jabber-roster-line-format "%c %-30n %u %S")
(custom-set-faces
 '(jabber-title-small ((t (:underline t :foreground "#777777"))))
 '(jabber-title-medium ((t (:weight bold :foreground "#333333"))))
 '(jabber-title-large ((t (:weight bold :foreground "black")))))
; i'm setting a list in ~/.emacs.d/private.el like this:
; (setq jabber-account-list '(("myaccount@bla.example") ("anotherone@bling.example/emacs")))
(setq jabber-account-list '())


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
            (((type ns)) (:height 110 :family "Menlo"))
            ; same dimensions
            ;(((type x)) (:height 105 :family "Inconsolata")) ; 100
            (((type x)) (:height 90 :family "DejaVu Sans Mono")) ; 85
            (t (:height 90 :family "fixed"))))
 '(fixed-pitch ((t nil)))
 '(trailing-whitespace ((t :background "#ffffee")))
 '(mode-line ((default (:background "#5555aa" :foreground "white"
                  :box (:line-width 1 :style released-button)))
              (((type ns)) (:height 120 :family "Optima"))
              (((type x)) (:height 75 :family "sans"))
              (t (:height 80 :family "Helvetica"))))
 '(modeline-inactive ((default (:inherit modeline
                                :background "#dddddd"
                                :foreground "#777777"
                                :box (:line-width 1)))))
 '(fringe ((default (:foreground "#aa9999" :background "#f7f7f7"))))
 '(linum ((default (:inherit fringe))))
 '(variable-pitch ((t (:inherit mode-line))))
 '(font-lock-comment-face ((t (:foreground "#555555"))))
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
(global-subword-mode t)                               ; CamelCase als EinzelWorte
(setq require-final-newline t)

; copy'n'paste behaviour
(when (eq window-system 'x)
  (setq mouse-drag-copy-region nil)                   ; mouse selection does NOT go into kill ring
  (setq x-select-enable-primary nil)                  ; NO killing/yanking with with primary X11 selection
  (setq x-select-enable-clipboard t)                  ; killing/yanking with clipboard X11 selection
  (setq select-active-regions t)                      ; active region sets primary X11 selection
  (when (>= emacs-major-version 23)
    (global-set-key [mouse-8] 'mouse-yank-primary)    ; use them crazy mouse buttons!
    (global-set-key [mouse-9] 'mouse-yank-primary)    ; indeed.
    (global-set-key [mouse-2] 'mouse-yank-primary)))  ; middle mouse button only pastes primary X11 selection

; shortcuts for font scaling
(global-set-key [(control mouse-4)] 'text-scale-increase)
(global-set-key [(control mouse-5)] 'text-scale-decrease)
(global-set-key [(control wheel-up)] 'text-scale-increase)
(global-set-key [(control wheel-down)] 'text-scale-decrease)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-<kp-add>") 'text-scale-increase)
(global-set-key (kbd "C-<kp-subtract>") 'text-scale-decrease)

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

; edit as root
(defun sudo-edit (&optional arg)
  (interactive "p")
  (if arg
      (find-file (concat "/sudo::" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo::" buffer-file-name))))

(defun sudo-edit-current-file ()
  (interactive)
  (find-alternate-file (concat "/sudo::" (buffer-file-name (current-buffer)))))

(global-set-key (kbd "C-x !") 'sudo-edit-current-file)

(require 'tramp)
(add-to-list 'tramp-default-proxies-alist '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist '((regexp-quote (system-name)) nil nil))

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

; do not open *Messages* when clicking into minibuffer
(defun my-mouse-drag-region (event)
  (interactive "e")
  (run-hooks 'mouse-leave-buffer-hook)
  (mouse-drag-track event t))
(global-set-key [down-mouse-1] 'my-mouse-drag-region)

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
  (if (eq (window-system) 'ns)
      (ns-toggle-fullscreen)
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                           '(2 "_NET_WM_STATE_FULLSCREEN" 0))))
(global-set-key [(super return)] 'toggle-fullscreen)
(global-set-key [f11] 'toggle-fullscreen)

; Terminal Key Sequence Translations
(if (null key-translation-map) (setq key-translation-map (make-sparse-keymap)))

; tab is tab
(define-key key-translation-map "\t" (kbd "<tab>"))

(define-key key-translation-map (kbd "\e[1;5A") (kbd "C-<up>"))
(define-key key-translation-map (kbd "\e[1;5B") (kbd "C-<down>"))
(define-key key-translation-map (kbd "\e[1;5C") (kbd "C-<right>"))
(define-key key-translation-map (kbd "\e[1;5D") (kbd "C-<left>"))
(define-key key-translation-map (kbd "\e[1;5H") (kbd "C-<home>"))
(define-key key-translation-map (kbd "\e[1;5F") (kbd "C-<end>"))

(define-key key-translation-map (kbd "\e[1;2A") (kbd "S-<up>"))
(define-key key-translation-map (kbd "\e[1;2B") (kbd "S-<down>"))
(define-key key-translation-map (kbd "\e[1;2C") (kbd "S-<right>"))
(define-key key-translation-map (kbd "\e[1;2D") (kbd "S-<left>"))
(define-key key-translation-map (kbd "\e[1;2H") (kbd "S-<home>"))
(define-key key-translation-map (kbd "\e[1;2F") (kbd "S-<end>"))

(define-key key-translation-map (kbd "\e[1;6A") (kbd "C-S-<up>"))
(define-key key-translation-map (kbd "\e[1;6B") (kbd "C-S-<down>"))
(define-key key-translation-map (kbd "\e[1;6C") (kbd "C-S-<right>"))
(define-key key-translation-map (kbd "\e[1;6D") (kbd "C-S-<left>"))
(define-key key-translation-map (kbd "\e[1;6H") (kbd "C-S-<home>"))
(define-key key-translation-map (kbd "\e[1;6F") (kbd "C-S-<end>"))

(define-key key-translation-map (kbd "\e[1~")   (kbd "<home>"))
(define-key key-translation-map (kbd "\e[4~")   (kbd "<end>"))
(define-key key-translation-map (kbd "\e[3~")   (kbd "<deletechar>"))
(define-key key-translation-map (kbd "\e[3;5~") (kbd "C-<delete>"))
(define-key key-translation-map (kbd "\e[5~")   (kbd "<prior>"))
(define-key key-translation-map (kbd "\e[6~")   (kbd "<next>"))
(define-key key-translation-map (kbd "\e[5;5~") (kbd "C-<prior>"))
(define-key key-translation-map (kbd "\e[5;6~") (kbd "C-<next>"))

(define-key key-translation-map (kbd "\e[rC;BS~") (kbd "C-<backspace>"))
(define-key key-translation-map (kbd "\e[rC;DEL~") (kbd "C-<delete>"))

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


(defun delete-line ()
  "Deletes the rest of the rest of the current line,
deletes the whole line, or joins with the following line
depending on the current position."
  (interactive)
  (let ((end (save-excursion (end-of-visible-line) (point))))
    (if (eq (point) end)
        (delete-char 1)
      (delete-region (point) end))))

(dolist (cmd
 '(delete-word backward-delete-word delete-line))
  (put cmd 'CUA 'move)
)

(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key (kbd "C-<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<end>") 'end-of-buffer)
(global-set-key (kbd "C-x C-k") '(lambda () (interactive) (kill-buffer)))
(global-set-key (kbd "C-x C-n") 'new-frame)
;(global-set-key (kbd "<delete>") 'delete-char)
(global-set-key (kbd "<kp-delete>") 'delete-char)
(global-set-key (kbd "C-<kp-delete>") 'delete-word)
(global-set-key (kbd "<backspace>") 'delete-backward-char)
(global-set-key (kbd "C-<backspace>") 'backward-delete-word)
(global-set-key (kbd "C-w") 'backward-delete-word)
(global-set-key (kbd "C-k") 'delete-line)
(global-set-key (kbd "S-C-k") 'kill-line)

(defun join-with-next-line ()
  "Join the current and the following line."
  (interactive)
  (next-line)
  (join-line))

(global-set-key (kbd "M-j") 'join-with-next-line)

; Search
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-f") 'isearch-forward-regexp)
(global-set-key (kbd "C-S-f") 'isearch-backward-regexp)
(define-key isearch-mode-map (kbd "<backspace>") 'isearch-del-char)
(define-key isearch-mode-map (kbd "<escape>") 'isearch-exit)
(define-key isearch-mode-map (kbd "<return>") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-S-f") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "C-g") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-v") 'isearch-yank-kill)

; moving in panes/„windows“
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-<delete>") 'delete-window)
(global-set-key (kbd "M-<kp-delete>") 'delete-window)
(global-set-key (kbd "M-<backspace>") 'delete-window)
(global-set-key (kbd "S-M-<delete>") 'delete-other-windows)
(global-set-key (kbd "S-M-<kp-delete>") 'delete-other-windows)
(global-set-key (kbd "S-M-<backspace>") 'delete-other-windows)
(global-set-key (kbd "M-<space>") 'split-window-horizontally)
(global-set-key (kbd "M-SPC") 'split-window-horizontally)
(global-set-key (kbd "S-M-<space>") 'split-window-vertically)
(global-set-key (kbd "S-M-SPC") 'split-window-vertically)
(global-set-key (kbd "M-<insert>") 'split-window-horizontally)
(global-set-key (kbd "M-=") 'enlarge-window-horizontally)
(global-set-key (kbd "M--")  'shrink-window-horizontally)
(global-set-key (kbd "M-+") 'enlarge-window)
(global-set-key (kbd "M-_") 'shrink-window)
(global-set-key (kbd "S-M-<insert>")  'split-window-vertically)

(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<delete>") 'delete-window)
(global-set-key (kbd "s-<kp-delete>") 'delete-window)
(global-set-key (kbd "s-<backspace>") 'delete-window)
(global-set-key (kbd "S-s-<delete>") 'delete-other-windows)
(global-set-key (kbd "S-s-<kp-delete>") 'delete-other-windows)
(global-set-key (kbd "S-s-<backspace>") 'delete-other-windows)
(global-set-key (kbd "s-<space>") 'split-window-horizontally)
(global-set-key (kbd "s-SPC") 'split-window-horizontally)
(global-set-key (kbd "s-\\") 'split-window-horizontally)
(global-set-key (kbd "s-/") 'split-window-vertically)
(global-set-key (kbd "S-s-<space>") 'split-window-vertically)
(global-set-key (kbd "S-s-SPC") 'split-window-vertically)
(global-set-key (kbd "s-<insert>") 'split-window-horizontally)
(global-set-key (kbd "s-=") 'enlarge-window-horizontally)
(global-set-key (kbd "s--")  'shrink-window-horizontally)
(global-set-key (kbd "s-+") 'enlarge-window)
(global-set-key (kbd "s-_") 'shrink-window)
(global-set-key (kbd "S-s-<insert>")  'split-window-vertically)

; Use imenu to jump to definitions in current file
(global-set-key (kbd "C-j") 'imenu)

; Use GNU Global for project global jumps
(when *want-gtags*
  (require 'gtags)
  (dolist (hook '(c-mode-hook
                  php-mode-hook
                  emacs-lisp-hook
                  lisp-mode-hook))
    (add-hook hook
              '(lambda ()
                 (gtags-mode t))))
  (global-set-key (kbd "C-S-j") 'gtags-find-tag))

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

; gitsum FTW!
; see: http://github.com/chneukirchen/gitsum
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/gitsum"))
(require 'gitsum)

; auto-complete mode
(when *want-ac*
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/auto-complete"))
  (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories (expand-file-name "~/.emacs.d/plugins/auto-complete/dict"))
  (ac-config-default)
  (define-key ac-completing-map [tab] 'ac-expand)
  (define-key ac-completing-map [escape] 'ac-stop)
  (setq ac-use-quick-help t)
  (setq ac-ignore-case t)
  (setq ac-use-fuzzy t)
  (setq ac-trigger-key nil)
  (setq ac-dwim t)
  (setq ac-auto-start nil)

  (setq-default ac-sources '(ac-source-dictionary
                             ac-source-filename
                             ac-source-gtags
                             ac-source-imenu
                             ac-source-words-in-same-mode-buffers)))

; *** MAJOR MODES ***

; send mails from mutt
(add-to-list 'auto-mode-alist '("mutt-" . mail-mode))
(add-hook 'mail-mode-hook (lambda ()
                            (turn-on-auto-fill)
                            (flush-lines "^\\(> \n\\)*> -- *\n\\(\n?> .*\\)*")
                            (not-modified)
                            (mail-text)))

; Org+Remember
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;(add-to-list 'auto-mode-alist '("/org/.*$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org"
                             "~/org/yasni"
                             "~/org/yasni/architekturmeetings"))
;(setq org-agenda-file-regexp "\\`[^.]+?\\'")
(setq org-agenda-tags-column -120)
(setq org-CUA-compatible t)
(org-remember-insinuate)
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cr" 'org-remember)
(setq org-clock-persist t)
(org-clock-persistence-insinuate)
(setq org-startup-folded nil)
(define-key global-map (kbd "<f9>") 'toggle-org-journal)
(define-key global-map (kbd "C-c j") 'toggle-org-journal)
(define-key global-map (kbd "<f12>") 'toggle-org-agenda-list)

(defun toggle-org-agenda-list ()
  "Shows or hides the org-agenda list view"
  (interactive)
  (if (and (boundp 'org-agenda-buffer-name)
           (get-buffer org-agenda-buffer-name))
      (progn
        (org-agenda-exit)
        (set-window-configuration toggle-org-agenda-list-window-config))
    (progn
      (message "Loading agenda list …")
      (setq toggle-org-agenda-list-window-config (current-window-configuration))
      (org-agenda-list))))

; Journaling:
; Taken from http://metajack.im/2009/01/01/journaling-with-emacs-orgmode/
; Modified to allow toggling.
(defvar org-journal-file "~/org/journal.org" "Path to OrgMode journal file.")
(defvar org-journal-buffer-name "*JOURNAL*" "Name of the journal buffer")
(defvar org-journal-date-format "%Y-%m-%d %A (W%W)" "Date format string for journal headings.")

(defun toggle-org-journal ()
  "Shows or hides the org-journal view"
  (interactive)
  (let ((buf (get-buffer org-journal-buffer-name)))
    (if buf
        (with-current-buffer buf
          (save-buffer)
          (kill-buffer))
      (org-journal-entry))))

(defun org-journal-entry ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (find-file org-journal-file)
  (rename-buffer org-journal-buffer-name)
  (widen)
  (let ((today (format-time-string org-journal-date-format)))
    (beginning-of-buffer)
    (unless (org-goto-local-search-headings today nil t)
      ((lambda ()
         (org-insert-heading)
         (insert today)
         (insert "\n- \n"))))
    (beginning-of-buffer)
    (hide-body)
    (org-show-entry)
    (org-narrow-to-subtree)
    (end-of-buffer)
    (while (= (line-beginning-position) (line-end-position))
      (delete-backward-char 1))
    (unless (= (current-column) 2)
      (insert "\n- ")))
    (widen))

; GNUplot
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)

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

; Don't break the signature separator!
(add-hook 'before-save-hook
          (lambda ()
            (unless (eq major-mode 'mail-mode)
              (delete-trailing-whitespace))))

;(require 'w3m-load)

; robs bufferlist
(require 'bufferlist)

; line numbering
; wget http://stud4.tuwien.ac.at/~e0225855/linum/linum.el
(autoload 'linum-mode "linum" nil t)
(autoload 'global-linum-mode "linum" nil t)

; turn on tempbuf mode for some types of buffers
; cd ~/.emacs.d/plugins && wget http://www.emacswiki.org/emacs/download/tempbuf.el
(require 'tempbuf)
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'w3-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'Man-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'WoMan-mode-hook 'turn-on-tempbuf-mode)

; whitespace-mode
(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])
        (space-mark 160 [164] [95])
        (space-mark 2208 [2212] [95])
        (space-mark 2336 [2340] [95])
        (space-mark 3616 [3620] [95])
        (space-mark 3872 [3876] [95])
        (newline-mark 10 [8629 10])
        (tab-mark 9 [9654 9] [92 9])))

(global-set-key [f1] 'whitespace-mode)
(global-set-key (kbd "S-<f1>") 'global-whitespace-mode)
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
    (cond (*want-company* (call-interactively 'company-start-showing))
          ((and *want-ac* auto-complete-mode) (call-interactively 'auto-complete))
          (t (call-interactively 'hippie-expand)))))

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
  (global-set-key (kbd "C-,") '(lambda () (interactive) (bm-try-jump 'bm-previous)))
  (global-set-key (kbd "C-.") '(lambda () (interactive) (bm-try-jump 'bm-next)))

  (defun bm-try-jump (jmpfn)
    (if (= (bm-count) 0)
        (cua-exchange-point-and-mark nil)
      (progn
        (cua--deactivate)
        (funcall jmpfn))))

  (defun bm-mouse-toggle (event)
    (interactive "e")
    (save-excursion (mouse-set-point event) (bm-toggle)))

  (global-set-key [left-margin mouse-1] 'bm-mouse-toggle)
  (global-set-key [left-fringe mouse-1] 'bm-mouse-toggle))

; fringe, scroll bars & margins
(set-fringe-mode '(8 . 2))
(set-scroll-bar-mode nil)
(set-frame-parameter nil 'internal-border-width 0)
(set-frame-parameter nil 'line-spacing 0)
(set-frame-parameter nil 'scroll-bar-width 4)
(set-default 'indicate-empty-lines t)
(set-default 'indicate-buffer-boundaries '((up . left) (down . left) (t . nil)))

; no fringe for minibuffer
(defun setup-echo-area ()
  (interactive)
  (walk-windows (lambda (w) (when (window-minibuffer-p w)
                              (set-window-fringes w 2 2 0))) t t))
(add-hook 'window-configuration-change-hook 'setup-echo-area)

; special minibuffer keys
(define-key minibuffer-local-map (kbd "C-u") '(lambda ()
                                                (interactive)
                                                (move-beginning-of-line nil)
                                                (delete-line)))
(define-key minibuffer-local-map [escape] 'abort-recursive-edit)

; mouse quits minibuffer
; from http://trey-jackson.blogspot.com/2010/04/emacs-tip-36-abort-minibuffer-when.html
(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (>= (recursion-depth) 1)
    (abort-recursive-edit)))
(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

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
(global-set-key [(control shift mouse-4)] '(lambda () (interactive) (cua--deactivate) (highlight-symbol-prev)))
(global-set-key [(control shift mouse-5)] '(lambda () (interactive) (cua--deactivate) (highlight-symbol-next)))
(global-set-key [(control shift wheel-up)] '(lambda () (interactive) (cua--deactivate) (highlight-symbol-prev)))
(global-set-key [(control shift wheel-down)] '(lambda () (interactive) (cua--deactivate) (highlight-symbol-next)))

; ruby
; cd ~/.emacs.d/plugins && svn co http://svn.ruby-lang.org/repos/ruby/trunk/misc ruby
;(add-to-list 'load-path "~/.emacs.d/plugins/ruby")
;(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
;(setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
;(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
;(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process")
;(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
;(autoload 'ruby-electric-mode "ruby-electric" "Run the electric ruby minor mode")
;(add-hook 'ruby-mode-hooku
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

; browser settings
(when (eq window-system 'x)
  (setq browse-url-generic-program "google-chrome"))
(setq browse-url-browser-function 'browse-url-generic)

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
   (define-key csharp-mode-map (kbd "<return>") 'newline-and-indent)))

(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

; load initialization stuff that should not go into github :)
(load (expand-file-name "~/.emacs.d/private.el"))

(when window-system
  (server-start))

(require 'edit-server)
(edit-server-start)

