;;; Ss2 shell

(setq-default explicit-shell-file-name
	      "/run/current-system/sw/bin/bash")
(setq explicit-bash.exe-args '("--login" "-i"))

(provide 'ss2-shell)
