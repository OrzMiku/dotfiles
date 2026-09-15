(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

(setopt inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(load-theme 'modus-vivendi t)
(set-face-attribute 'default nil :font "Maple Mono NF-12")

(electric-pair-mode 1)
(global-auto-revert-mode 1)
(show-paren-mode 1)
(fido-mode 1)

(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package org
  :bind ("C-c a" . org-agenda)
  :config
  (setq org-directory "~/Documents/org")
  (setq org-agenda-files  '("~/Documents/org/tasks.org"))
  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)")
	  (sequence "|" "CANCELED(c)"))))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

