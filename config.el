;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(map!

 :desc "Shell"                      :nvi "C-RET"    #'eshell

 (:leader

   :desc "M-x"                      :nv "SPC"       #'helm-M-x
   :desc "Previous buffer"          :nv "<tab>"     #'previous-buffer

   (:prefix "f"
     :desc "Find file"              :n "f"          #'helm-find-files)

   (:prefix "b"
     :desc "Switch buffer"          :n "b"          #'helm-buffer-switch-buffers)

   (:desc "Lisp" :prefix "e"
     :desc "Eval region"            :nv "r"         #'eval-region)

   (:prefix "b"
     :desc "Kill buffer"            :n "d"          #'kill-buffer
     :desc "Kill buffer and window" :n "k"          #'kill-buffer-and-window)))

(map! :map global-map
      (set! :popup "^\\*?helm" :ignore))

(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg"  "rg --color=always $*"))

(defun mike/org-bullet-faces ()
  "set org-level styles"
  (interactive)
  (set-face-attribute 'org-level-1 nil :height 1.2)
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-1 :height 0.9)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-2 :height 0.9))
(add-hook 'org-mode-hook 'mike/org-bullet-faces)

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
