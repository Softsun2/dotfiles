;;; Keybinds

;; Meow (Emacs friendly modal editing)
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)               ; exchange point and mark
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)                ; move to the end of selection and insert
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)                ; kill selection and insert
   '("d" . meow-delete)
   '("D" . meow-backward-delete)       ; x with no yank
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)                  ; find next char in minibuffer
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)                  ; create a secondary selection or a marker if no region is available
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)                ; move to the beginning of selection and insert
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)                  ; similar to J in vim
   '("n" . meow-search)                ; similar to * in vim
   '("o" . meow-block)                 ; select or expand current block
   '("O" . meow-to-block)
   '("p" . meow-yank)                  ; p in vim
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)               ; replace selection with yank
   '("R" . meow-swap-grab)             ; swap region and secondary selection
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)                 ; / in vim
   '("w" . meow-mark-word)             ; mark word under cursor
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)                  ; copy
   '("Y" . meow-sync-grab)             ; sync secondary selection with current region
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore))
  (meow-define-keys 'insert
    '("C-h" . completion-at-point)))

;; (use-package meow
;;   :ensure nil
;;   :config
;;   (meow-setup)
;;   (meow-global-mode 1))
  
(provide 'ss2-keybinds)
