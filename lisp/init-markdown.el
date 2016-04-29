(require-package 'markdown-mode)

(after-load 'whitespace-cleanup-mode
  (push 'markdown-mode whitespace-cleanup-mode-ignore-modes))

(after-load 'markdown-mode
  (add-hook 'markdown-mode-hook 'auto-fill-mode))

(provide 'init-markdown)
