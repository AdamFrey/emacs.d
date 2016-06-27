(add-to-list 'auto-mode-alist '("\\.sql$" . sql-mode))
(add-hook 'sql-mode-hook 'sqlup-mode)

(add-to-list 'auto-mode-alist
             '("\\.psql$" . (lambda ()
                              (sql-mode)
                              (sql-highlight-postgres-keywords))))

;;
;; Fix SQL indentation
;;

(defun get-previous-indentation ()
  "Get the column of the previous indented line"
  (interactive)
  (save-excursion
    (progn
      (move-beginning-of-line nil)
      (skip-chars-backward "\n \t")
      (back-to-indentation))
    (current-column)))

(defun get-current-indentation ()
  "Return column at current indentation"
  (interactive)
  (save-excursion
    (progn
      (back-to-indentation)
      (current-column))))

(defun point-at-current-indentation ()
  "Return point at current indentation"
  (interactive)
  (save-excursion
    (progn
      (move-to-column (get-current-indentation))
      (point))))

(defun point-at-column-on-line (col)
  "Returns the point at `col` on the current line"
  (interactive)
  (save-excursion
    (progn
      (move-to-column col)
      (point))))

(defun ig-move-line-to-column (col)
  "Move the line to col; fill with all spaces if moveing forward"
  (interactive "p")
  (let ((point-at-cur-indent (point-at-current-indentation))
        (col-at-cur-indent (get-current-indentation)))
    (cond (
           (= col 0)
           ;; delete to beginning of line or do nothing
           (if (= col-at-cur-indent 0)
               nil
             (delete-region point-at-cur-indent (point-at-column-on-line 0))))
          (
           (< col col-at-cur-indent)
           ;; delete from our current point BACK to col
           (delete-region (point-at-column-on-line col) point-at-cur-indent))
          (
           (> col col-at-cur-indent)
           ;; delete all text from indent to beginning of line
           (progn
             (delete-region point-at-cur-indent (point-at-column-on-line 0))
             (move-beginning-of-line nil)
             ;; add spaces forward
             (insert (make-string col ?\s)))))))

(defun ig-indent-sql ()
  "Indent by `tab-width` at most 1 time greater than the previously indented line otherwise go to the beginning of the line indent forward by `tab-width`"
  (let ((previous (get-previous-indentation))
        (current (get-current-indentation)))
    (cond ( ;; exactly at previous line's indentation
           (= previous current)
           (ig-move-line-to-column (+ current tab-width)))

          ( ;; current is greater than previous
           (> current previous)
           ;; exactly at one indentation forward from previous lines indent
           (if (= tab-width (- current previous))
               ;; move line to beginning
               (ig-move-line-to-column 0)
             ;; go back to previous indentation level
             (ig-move-line-to-column previous)))

          (t
           (ig-move-line-to-column (+ current tab-width))))))

(add-hook 'sql-mode-hook
          (function (lambda ()
                      (make-local-variable 'indent-line-function)
                      (setq indent-line-function 'ig-indent-sql)
                      (setq tab-width 4))))


(after-load 'sql
  ;; sql-mode pretty much requires your psql to be uncustomised from stock settings
  (push "--no-psqlrc" sql-postgres-options))

(defun sanityinc/pop-to-sqli-buffer ()
  "Switch to the corresponding sqli buffer."
  (interactive)
  (if sql-buffer
      (progn
        (pop-to-buffer sql-buffer)
        (goto-char (point-max)))
    (sql-set-sqli-buffer)
    (when sql-buffer
      (sanityinc/pop-to-sqli-buffer))))

(after-load 'sql
  (define-key sql-mode-map (kbd "C-c C-z") 'sanityinc/pop-to-sqli-buffer)
  (add-hook 'sql-interactive-mode-hook 'sanityinc/never-indent)
  (when (package-installed-p 'dash-at-point)
    (defun sanityinc/maybe-set-dash-db-docset ()
      (when (eq sql-product 'postgres)
        (set (make-local-variable 'dash-at-point-docset) "psql")))

    (add-hook 'sql-mode-hook 'sanityinc/maybe-set-dash-db-docset)
    (add-hook 'sql-interactive-mode-hook 'sanityinc/maybe-set-dash-db-docset)
    (defadvice sql-set-product (after set-dash-docset activate)
      (sanityinc/maybe-set-dash-db-docset))))

(setq-default sql-input-ring-file-name
              (expand-file-name ".sqli_history" user-emacs-directory))

;; See my answer to https://emacs.stackexchange.com/questions/657/why-do-sql-mode-and-sql-interactive-mode-not-highlight-strings-the-same-way/673
(defun sanityinc/font-lock-everything-in-sql-interactive-mode ()
  (unless (eq 'oracle sql-product)
    (sql-product-font-lock nil nil)))
(add-hook 'sql-interactive-mode-hook 'sanityinc/font-lock-everything-in-sql-interactive-mode)


(after-load 'page-break-lines
  (push 'sql-mode page-break-lines-modes))

(provide 'init-sql)
