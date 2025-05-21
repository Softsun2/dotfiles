;;; emacs direnv config

(use-package direnv
  :ensure nil
  :bind
  ("C-c d u" . direnv-update-directory-environment)
  ("C-c d a" . direnv-allow))

(provide 'ss2-direnv)
