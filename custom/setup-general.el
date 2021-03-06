;;; package --- For general setup
;;; Commentary:
;;; This is general stuff

;;; Code:
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; simpler aliases
(defalias 'yes-or-no-p 'y-or-n-p)

;; for auto reloading
(setq global-auto-revert-mode 1)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; truncating liens
(setq-default truncate-lines t)

;; Linum mode
(require 'linum)
(global-linum-mode t)
(show-paren-mode 1)
(setq column-number-mode t)
(setq linum-format "%d|")

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

;; Compilation
;; (global-set-key (kbd "<f5>") (lambda ()
;;                                (interactive)
;;                                (setq-local compilation-read-command nil)
;;                                (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t
 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t)


;; Recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(require 'grep)
(eval-after-load 'grep
  '(progn
     (add-to-list 'grep-find-ignored-directories "_out")))

;; always helpful
(display-time)

;; laptop handling
(require 'battery)
(when (and battery-status-function
           (not (string-match-p "N/A"
                                (battery-format "%B" (funcall battery-status-function)))))
  (display-battery-mode 1))

;; binding functions
(global-set-key (kbd "C-x C-k") 'delete-other-windows)
(global-set-key (kbd "C-x M-s") 'save-buffers-kill-emacs)

(message "setup-general loaded")
(provide 'setup-general)
;;; setup-general.el ends here
