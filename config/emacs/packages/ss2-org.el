;;; org mode config

;; this would be nice if it were literate to describe my workflow
;; helpful commands:

(use-package org
  :ensure nil
  :config
  (defun org-capture-inbox ()
    (interactive)
    (call-interactively 'org-store-link)
    (org-capture nil "i"))
  :custom
  (org-directory "~/softsun2/org")
  
  (org-agenda-files (list "inbox.org"
			  "agenda.org"
			  "projects.org"))
  
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
  
  (org-agenda-hide-tags-regexp ".")
  (org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " ")
        (tags   . " %i %-12:c")
        (search . " %i %-12:c")))
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")))
  
  (org-refile-targets `(("projects.org"
			 :regexp . ,(regexp-opt '("Tasks" "Notes")))
			("agenda.org" :maxlevel . 3)))
  
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  
  ;; date tree is helpful for journaling
  :bind
  ("C-c a" . 'org-agenda)
  ("C-c c" . 'org-capture)
  ("C-c i" . 'org-capture-inbox))

(provide 'ss2-org)
