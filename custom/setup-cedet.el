;;; setup-cedet --- custom setup of some cedet functions
;;; Commentary:
;;; Just some custom setup
(require 'cc-mode)
(require 'semantic)

;;; Code:

;; global semantic mode setup
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)
(global-semantic-idle-local-symbol-highlight-mode 1)

(add-hook 'after-init-hook 'semantic-mode)

(defun alexott/cedet-hook ()
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))

;;(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

;; Enable EDE only in C/C++
(use-package ede
  :init
  (progn
    ;; (global-ede-mode t)
    ;;(add-hook 'c-mode-common-hook ede-minor-mode)
    (add-hook 'c-mode-hook 'ede-minor-mode)
    (add-hook 'c++-mode-hook 'ede-minor-mode)))


(message "setup-ceded loaded")
(provide 'setup-cedet)
;;; setup-cedet.el ends here
