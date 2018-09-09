(require 'cc-mode)
(require 'semantic)

;;; Code:
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)
(global-semantic-idle-local-symbol-highlight-mode 1)

(semantic-mode 1)

(defun alexott/cedet-hook ()
  "Setting up jumping for cedet."
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))

(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

;; Enable EDE only in C/C++
(use-package ede
  :init
  (progn
    ;; (global-ede-mode t)
    (add-hook 'c-mode-common-hook ede-minor-mode)
    (add-hook 'c-mode-hook ede-minor-mode)
    (add-hook 'c++-mode-hook ede-minor-mode)))


(require 'ecb)
;; (use-package ecb
;;   :init
;;   (progn
;;     ))

(provide 'setup-cedet)
;;; setup-cedet.el ends here
