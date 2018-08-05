;;; ~/.doom.d/+prog.el -*- lexical-binding: t; -*-

;; use rainbow delimiters in all programming modes
(add-hook! 'prog-mode-hook 'rainbow-delimiters-mode-enable)

(add-hook! 'c++-mode-hook 'mike/c++-hooks)

(defun mike/c++-hooks ()
  (setq c-basic-offset 4))
