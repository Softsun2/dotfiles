;;; grammar checking via langtool

(use-package langtool
  :ensure nil
  :custom
  (langtool-java-bin ss2-languagetool-java-bin)
  (langtool-language-tool-jar ss2-languagetool-cli))

(provide 'ss2-langtool)
