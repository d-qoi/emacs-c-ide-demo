;;; setup-elpy --- a packack that will setup elpy and the supporting plugins

;;; Commentary:

;;; This section sets up elpy
;;; Code:

(require 'pyvenv)

(use-package elpy
  :init
  (progn
    (elpy-enable)
    (when (require 'flycheck nil t)
      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))
    (setq python-shell-interpreter "/usr/bin/python2")
    (setq elpy-rpc-python-command "/usr/bin/python2")
    (define-key python-mode-map (kbd "M-.") 'elpy-goto-definition)))
          ;; python-shell-interpreter-args "-i --simple-prompt")))


(defun cust/set-elpy-py3 ()
  (interactive)
  (elpy-disable)
  (setq python-shell-interpreter "python3")
  (setq elpy-rpc-python-command "python3")
  (elpy-enable))

(provide 'setup-elpy)
;;; setup-elpy ends here
