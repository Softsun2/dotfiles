;; Project initialization commands

(defvar ss2-projects
  ("vmae")
  ("dotfiles"))

(defun ss2-vmae ()
  "Opens ss2's vmae project."
  (interactive)
  (find-file "~/softsun2/dev/personal/vmae/"))

(provide ss2-projects)
