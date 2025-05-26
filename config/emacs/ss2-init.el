;;; Emacs Configurtions

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "Loaded Emacs in %.03fs"
		     (float-time
		      (time-subtract after-init-time before-init-time)))))

(add-to-list 'load-path "~/.dotfiles/config/emacs")

(require 'ss2-lib) ; load first

(require 'ss2-package)
(require 'ss2-appearance)
(require 'ss2-lsp)
(require 'ss2-keybinds)
(require 'ss2-shell)
(require 'ss2-settings) ; load settings last
