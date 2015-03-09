;; package-el for emacs 23
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

;; use-package
(unless (require 'use-package nil t)
  (package-refresh-contents)
  (package-install 'use-package)
  (require 'use-package))

;; init-loader
(use-package init-loader
             :ensure t
             :config
             (setq init-loader-show-log-after-init nil)
             (setq vc-follow-symlinks t)
             (init-loader-load "~/.emacs.d/inits"))
