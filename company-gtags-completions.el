(require 'company-mode)
(require 'gtags)
(require 'company-bundled-completions)

;;; gtags ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; adapted version from gtags.el
(defun gtags-completion-list (prefix)
  (let ((option "-c")
	(prev-buffer (current-buffer))
	(all-expansions nil)
	expansion)
    ; build completion list
    (set-buffer (generate-new-buffer "*Completions*"))
    ;(setq option (concat option "s")))
    (call-process "global" nil t nil option prefix)
    (goto-char (point-min))
    (while (looking-at gtags-symbol-regexp)
      (setq expansion (gtags-match-string 0))
      (setq all-expansions (cons expansion all-expansions))
    (forward-line))
    (kill-buffer (current-buffer))
    ; recover current buffer
    (set-buffer prev-buffer)
    all-expansions)
  )

(defun company-gtags-completion-func (prefix)
    (gtags-completion-list prefix)
  )

(defun company-grab-gtags-prefix ()
  (or (thing-at-point 'symbol) "")
  )

(defun company-install-gtags-completions ()
  (dolist (mode '(c++-mode c-mode php-mode))
    (company-add-completion-rule
     mode
     'company-grab-gtags-prefix
     'company-gtags-completion-func)))

(provide 'company-gtags-completions)
