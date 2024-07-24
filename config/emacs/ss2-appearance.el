;;; Emacs Appearance


;;; Variables

(defvar ss2-light-theme nil "Ss2's light theme.")
(defvar ss2-dark-theme nil "Ss2's dark theme.")

;;; Functions

(defun ns-system-appearance-change-load-ss2-theme (appearance)
  "Load appropriate light/dark theme when ns-system-appearance changes."
  (if (eq appearance 'dark)
      (when ss2-dark-theme
        (load-theme ss2-dark-theme :no-confirm))
    (when ss2-light-theme
      (load-theme ss2-light-theme :no-confirm))))

;;; Font

;; (add-to-list 'default-frame-alist '(font . "Hasklug Nerd Font"))

;;; Theme

(use-package ef-themes
  :ensure nil
  :init
  (setq ss2-light-theme 'ef-cyprus)
  (setq ss2-dark-theme 'ef-autumn)
  :bind
  (("<f5>" . ef-themes-toggle)))


;;; Visual Settigns

;; "enable" my ns-system-appearance change function
(setq ns-system-appearance-change-functions
      '(ns-system-appearance-change-load-ss2-theme))

;; enable modes
(column-number-mode 1)

;; disable modes
(scroll-bar-mode -1)    ; disable scroll bar
(tool-bar-mode -1)      ; disable tool bar

;; enable line numbers where appropriate
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

;; set global text scale
(set-face-attribute 'default nil :height 140)

;;; Provide
(provide 'ss2-appearance)
