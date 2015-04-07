(add-to-list 'load-path "~/emacs.d/site-lisp/magit")
(require 'magit)

(global-set-key (kbd "C-, g") 'magit-status)

(provide 'init-git-next)
