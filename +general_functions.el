;;; ~/.doom.d/+general_functions.el -*- lexical-binding: t; -*-

;; functions for inserting the value of an elisp variable into the buffer
(defun mike/lisp/insert-var-value (var-name)
  (interactive "variable name:")
  (save-excursion
    (insert (format "%S" (symbol-value var-name)))
    (backward-char)
    (sp-splice-sexp)))
(defun mike/lisp/insert-var-sexp (var-name)
  (interactive "variable name:")
  (save-excursion
    (insert (format "%S" (symbol-value var-name)))))

;; disable all currently appplied themes
(defun mike/disable-all-themes ()
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

;; taken directly from spacemacs
(defun mike/alternate-buffer (&optional window)
  "Switch back and forth between current and last buffer in the
current window."
  (interactive)
  (let ((current-buffer (window-buffer window)))
    ;; if no window is found in the windows history, `switch-to-buffer' will
    ;; default to calling `other-buffer'.
    (switch-to-buffer
     (cl-find-if (lambda (buffer)
                   (not (eq buffer current-buffer)))
                 (mapcar #'car (window-prev-buffers window))))))
