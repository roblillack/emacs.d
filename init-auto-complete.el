(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     (expand-file-name "~/.emacs.d/auto-complete-dict"))
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
                                        ;ac-source-yasnippet
                           ac-source-words-in-same-mode-buffers))
