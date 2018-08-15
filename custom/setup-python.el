
;;; Code:
(use-package company-jedi
  :init
  (progn
    (defun my-python-mode-hook
        (add-to-list 'company-backends 'company-jedi))
    (add-hook 'python-mode-hook 'my-python-mode-hook)))

(provide 'setup-python)
;;; setup-python.el ends here
