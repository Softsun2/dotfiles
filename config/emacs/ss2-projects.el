(defun ss2-projects-save-desktop ()
  (interactive)
  (let ((path (read-file-name "Desktop dir: ")))
    (desktop-save path)))

(defun ss2-projects-vmae ()
  "load vmae desktop"
  (desktop-read "~/softsun2/git/personal/vmae"))

(provide 'ss2-projects)
