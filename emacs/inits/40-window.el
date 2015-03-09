(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))

(if window-system (set-alpha 90))
(if window-system (load-theme 'misterioso t))
