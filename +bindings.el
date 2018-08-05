;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

;; keymaps
(map!

 :desc "Shell"                      :nvi "C-<return>"    #'+eshell/open-popup

 :desc "Fullscreen shell"           :nvi "C-M-<return>"  #'+eshell/open-fullscreen

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
     :desc "Kill buffer and window" :n "k"               #'kill-buffer-and-window
     :desc "Messages buffer"        :nv "m"              (lambda ()
                                                           (interactive)
                                                           (switch-to-buffer "*Messages*"))))

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

;; BUG (emacs): eshell-mode-map is nil outside of eshell-mode so keys must be bound outside map!
(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "<C-backspace>") #'+eshell/kill-and-close)))
