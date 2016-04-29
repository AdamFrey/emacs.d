(maybe-require-package 'fold-this)

(global-set-key (kbd "C-c f") 'fold-this-all)
(global-set-key (kbd "C-c F") 'fold-this)
(global-set-key (kbd "C-c M-f") 'fold-this-unfold-all)

(provide 'init-folding)
