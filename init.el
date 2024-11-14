(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(eval-when-compile
  (require 'use-package))


;;general
(show-paren-mode 1)


;;external packages

(use-package org-journal
  :init
  (setq org-journal-dir "~/Org/journal"))

(use-package flx-ido
  :init
  ;; show any item that contains the entered characters in the given sequence
  (setq ido-enable-flex-matching t)
  ;; disable ido faces to see flx highlights
  (setq ido-use-faces nil)
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1))

(use-package smex
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))
