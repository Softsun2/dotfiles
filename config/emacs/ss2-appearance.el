;;; Emacs Appearance

(defvar ss2-light-theme nil "Ss2's light theme.")
(defvar ss2-dark-theme nil "Ss2's dark theme.")

(defun ns-system-appearance-change-load-ss2-theme (appearance)
  "Load appropriate light/dark theme when ns-system-appearance changes."
  (if (eq appearance 'dark)
      (when ss2-dark-theme
        (load-theme ss2-dark-theme :no-confirm))
    (when ss2-light-theme
      (load-theme ss2-light-theme :no-confirm))))

;;; Font

(set-frame-font "Cousine Nerd Font") ; default font
(set-face-attribute 'default nil :height 200) ; font size = 10 * px

;;; Theme
(setq ss2-dark-theme 'modus-vivendi)
(setq ss2-light-theme 'modus-operandi)

;; "enable" my ns-system-appearance change function
(setq ns-system-appearance-change-functions
      '(ns-system-appearance-change-load-ss2-theme))

;;; Frame
;; disable top bar (MacOS, use 'undecorated otherwise)
(set-frame-parameter nil 'undecorated-round t)
(setf (alist-get 'internal-border-width default-frame-alist) 0
      (alist-get 'left-fringe default-frame-alist) 0
      (alist-get 'right-fringe default-frame-alist) 0)

;;; Window
(setq-default header-line-format " ")

(defun ss2-set-window-margins (&rest _)
  "Set left and right margins for all windows."
  (dolist (win (window-list))
    (set-window-margins win 2 2)))
(add-hook 'window-configuration-change-hook #'ss2-set-window-margins)


;;; Misc

;; disable modes
(scroll-bar-mode -1)    ; disable scroll bar
(tool-bar-mode -1)      ; disable tool bar

;; enable line numbers only when appropriate
;; (add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; (add-hook 'text-mode-hook 'display-line-numbers-mode)

;;; Provide
(provide 'ss2-appearance)
