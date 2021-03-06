;;; ~/.doom.d/+faces.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-molokai
      doom-font (font-spec :family "Hack"
                           :size    16
                           :width  'normal
                           :slant  'normal
                           :weight 'normal))

(defun mike/org-bullet-faces ()
  "set org-level styles"
  (interactive)
  (set-face-attribute 'org-level-1 nil :height 1.2)
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-1 :height 0.9)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-2 :height 0.9))
(add-hook! 'org-mode-hook 'mike/org-bullet-faces)

;; (def-package! pretty-mode
;;   :config
;;   (add-hook 'org-mode-hook 'mike/pretty/org-mode))

;; ligatures
(global-prettify-symbols-mode 1)
;; hide ligatures when the cursor is over the character
(setq prettify-symbols-unprettify-at-point t)

(defun mike/pretty/org-mode ()
  (setq prettify-symbols-alist (append prettify-symbols-alist
                                       '(("->". "→")))))
(defun mike/pretty/elisp-mode ()
  (setq prettify-symbols-alist (append prettify-symbols-alist
                                       '(("WARNING" . "⊘")))))

;; (set-face-attribute 'rainbow-delimiters-depth-4-face nil :foreground "#8b3a62")

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(BUG\\)" 1 font-lock-warning-face prepend)))))
;; BUG: This is an example of the font lock change


(add-hook! 'org-mode-hook 'mike/pretty/org-mode)
(add-hook! 'emacs-lisp-mode-hook 'mike/pretty/elisp-mode)

;; (set-face-attribute 'font-latex-math-face nil
;;                     :family "Menlo"
;;                     :width 'normal
;;                     :slant 'normal
;;                     :weight 'normal)
