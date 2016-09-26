(require 'init-clojure)

(when (maybe-require-package 'cider)
  (setq nrepl-popup-stacktraces nil)

  (after-load 'cider
    (add-hook 'cider-mode-hook 'eldoc-mode)
    (add-hook 'cider-repl-mode-hook 'subword-mode)
    (add-hook 'cider-repl-mode-hook 'paredit-mode)
    ;; nrepl isn't based on comint
    (add-hook 'cider-repl-mode-hook 'sanityinc/no-trailing-whitespace)))

(setq cider-repl-use-pretty-printing t
      cider-repl-display-help-banner nil)

;; (after-load 'cider
;;   ;; (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
;;   ;; (add-hook 'cider-mode-hook 'ac-cider-setup)
;;   ;; (after-load 'auto-complete
;;   ;;   (add-to-list 'ac-modes 'cider-mode)
;;   ;;   (add-to-list 'ac-modes 'cider-repl-mode))

;;   ;; (add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
;;   ;; (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
;;   ;; (define-key cider-mode-map (kbd "C-c C-d") 'ac-cider-popup-doc)
;;   (define-key cider-mode-map (kbd "C-c m") 'cider-macroexpand-1)

(provide 'init-clojure-cider)
