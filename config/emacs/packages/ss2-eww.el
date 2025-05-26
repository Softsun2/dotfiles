;;; eww config

(use-package eww
  :ensure nil
  :custom
  ;; @todo: synchronous web requests?
  (eww-auto-rename-buffer 'title))

(provide 'ss2-eww)
