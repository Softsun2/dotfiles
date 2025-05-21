(use-package magit
  :ensure nil
  :bind
  ("C-c g s" . magit)
  ("C-c g b" . magit-branch)
  ("C-c g l" . magit-log))


(provide 'ss2-magit)
