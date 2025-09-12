;; I will update this once the actual package is available.  For now,
;; you have to clone the Git repository somewhere, then specify that
;; in the `:load-path' below.
(use-package doric-themes
  :ensure nil
  :demand t
  :load-path "~/.dotfiles/config/emacs/packages/doric-themes"
  :config
  (setq doric-themes-to-toggle '(doric-light doric-dark)))

(provide 'ss2-doric-themes)
