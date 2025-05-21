;;; expand region config

(use-package expand-region
  :ensure nil
  :bind
  ("C-=" . er/expand-region)
  ("M-=" . er/contract-region))

(provide 'ss2-expand-region)
