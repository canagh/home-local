(custom-set-variables '(proof-three-window-mode-policy (quote hybrid)))
(custom-set-variables '(coq-load-path-include-current t))
(use-package proof-site
  :config
  (evil-define-key 'normal proof-mode-map (kbd "M-n")   'proof-assert-next-command-interactive)
  (evil-define-key 'normal proof-mode-map (kbd "C-M-j") 'proof-goto-point)
  (evil-define-key 'normal proof-mode-map (kbd "M-p")   'proof-undo-last-successful-command))
