(require-package 'elfeed)
(require-package 'elfeed-org)

(elfeed-org)

(global-set-key (kbd "C-x w") 'elfeed)

(defun set-feed-font ()
  "Set feed-show buffer font"
  (interactive)
  (setq buffer-face-mode-face '(:height 170 :width semi-condensed))
  (buffer-face-mode))

(defun my-elfeed-show-mode-hook ()
  (toggle-read-only 1)
  (set-feed-font))

(add-hook 'elfeed-show-mode-hook 'my-elfeed-show-mode-hook)
;;(add-hook 'elfeed-show-mode-hook 'turn-on-auto-fill)

(provide 'init-feed)
