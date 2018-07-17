;;; ~/.doom.d/+faces.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-molokai
      doom-font (font-spec :family "Menlo" :size 16))

(defun mike/org-bullet-faces ()
  "set org-level styles"
  (interactive)
  (set-face-attribute 'org-level-1 nil :height 1.2)
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-1 :height 0.9)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-2 :height 0.9))
(add-hook! 'org-mode-hook 'mike/org-bullet-faces)

;; ligatures
(global-prettify-symbols-mode 1)
;; hide ligatures when the cursor is over the character
(setq prettify-symbols-unprettify-at-point t)
