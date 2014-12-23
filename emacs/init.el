;; package-el
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

;; for emacs 23 http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
; (package-refresh-contents) 初回起動時だけ実行したい 要改善

(defun package-install-with-refresh (package)
  (unless (or (assq package package-alist) (package-installed-p package))
    (package-install package)))

;; el-get
(setq el-get-dir (expand-file-name "~/.emacs.d/el-get"))
(add-to-list 'load-path (concat el-get-dir "/el-get"))
(unless (require 'el-get nil 'noerror)
  (url-retrieve
    "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
    (lambda (s)
      (end-of-buffer)
      (eval-print-last-sexp))))

(setq el-get-sources nil)
(defun el-get-source (package)
  (add-to-list 'el-get-sources package)
  (el-get 'sync (plist-get package :name)))

;; init-loader
(package-install-with-refresh 'init-loader)
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(setq vc-follow-symlinks t)
(init-loader-load "~/.emacs.d/inits")
