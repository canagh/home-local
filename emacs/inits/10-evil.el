(use-package evil :ensure t
             :config
             (evil-mode 1))

(use-package surround :ensure t
             :config
             (global-surround-mode 1))

(use-package evil-paredit :ensure t
             :config
             (add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode))

(evil-define-key nil evil-normal-state-map (kbd ";") 'evil-ex)
(evil-define-key nil evil-normal-state-map (kbd ":") 'evil-repeat-find-char)
(evil-define-key 'normal global-map (kbd "C-z") 'suspend-frame)
