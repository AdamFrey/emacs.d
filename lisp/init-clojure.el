;; Basic clojure support, even in Emacs 23
;; See also init-clojure-cider.el

(require-package 'clojure-mode)
(require-package 'cljsbuild-mode)
(require-package 'elein)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc clojure tweaks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after-load 'clojure-mode
  (add-hook 'clojure-mode-hook 'sanityinc/lisp-setup)
  (add-hook 'clojure-mode-hook 'subword-mode))

(add-auto-mode 'clojure-mode "\\.boot\\'" "\\.pxi\\'")

;;;;;;;;;;;;;;;;;;
;; clj-refactor ;;
;;;;;;;;;;;;;;;;;;

(require-package 'clj-refactor)

(defun my-clojure-mode-hook ()
  (setq clojure-defun-style-default-indent t)
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(provide 'init-clojure)
