;; -*- lexical-binding: t -*-

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(use-package git)

(setq user-full-name "Chris Lowis"
      user-mail-address "chris.lowis@gmail.com"
      gc-cons-threshold 50000000
      large-file-warning-threshold 100000000
      inhibit-startup-screen t
      scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
       (abbreviate-file-name (buffer-file-name))
       "%b"))))

(menu-bar-mode 1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(set-frame-font "Fira Code 18" nil t)
(global-auto-revert-mode t)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(add-hook 'before-save-hook 'whitespace-cleanup)
(setq ruby-insert-encoding-magic-comment nil)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-one-light t)
  (doom-themes-visual-bell-config))

(use-package ripgrep :straight t)
(use-package dumb-jump
  :straight t
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package flycheck
  :straight t
  :hook ((ruby-mode . flycheck-mode))
  )

(use-package smart-mode-line
  :straight t
  :config
  (setq sml/theme 'light)
  (add-hook 'after-init-hook 'sml/setup))

(use-package diminish
  :straight t)

(use-package which-key
  :straight t
  :diminish which-key-mode
  :config
  (which-key-mode +1))

(use-package magit
  :straight t)

(use-package projectile
  :straight t
  :diminish projectile-mode
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
  )

(use-package ivy
  :diminish
  :straight t
  :demand
  :config
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%d ")
  (ivy-mode 1))

(use-package vterm
  :straight t
  :if (memq window-system '(mac ns x))
  )
(use-package vterm-toggle
  :straight t
  :if (memq window-system '(mac ns x))
  :bind (:map vterm-mode-map
	      (("<f1>" . vterm-toggle))))

(use-package rspec-mode :straight t)
(use-package haml-mode :straight t)
(use-package yaml-mode :straight t)
(use-package haskell-mode :straight t)
(use-package tidal :straight f :load-path "vendor/")

(use-package markdown-mode
  :straight t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package org-roam
  :if (memq window-system '(mac ns x))
  :diminish
  :straight t
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/org/roam/")
  :bind (:map org-roam-mode-map
	      (("C-c n l" . org-roam)
	       ("C-c n f" . org-roam-find-file)
	       ("C-c n d" . org-roam-db-build-cache))
	      :map org-mode-map
	      (("C-c n i" . org-roam-insert))
	      (("C-c n I" . org-roam-insert-immediate))))

(use-package yasnippet
  :diminish
  :straight t
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

(use-package exec-path-from-shell
  :straight t
  :if (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-variables '("PATH"))
  (exec-path-from-shell-initialize))

(cond
   ((string-equal system-type "gnu/linux")
    (global-set-key (kbd "<f1>") 'eshell))
   ((string-equal system-type "darwin")
    (global-set-key (kbd "<f1>") 'vterm-toggle)))

(global-set-key (kbd "<f2>") 'dired)
(global-set-key (kbd "<f9>") 'org-roam-dailies-find-today)
(global-set-key (kbd "S-<f9>") 'org-roam-dailies-find-date)
(global-set-key (kbd "<f10>") 'magit)

(global-set-key (kbd "C-;") 'backward-kill-word)
(global-set-key (kbd "C-c c") 'comment-line)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "M-/") 'hippie-expand)

(defun my/insert-hash () (interactive) (insert "#"))
(global-set-key (kbd "s-3") #'my/insert-hash)

(require 'server)
(if (not (server-running-p)) (server-start))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default))
 '(ns-alternate-modifier 'super)
 '(ns-command-modifier 'meta)
 '(vterm-toggle-fullscreen-p t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
