;;; LSP Configuration

;;; Language Modes
(use-package nix-mode :ensure nil :mode "\\.nix\\'")
(use-package haskell-mode :ensure nil)
;; (use-package tuareg :ensure nil)


;;; LSP
(use-package eglot
  :ensure nil
  :hook
  (nix-mode . eglot-ensure)
  (python-mode . eglot-ensure)
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (haskell-mode . eglot-ensure)
  ;; (tuareg-mode . eglot-ensure)
  :bind
  ("C-c [ e" . flymake-goto-next-error)
  ("C-c ] e" . flymake-goto-prev-error)
  ("C-c q e" . flymake-show-project-diagnostics)
  ("C-c l a" . eglot-code-actions)
  ("C-c r" . eglot-rename)
  ("C-c f" . eglot-format)
  
  :config
  ;; explicitly declare which language servers to use
  ;; https://github.com/joaotavora/eglot/blob/master/eglot.el
  (setq eglot-server-programs '())

  (add-to-list 'eglot-server-programs
	       '(nix-mode . ("rnix-lsp")))
  
  (add-to-list 'eglot-server-programs
	       '((python-mode python-ts-mode) .
		 ("pyright-langserver" "--stdio")))
  
  (add-to-list 'eglot-server-programs
	       '((c-mode c-ts-mode c++-mode c++-ts-mode) . ("ccls" "-log-file=/tmp/ccls.log" "-v=1")))

  (add-to-list 'eglot-server-programs
	       '((haskell-mode) .
		 ("haskell-language-server-wrapper" "--lsp" "-l" "/tmp/hls.out"
		  :initializationOptions (:haskell (:formattingProvider "floskell")))))
  
  ;; (add-to-list 'eglot-server-programs
  ;; 	       '(tuareg-mode . ("ocamllsp")))

  (add-to-list 'eglot-server-programs
	       '((fortran-mode f90-mode) . ("fortls" "--notify_init"))))

(provide 'ss2-lsp)
