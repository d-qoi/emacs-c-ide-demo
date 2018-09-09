;;; package --- Setup for magit

;;; Commentary:
;;; Just created this to be a wrapper to fit into the conventions that this .emacs.d file has been using thus far.

;;; Code:
(use-package magit
  :init
  (progn
    (global-set-key (kbd "C-x g") 'magit-status)))

(provide 'setup-magit)
;;; setup-magit.el ends here
