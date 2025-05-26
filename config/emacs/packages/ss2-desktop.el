;;; desktop mode config

;; Used to save sessions
(use-package desktop
  :ensure nil
  :init
  (defun ss2-desktop-save ()
    (interactive)
    (desktop-save (read-directory-name "Save directory: ")))
  (defun ss2-desktop-load-vmae ()
    (interactive)
    (desktop-read "~/softsun2/git/vmae"))
  :custom
  (desktop-restore-frames nil) ; use current instances' frame paramters
  :bind
  ;; "s" for session ("d' is used for direnv)
  ("C-c s s" . 'ss2-desktop-save)
  ("C-c s v" . 'ss2-desktop-load-vmae))

(provide 'ss2-desktop)
