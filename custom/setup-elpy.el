;;; setup-elpy --- a packack that will setup elpy and the supporting plugins

;;; Commentary:

;;; This section sets up elpy
;;; Code:
(use-package elpy
  :init
  (progn
    (elpy-enable)
    (when (require 'flycheck nil t)
      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))
    (setq python-shell-interpreter "/usr/bin/python2")
    (setq elpy-rpc-python-command "/usr/bin/python2")
    (define-key python-mode-map (kbd "M-.") 'elpy-goto-definition)
    (define-key python-mode-map (kbd "M-,") 'pop-global-mark)))
          ;; python-shell-interpreter-args "-i --simple-prompt")))


(use-package company-jedi
  :init
  (progn
    (defun my-python-mode-hook ()
        (add-to-list 'company-backends 'company-jedi))
    (add-hook 'python-mode-hook 'my-python-mode-hook)))

(message "setup-elpy loaded")
(provide 'setup-elpy)
;;; setup-elpy ends here
