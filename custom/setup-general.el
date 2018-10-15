;;; package --- For general setup
;;; Commentary:
;;; This is general stuff

;;; Code:
(menu-bar-mode -1)
(tool-bar-mode -1)

(show-paren-mode 1)
(setq column-number-mode t)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )


;; company
(use-package company
  :init
  (global-company-mode 1)
  (delete 'company-semantic company-backends)
  (define-key c-mode-map  [(control tab)] 'company-complete)
  (define-key c++-mode-map  [(control tab)] 'company-complete))


;; Package: projejctile
;(use-package projectile
;  :init
;  (projectile-global-mode)
;  (setq projectile-enable-caching t))

;; Package zygospore
; this package allows for toggle with C-x 1, basically maximize for a moment.
(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows)))

  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

(windmove-default-keybindings)

(setq-default truncate-lines t)

(eval-after-load 'grep
  '(progn
     (add-to-list 'grep-find-ignored-directories "_out")))

(use-package json-mode)

;; Linum mode
(global-linum-mode t)
(setq linum-format "%d|")

;;; linum disable hook
(defvar linum-disabled-modes
  '(term-mode help-mode exwm-mode))

(defun linum-disable-function ()
  "Function for the hook for after major mode change."
  (defun recloop (val lst)
    ;;(message "recloop %s %s" val (car lst))
    (cond
     ((equal '() lst) 1)
     ((equal val (car lst)) 0)
     (t (recloop val (cdr lst)))))
  (linum-mode (recloop major-mode linum-disabled-modes)))

(add-hook 'after-change-major-mode-hook 'linum-disable-function)


(defun revert-all-file-buffer ()
  "Refresh all open files buffers without confirmation.
Buffers in modified (not yet saved) state in Emacs will not be reverted.  They
will be reverted though if they were modified outside Emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffer containing files, which are not modified;
      ;; try not to revert non-file buffers
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename) ;; only revert if readable file
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes)
              (message "Reverted buffer: %s" filename))
          ;; otherwise kill buffer (file no longer exists)
          (let (kill-buffer-query-functions)
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finnished reverting all buffers"))

(defun kill-all-file-buffers ()
  "Kills all file buffers"
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      (when filename
        (let (kill-buffer-query-functions)
          (kill-buffer buf)
          (message "Killed %s" filename))))))

(provide 'setup-general)
