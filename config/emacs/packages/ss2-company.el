;;; Company

(use-package company
  :hook
  ;; enable for prog and text modes only
  (prog-mode . company-mode)
  (text-mode . company-mode)
  :custom
  (company-idle-delay nil)
  (company-minimum-prefix-length 1)
  :bind
  ("C-c s" . company-complete-common))

(provide 'ss2-company)
