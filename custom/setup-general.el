;;; package --- For general setup
;;; Commentary:
;;; This is general stuff

;;; Code:
(menu-bar-mode -1)
(tool-bar-mode -1)

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

(provide 'setup-general)
