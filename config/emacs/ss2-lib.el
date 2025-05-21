;;; Ss2 Lib


;; Variables


;; Functions

(defun ss2-open-emacs-dir ()
  "Opens ss2's configuration directory."
  (interactive)
  (find-file "~/.dotfiles/config/emacs/"))
(defun ss2-open-dotfiles-dir ()
  "Opens ss2's dotfiles directory."
  (interactive)
  (find-file "~/.dotfiles/"))

(provide 'ss2-lib)
