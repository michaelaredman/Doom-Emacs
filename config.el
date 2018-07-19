;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(add-to-list 'load-path "~/.doom.d/")
(load "+general_functions")
(load "+faces")
(load "+search")
(load "+org")


;; keymaps
(map!

 :desc "Shell"                      :nvi "C-<return>"    #'+eshell/open-popup

 :desc "Hash"                       :i "M-3"             (lambda ()
                                                           (interactive)
                                                           (insert "#"))

 :desc "Dired jump"                 :nv "-"              #'dired-jump

 :desc "Forward char"               :i "M-l"             #'evil-forward-char

 :desc "Kill ring"                  :inv "M-i"           #'helm-show-kill-ring

 :desc "Swoop all buffers"          :n "/"               #'helm-multi-swoop-all

 :desc "Help!"                      "M-h"                #'help-for-help

 (:leader

   :desc "M-x"                      :nv "SPC"            #'helm-M-x
   :desc "Previous buffer"          :nv "<tab>"          #'mike/alternate-buffer

   :desc "Avy Jump"                 :nv "j"              #'avy-goto-char-timer

   (:prefix "f"
     :desc "Find file"              :n "f"               #'helm-find-files)

   (:prefix "w"
     :desc "Close window"           :n "d"               #'evil-window-delete
     :desc "Maximize window"        :nv "m"              #'maximize-window)

   (:desc "Lisp" :prefix "e"
     :desc "Eval region"            :nv "r"              #'eval-region)

   (:desc "General" :prefix "k"
     :desc "Calc"                   :nv "c"              #'helm-calcul-expression
     (:desc "Whitespace" :prefix "w"
       :desc "Whitespace report"    :nv "r"              #'whitespace-report
       :desc "Whitespace cleanup"   :nv "c"              #'whitespace-cleanup))

   (:prefix "/"
     :desc "Swoop multi"            :nv "/"              #'helm-multi-swoop
     :desc "Man page"               :nv "m"              #'helm-man-woman
     :desc "Helm top"               :nv "t"              #'helm-top)

   (:prefix "b"
     :desc "Switch buffer"          :nv "b"              #'helm-mini
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

;; use rainbow delimiters in all programming modes
(add-hook! 'prog-mode-hook 'rainbow-delimiters-mode-enable)

(setq text-scale-mode-step 1.05)

;; shell config
(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg"  "rg --color=always $*"))

;; set mac function key to hyper
(setq ns-function-modifier 'hyper)

;; add user snippets folder
(setq yas-snippet-dirs '(+snippets-dir emacs-snippets-dir +file-templates-dir "/Users/Mike/.doom.d/snippets/"))

