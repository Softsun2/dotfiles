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

(use-package ef-themes :ensure nil)

;; (setq ss2-light-theme 'ef-day)
;; (setq ss2-dark-theme 'ef-autumn)
(setq ss2-light-theme 'modus-operandi)
(setq ss2-dark-theme 'modus-vivendi)

;; "enable" my ns-system-appearance change function
(setq ns-system-appearance-change-functions
      '(ns-system-appearance-change-load-ss2-theme))

;;; Frame

;; disable top bar (MacOS, use 'undecorated otherwise)
(set-frame-parameter nil 'undecorated-round t)
(add-to-list 'default-frame-alist '(internal-border-width . 12)) ; set padding

;;; Misc

;; enable modes
(column-number-mode 1)

;; disable modes
(scroll-bar-mode -1)    ; disable scroll bar
(tool-bar-mode -1)      ; disable tool bar

;; enable line numbers only when appropriate
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

;;; Provide
(provide 'ss2-appearance)
