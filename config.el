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

;; use rainbow delimiters in all programming modes
(add-hook! 'prog-mode-hook 'rainbow-delimiters-mode-enable)

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

