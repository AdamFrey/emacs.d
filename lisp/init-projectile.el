(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-global-mode)

  ;; The following code means you get a menu if you hit "C-c p" and wait
  (after-load 'guide-key
    (add-to-list 'guide-key/guide-key-sequence "C-c p"))

  (after-load 'projectile
    (setq-default
     ;; Shorter modeline
     projectile-mode-line
     '(:eval
       (if (file-remote-p default-directory)
           " Pr"
         (format " Pr[%s]" (projectile-project-name))))))

  (global-set-key (kbd "C-, f") 'projectile-find-file)
  (global-set-key (kbd "C-, a") 'projectile-grep)
  (global-set-key (kbd "C-, b") 'projectile-switch-to-buffer))

(provide 'init-projectile)
