;;; Emacs Appearance


;;; Font
(set-frame-font "Cousine Nerd Font") ; default font
(set-face-attribute 'default nil :height 200) ; font size = 10 * px

;;; Theme
(defvar ss2-light-theme 'modus-operandi
  "Ss2's light theme.")
(defvar ss2-dark-theme 'modus-vivendi
  "Ss2's dark theme.")
(defun ss2-ns-system-appearance-change-load-theme (appearance)
  "Load appropriate light/dark theme when ns-system-appearance changes."
  (if (eq appearance 'dark)
      (when ss2-dark-theme
        (load-theme ss2-dark-theme :no-confirm))
    (when ss2-light-theme
      (load-theme ss2-light-theme :no-confirm))))
(setq-default ns-system-appearance-change-functions
      '(ss2-ns-system-appearance-change-load-theme))

;;; Frame
(setf (alist-get 'undecorated-round default-frame-alist) t
      (alist-get 'internal-border-width default-frame-alist) 0
      (alist-get 'left-fringe default-frame-alist) 24
      (alist-get 'right-fringe default-frame-alist) 24)
(custom-set-faces
 '(fringe ((t (:background unspecified)))))

;;; Window
(setq-default header-line-format "")

;;; Startup
(setq-default
 inhibit-startup-screen t
 initial-buffer-choice t)

;;; Misc.
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq-default truncate-lines t) ; may only want this when editing text
(defun ss2-show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'ss2-show-trailing-whitespace)
(add-hook 'text-mode-hook 'ss2-show-trailing-whitespace)

;;; Provide
(provide 'ss2-appearance)
