;;; Modus Themes

(use-package modus-themes
  :ensure nil
  :custom
  modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted)
  :config
  (custom-set-faces
   '(mode-line ((t :box (:style released-button)))))
  
  ;; Load the theme of your choice.
  (load-theme 'modus-operandi-tinted t)
  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

(provide 'ss2-modus-themes)
