(provide 'bufferlist)

(defvar bufferlist-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [f3] 'bufferlist-quit)
    (define-key map [escape] 'bufferlist-quit)
    (define-key map [return] 'bufferlist-activate-buffer)
    (define-key map "\r" 'bufferlist-activate-buffer)
    (define-key map [delete] 'bufferlist-kill-buffer)
    (define-key map [deletechar] 'bufferlist-kill-buffer)
    (define-key map [kp-delete] 'bufferlist-kill-buffer)
    (define-key map [backspace] 'bufferlist-kill-buffer)
    (define-key map [up] 'bufferlist-move-up)
    (define-key map [down] 'bufferlist-move-down)
    (define-key map [home] 'bufferlist-move-to-top)
    (define-key map [end] 'bufferlist-move-to-bottom)
    (define-key map [prior] 'bufferlist-move-page-up)
    (define-key map [next] 'bufferlist-move-page-down)
    (define-key map [mouse-wheel-up] 'bufferlist-move-up)
    (define-key map [mouse-wheel-down] 'bufferlist-move-down)
    (define-key map [mouse-4] 'bufferlist-move-up)
    (define-key map [mouse-5] 'bufferlist-move-down)
    (define-key map [wheel-up] 'bufferlist-move-up)
    (define-key map [wheel-down] 'bufferlist-move-down)
    (define-key map (kbd "C-a") 'bufferlist-move-to-top)
    (define-key map (kbd "C-e") 'bufferlist-move-to-bottom)
    map))

(defun bufferlist-quit ()
  ""
  (interactive)
  (when bufferlist-global-hl-line-mode
    (global-hl-line-mode 1))
  (kill-buffer-and-window)
  (set-window-configuration bufferlist-window-config))

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
  (with-current-buffer (get-buffer-create "BUFFERLIST")
    (setq buffer-read-only nil)
    (let ((rest (- (window-height) (count-lines (window-start) (window-end)))))
      (setq mark (point))
      (goto-char (point-max))
      (dotimes (_ rest) (insert "\n"))
      (goto-char mark))
    (set-text-properties (point-min) (point-max)
                         '(face '((:weight ultra-light)
                                  (foreground-color . "#333333")
                                  (background-color . "#ccccff"))))
    (put-text-property (point) (1+ (point-at-eol))
                       'face '((:weight bold)
                               (foreground-color . "#ffffff")
                               (background-color . "#ff0000")))
    (setq buffer-read-only t)))

(defun bufferlist-move-up (count)
  (interactive "P")
  (dotimes (_ (if count count 1))
    (goto-char (point-at-bol 0)))
  (bufferlist-style-buffer))

(defun bufferlist-move-down (count)
  (interactive "P")
  (goto-char (point-at-bol (1+ (if count count 1))))
  (while (= (line-end-position) (line-beginning-position))
    (goto-char (point-at-bol 0)))
  (bufferlist-style-buffer))

(defun bufferlist-move-page-up ()
  (interactive)
  (bufferlist-move-up 10))

(defun bufferlist-move-page-down ()
  (interactive)
  (bufferlist-move-down 10))

(defun bufferlist-move-to-top ()
  (interactive)
  (goto-char 0)
  (bufferlist-style-buffer))

(defun bufferlist-move-to-bottom ()
  (interactive)
  (goto-char (point-at-bol (point-max)))
  (while (= (line-end-position) (line-beginning-position))
    (goto-char (point-at-bol 0)))
  (bufferlist-style-buffer))

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
    (setq mode-line-format nil)
    (setq cursor-type nil)              ; Does not seem to be working in the terminal.
                                        ; Using (internal-show-cursor ... nil) is too hazardous, though.
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
    (goto-char mark)

    (setq major-mode 'bufferlist-mode)
    (setq mode-name "BUFFERLIST")
    (use-local-map bufferlist-mode-map)
    (add-hook 'window-configuration-change-hook 'bufferlist-style-buffer 0 t)
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (switch-to-buffer (current-buffer))
    (set-window-fringes nil 0 0 0)))

(defun bufferlist ()
  "erstellt eine bufferlist aehnlich der, die ich fuer vim gebaut habe "
  (interactive)
  (setq bufferlist-window-config (current-window-configuration))
  ; temporarily turn off global hl-line-mode
  (if global-hl-line-mode
    (progn
      (setq bufferlist-global-hl-line-mode t)
      (global-hl-line-mode -1))
    (setq bufferlist-global-hl-line-mode nil))
  (split-window-horizontally 30)
  (bufferlist-load-buffers (current-buffer)))
