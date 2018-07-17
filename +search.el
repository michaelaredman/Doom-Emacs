;;; ~/.doom.d/+search.el -*- lexical-binding: t; -*-

;; helm config

; type the search term at top of minibuffer and split window in place
(after! helm
  (setq helm-default-display-buffer-functions nil)
  (set-popup-rule! "^\\*helm" :ignore t)
  (setq helm-split-window-inside-p t
        helm-echo-input-in-header-line t
        helm-display-header-line t
        helm-autoresize-min-height 30
        helm-autoresize-max-height 0)
  (helm-autoresize-mode t)
  (add-hook! 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe))

; hide the minibuffer when in helm - not sure if this is needed?
(defun helm-hide-minibuffer-maybe ()
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                              `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))
