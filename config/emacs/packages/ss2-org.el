;;; org mode config

(use-package org
  :ensure nil
  :custom
  (add-to-list 'org-modules 'org-habit)
  (org-directory "~/softsun2/org")
  (org-agenda-files (list "inbox.org"
			  "agenda.org"
			  "projects.org"))
  ;; habits
  (org-log-into-drawer t)
  (org-habit-graph-column 40)
  (org-habit-show-habits t)

  (org-capture-templates
   `(("i" "Inbox" entry (file "inbox.org")
      ,(concat "* TODO %?\n"
	       "/Entered on/ %U")
      :prepend t)
     ("n" "Note" entry (file "inbox.org")
      ,(concat "* Note (%a)\n"
	       "/Entered on/ %U\n"
	       "\n%?")
      :prepend t)))

  (org-agenda-window-setup 'current-window)
  (org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " ")
        (tags   . " %i %-12:c")
        (search . " %i %-12:c")))

  (org-todo-keywords '((sequence "TODO(t)" "PROG(p)" "|" "DONE(d)" "FAILED(f)")))
  (org-todo-keyword-faces
   '(("FAILED" . (:foreground "red" :weight bold))))
  
  (org-refile-targets `(("projects.org"
			 :regexp . ,(regexp-opt '("Tasks" "Notes" "Subtasks")))
			("agenda.org" :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  
  ;; date tree is helpful for journaling
  :bind
  ("C-c a" . 'org-agenda)
  ("C-c c" . 'org-capture))

(provide 'ss2-org)
