(provide 'bufferlist)

(defvar bufferlist-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [f3] 'kill-buffer-and-window)
    (define-key map [return] 'bufferlist-activate-buffer)
    (define-key map [delete] 'bufferlist-kill-buffer)
    (define-key map [deletechar] 'bufferlist-kill-buffer)
    (define-key map [kp-delete] 'bufferlist-kill-buffer)
    (define-key map [backspace] 'bufferlist-kill-buffer)
    (define-key map [up] 'bufferlist-move-up)
    (define-key map [down] 'bufferlist-move-down)
    map))

(defun bufferlist-quit ()
  (when bufferlist-global-hl-line-mode
    (global-hl-line-mode 1))
  ;(delete-overlay bufferlist-background)
  (kill-buffer-and-window)
)

(defun bufferlist-activate-buffer ()
  ""
  (interactive)
  (let* ((bufinfo (nth (+ -1 (line-number-at-pos)) bufferlist-list))
        (name (nth 1 bufinfo))
        (buf (nth 0 bufinfo)))
    (message "Switching to %s" name)
    (bufferlist-quit)
    (switch-to-buffer buf)))

(defun bufferlist-kill-buffer ()
  ""
  (interactive)
  (let* ((bufinfo (nth (+ -1 (line-number-at-pos)) bufferlist-list))
        (name (nth 1 bufinfo))
        (buf (nth 0 bufinfo)))
    (message "Killing %s" name)
    (kill-buffer buf)
    (bufferlist-load-buffers)))


(defun bufferlist-style-buffer ()
  (setq buffer-read-only nil)
  ;(unless bufferlist-background
  ;  (progn
  ;    (setq bufferlist-background
  ;          (make-overlay (point-min) (point-max) nil nil t))
  ;    (overlay-put bufferlist-background 'face
  ;                 (list :background "#ffff00"))))
  (set-text-properties (point-min) (point-max)
                       '(face '((:weight ultra-light)
                                (foreground-color . "#000000")
                                (background-color . "#00ffff"))))
  (put-text-property (point) (1+ (point-at-eol))
                     'face '((:weight bold) (:box 1)
                             (foreground-color . "#ffffff")
                             (background-color . "#ff0000")))
  (setq buffer-read-only t)
)

(defun bufferlist-move-up ()
  (interactive)
  (goto-char (point-at-bol 0))
  (bufferlist-style-buffer)
)

(defun bufferlist-move-down ()
  (interactive)
  (goto-char (point-at-bol 2))
  (when (= (point) (point-max))
    (goto-char (point-at-bol 0)))
  (bufferlist-style-buffer)
)

(defun bufferlist-load-buffers (&optional active-buffer)
  (setq bufferlist-list '())
                                        ; buffer-liste holen
  (dolist (b (buffer-list))
    (with-current-buffer b
      (let ((name (buffer-name))
            (file buffer-file-name))
        (unless (and (null file)
                     (or (string= "BUFFERLIST" name)
                         (string= (substring name 0 1) " ")))
          (push (list b name file (buffer-modified-p))
                bufferlist-list)))))
                                        ; nach namen sortieren
  (setq bufferlist-list
        (sort bufferlist-list (lambda (a b) (string< (nth 1 a) (nth 1 b)))))

  (with-current-buffer (get-buffer-create "BUFFERLIST")
    (setq buffer-read-only nil)
    (erase-buffer)
    (goto-char (point-min))
                                        ; hier schon mal mark setzen, falls es spaeter
                                        ; nicht gesetzt wird.
    (setq mark (point-min))
    (dolist (e bufferlist-list)
      (insert (with-output-to-string
                (when (and active-buffer
                           (eq (nth 0 e) active-buffer))
                  (setq mark (point)))
                (princ " ")
                (princ (nth 1 e))
                (when (nth 3 e)
                  (princ "+"))
                (when (and active-buffer
                           (eq (nth 0 e) active-buffer))
                  (princ "*"))
                (princ "\n"))))
    (setq major-mode 'bufferlist-mode)
    (setq mode-name "BUFFERLIST")
    (use-local-map bufferlist-mode-map)
                                        ;(setq bufferlist-list list)
    (goto-char mark)
    (bufferlist-style-buffer)
                                        ;(defface bufferlist-selected '((t :background "#ff0000" :foreground "white")) nil)
                                        ;(setq font-lock-keywords nil)
                                        ;(setq font-lock-defaults '('(("^>.*$" . bufferlist-selected))
                                        ;                           ("\\*.*\\*" . font-lock-comment-face)))
                                        ;(font-lock-fontify-buffer)
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (switch-to-buffer (current-buffer))))

(defun bufferlist ()
  "erstellt eine bufferlist aehnlich der, die ich fuer vim gebaut habe "
  (interactive)
  (setq bufferlist-background nil)
  ; temporarily turn off global hl-line-mode
  (when global-hl-line-mode
    (setq bufferlist-global-hl-line-mode t)
    (global-hl-line-mode -1))
  (split-window-horizontally 30)
  (bufferlist-load-buffers (current-buffer)))
