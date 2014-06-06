(defadvice coq-mode-config (after deactivate-holes-mode () activate)
           "Deactivate holes-mode when coq-mode is activated."
           (progn (holes-mode 0)))
(add-hook 'proof-mode-hook
          '(lambda ()
             (define-key proof-mode-map (kbd "C-c C-j") 'proof-goto-point)))
