;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(add-to-list 'load-path "~/.doom.d/")
(load "+general_functions")
(load "+faces")
(load "+search")
(load "+org")
(load "+bindings")
(load "+prog")

; set mac alt key to meta
(setq mac-option-modifier 'meta)

; common lisp for emacs
(require 'cl-lib)

;; set text change increment for S-=/S--
(setq text-scale-mode-step 1.05)

;; shell config
(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gr"  "ls -lahtr | rg $1"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg"  "rg --color=always $*"))

;; set mac function key to hyper
(setq ns-function-modifier 'hyper)

;; add user snippets folder
(setq yas-snippet-dirs '(+snippets-dir emacs-snippets-dir +file-templates-dir "/Users/Mike/.doom.d/snippets/"))

(setq dired-listing-switches "-lha")

(setq +doom-modeline-height 35)
