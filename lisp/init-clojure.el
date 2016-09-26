;; See also init-clojure-cider.el

(when (maybe-require-package 'clojure-mode)
  (require-package 'cljsbuild-mode)
  (require-package 'elein)

  (after-load 'clojure-mode
    (add-hook 'clojure-mode-hook 'sanityinc/lisp-setup)
    (add-hook 'clojure-mode-hook 'subword-mode)
    (add-hook 'clojure-mode-hook 'paredit-mode)))

(add-auto-mode 'clojure-mode "\\.boot\\'" "\\.pxi\\'")
(add-auto-mode 'clojurescript-mode "\\.cljs.hl\\'")

;; (define-clojure-indent
;;   (or 0)
;;   (and 0))

;;;;;;;;;;;;;;;;;;
;; clj-refactor ;;
;;;;;;;;;;;;;;;;;;

(require-package 'clj-refactor)

(defun my-clojure-mode-hook ()
  (setq clojure-defun-style-default-indent t)
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-r"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(provide 'init-clojure)
