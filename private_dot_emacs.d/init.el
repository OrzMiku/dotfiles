;; -*- lexical-binding: t; -*-

;; custom
(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)

;; package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; ui
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(load-theme 'modus-vivendi t)
(column-number-mode 1)

;; editing
(electric-pair-mode 1)
(show-paren-mode 1)
(delete-selection-mode 1)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(setq-default indent-tabs-mode nil)

;; history
(savehist-mode 1)
(save-place-mode 1)
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; convenience
(which-key-mode 1)
(global-auto-revert-mode 1)
(setq use-short-answers t)

;; magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))


