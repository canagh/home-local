;; C-h
(global-set-key "\C-h" 'delete-backward-char)
(delete-selection-mode 1) ; delete region with C-h


;; remove noises
(setq inhibit-startup-screen t) ; use *scratch*
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)


;; encoding
(set-language-environment "Japanese")
(prefer-coding-system     'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system    'utf-8)
(set-keyboard-coding-system    'utf-8)
(set-clipboard-coding-system   'utf-8)
