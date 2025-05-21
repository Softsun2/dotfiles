(use-package org-roam
  :ensure nil
  :custom
  (org-roam-directory "~/softsun2/writing/org-roam")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-directory "journal/")  ; relative to the org-roam dir
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
   ("C-c n f" . org-roam-node-find)
   ("C-c n i" . org-roam-node-insert)
   :map org-mode-map
   ("C-M-i" . completion-at-point)
   :map org-roam-dailies-map
   ("Y" . org-roam-dailies-capture-yesterday)
   ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-setup))

(provide 'ss2-org-roam)
