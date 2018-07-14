;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(map!

 :desc "Shell"                      :nvi "C-<return>"    #'+eshell/open-popup

 :desc "Hash"                       :i "M-3"             (lambda ()
                                                           (interactive)
                                                           (insert "#"))

 :desc "Dired jump"                 :nv "-"              #'dired-jump

 :desc "Forward char"               :i "M-l"             #'evil-forward-char

 (:leader

   :desc "M-x"                      :nv "SPC"            #'helm-M-x
   :desc "Previous buffer"          :nv "<tab>"          #'previous-buffer

   :desc "Avy Jump"                 :nv "j"              #'avy-goto-char-timer

   (:prefix "f"
     :desc "Find file"              :n "f"               #'helm-find-files)

   (:prefix "w"
     :desc "Close window"           :n "d"               #'evil-window-delete
     :desc "Maximize window"        :nv "m"              #'maximize-window)

   (:desc "Lisp" :prefix "e"
     :desc "Eval region"            :nv "r"              #'eval-region)

   (:prefix "b"
     :desc "Switch buffer"          :nv "b"              #'switch-to-buffer
     :desc "Kill buffer"            :n "d"               #'kill-current-buffer
     :desc "Kill buffer and window" :n "k"               #'kill-buffer-and-window))

 (:after helm
   (:map helm-map
     "C-j"                                               #'helm-next-line
     "C-k"                                               #'helm-previous-line)
   (:after helm-files
          (:map helm-generic-files-map
            :e "ESC"                                     #'helm-keyboard-quit)
          (:map helm-find-files-map
            "C-h"                                        #'helm-find-files-up-one-level
            "C-l"                                        #'helm-execute-persistent-action))))

; set mac alt key to meta
(setq mac-option-modifier 'meta)

; common lisp for emacs
(require 'cl-lib)

;; (setq helm-dash-browser-func 'browse-url-generic)
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "open")

; type the search term at top of minibuffer and split window in place
(after! helm
  (setq helm-default-display-buffer-functions nil)
  (set-popup-rule! "^\\*helm" :ignore t)
  (setq helm-split-window-inside-p t
        helm-echo-input-in-header-line t
        helm-display-header-line t
        helm-autoresize-min-height 30
        helm-autoresize-max-height 0)
  (helm-autoresize-mode t))

(add-hook! 'prog-mode-hook 'rainbow-delimiters-mode-enable)

; hide the minibuffer when in helm - not sure if this is needed?
(defun helm-hide-minibuffer-maybe ()
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                              `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))
(add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)

(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg"  "rg --color=always $*"))

(setq doom-theme 'doom-molokai
      doom-font (font-spec :family "Menlo" :size 16))

(setq ns-function-modifier 'hyper)

(defun mike/org-bullet-faces ()
  "set org-level styles"
  (interactive)
  (set-face-attribute 'org-level-1 nil :height 1.2)
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-1 :height 0.9)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-2 :height 0.9))
(add-hook 'org-mode-hook 'mike/org-bullet-faces)

(global-prettify-symbols-mode 1)
;; hide ligatures when the cursor is over the character
(setq prettify-symbols-unprettify-at-point t)
;; org-mode ligatures
(add-hook 'org-mode-hook
          (lambda ()
            (push '("->" . "→") prettify-symbols-alist)))

;; org-config
(with-eval-after-load 'org
  (add-to-list 'org-modules 'org-protocol)
  (setq org-capture-templates
        `(("t" "Todo" entry
           (file "todos.org")
           "* TODO %?\n%i\n%t")
          ("l" "A link, for reading later." entry
           (file+headline "reading.org" "Reading List")
           "* %:description\n%u\n\n%c\n\n%i"
           :empty-lines 1)
          ("p" "Protocol" entry (file+headline ,(concat org-directory "/chrome.org") "Inbox")
           "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
          ("L" "Protocol Link" entry (file+headline ,(concat org-directory "/chrome.org") "Inbox")
           "* %? [[%:link][%:description]] \nCaptured On: %U"))))
