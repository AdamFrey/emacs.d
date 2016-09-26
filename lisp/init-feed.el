(require-package 'elfeed)
(require-package 'elfeed-org)

(elfeed-org)

(global-set-key (kbd "C-x w") 'elfeed)

(defun my-elfeed-show-mode-hook ()
  ;; TODO dynamically set margin by subtracting buffer width and
  ;; desired number of columns
  ;; (setq left-margin-width 20)
  ;; (setq right-margin-width 20)
  (toggle-read-only 1)
  ;;(setq buffer-read-only 'f)
  ;; (mark-whole-buffer)
  ;; (fill-region)
  ;;(setq buffer-read-only 't)
  )

(add-hook 'elfeed-show-mode-hook 'my-elfeed-show-mode-hook)
;;(add-hook 'elfeed-show-mode-hook 'turn-on-auto-fill)



(provide 'init-feed)
