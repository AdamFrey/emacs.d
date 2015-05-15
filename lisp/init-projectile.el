(require-package 'projectile)

(projectile-global-mode)
(global-set-key (kbd "C-, f") 'projectile-find-file)
(global-set-key (kbd "C-, a") 'projectile-grep)
(global-set-key (kbd "C-, b") 'projectile-switch-to-buffer)

(provide 'init-projectile)
