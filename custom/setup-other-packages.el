;;; package --- for random packages that only have one or two lines
;;; Commentary: Not really sure where to put these

;;; Code:

(require 'cc-mode)

;; company
(use-package company
  :init
  (progn
    (global-company-mode 1)
    (delete 'company-semantic company-backends)
    (define-key c-mode-base-map  [(control tab)] 'company-complete)))


;; Package: projejctile
;(use-package projectile
;  :init
;  (projectile-global-mode)
;  (setq projectile-enable-caching t))

;; Package zygospore
; this package allows for toggle with C-x 1, basically maximize for a moment.
(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows)))

(use-package json-mode)

(message "setup-other-packages loaded")
(provide 'setup-other-packages)
