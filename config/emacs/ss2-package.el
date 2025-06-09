;; Package configuration

(add-to-list 'load-path "~/.dotfiles/config/emacs/packages")

(require 'use-package)
;; use package reminder:
;; init: executed before package is loaded
;; config: executed after package is loaded (even if deferred)
;; custom: customize user options, some have side effects that won't run if set with setq in ~:config~

(require 'ss2-org)
(require 'ss2-org-roam)
;; (require 'ss2-company)
(require 'ss2-eww)
;; (require 'ss2-expand-region)
(require 'ss2-direnv)
(require 'ss2-magit)
(require 'ss2-desktop)

(provide 'ss2-package)
