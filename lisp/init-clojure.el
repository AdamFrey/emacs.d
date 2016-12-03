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



;;;;;;;;;;;;;;;;;;
;; clj-refactor ;;
;;;;;;;;;;;;;;;;;;

(require-package 'clj-refactor)

(defun my-clojure-mode-hook ()
  (setq clojure-defun-style-default-indent t)
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-r")

  (define-clojure-indent
    (or 0)
    (and 0)
    (= 0)))

(with-eval-after-load 'clj-refactor
  (setq cljr-thread-all-but-last nil)
  (setq cljr-auto-sort-ns t)
  (define-key clj-refactor-map "\C-ctf" #'cljr-thread-first-all)
  (define-key clj-refactor-map "\C-ctl" #'cljr-thread-last-all)
  (define-key clj-refactor-map "\C-cu" #'cljr-unwind)
  (define-key clj-refactor-map "\C-cU" #'cljr-unwind-all)

  (add-to-list 'cljr-magic-require-namespaces
               '("d"  . "datomic.api"))
  (add-to-list 'cljr-magic-require-namespaces
               '("pp"  . "clojure.pprint"))

  (setq cljr-favor-prefix-notation nil)
  (setq cljr-favor-private-functions nil)
  (setq cljr-clojure-test-declaration
        "[clojure.test :refer :all]"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(provide 'init-clojure)
