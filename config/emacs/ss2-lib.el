;;; Ss2 Lib


;; Variables


;; Functions


;; Commands

(defun ss2-edit-init ()
  "Opens ss2's init.el file."
  (interactive)
  (find-file "~/.dotfiles/config/emacs/ss2-init.el"))
(defun ss2-open-emacs-dir ()
  "Opens ss2's configuration directory."
  (interactive)
  (find-file "~/.dotfiles/config/emacs/"))
(defun ss2-open-dotfiles-dir ()
  "Opens ss2's dotfiles directory."
  (interactive)
  (find-file "~/.dotfiles/"))
(defun ss2-repos ()
  "Opens ss2's repo directory."
  (interactive)
  (find-file "~/softsun2/dev/personal"))
(defun ss2-lumea ()
  "Opens ss2's lumea repo."
  (interactive)
  (find-file "~/softsun2/dev/personal/lumea"))

(provide 'ss2-lib)
