;; install
(package-install-with-refresh 'evil)
;; enable
(require 'evil)
(evil-mode 1)


;; other plugins
(package-install-with-refresh 'surround)
(require 'surround)
(global-surround-mode 1)

(package-install-with-refresh 'evil-paredit)
(require 'evil-paredit)
(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

(el-get-source
    '(:name evil-mode-line
      :type http
      :url "https://raw.github.com/tarao/evil-plugins/master/evil-mode-line.el"))
(el-get-source
    '(:name mode-line-color
      :type http
      :url "https://raw.github.com/tarao/elisp/master/mode-line-color.el"))
(require 'evil-mode-line)

; (el-get-source
;     '(:name mode-line-color
;       :type http
;       :url "https://raw.github.com/tarao/evil-plugins/master/evil-relative-linum.el"))
; (el-get-source
;     '(:name mode-line-color
;       :type http
;       :url "https://raw.github.com/tarao/elisp/master/linum+.el"))
; (require 'evil-relative-linum)

(el-get-source
    '(:name mode-line-color
      :type http
      :url "https://raw.github.com/tarao/evil-plugins/master/evil-textobj-between.el"))
(require 'evil-textobj-between)
