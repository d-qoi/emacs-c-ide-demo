;;; init.el --- Initialization

;;; Commentary:
;;; For personal use.

;;; Code:
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/elisp")
(if (file-directory-p "~/.emacs.d/ecb/")
    (progn
      (message "ECB found")
      (add-to-list 'load-path "~/.emacs.d/ecb")))
(if (file-directory-p "~/.emacs.d/xelb")
    (progn
      (message "XELB found")
      (add-to-list 'load-path "~/.emacs.d/xelb")))
(if (file-directory-p "~/.emacs.d/exwm")
    (progn
      (message "EXWM found")
      (add-to-list 'load-path "~/.emacs.d/exwm")))

(require 'setup-general)
(require 'custom-functions)
(require 'setup-other-packages)
(require 'setup-helm)
(require 'setup-helm-gtags)
(require 'setup-c)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-elpy)
(require 'setup-winstack)

;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(add-hook 'after-init-hook (lambda () (message "after-init-hook called")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(compilation-message-face (quote default))
 '(cscope-initial-directory "~/cscopedb/" t)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(ecb-options-version "2.50")
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-sane-defaults)))
 '(elpy-project-ignored-directories
   (quote
    (".tox" "build" "dist" ".cask" ".ipynb_checkpoints" "_out")))
 '(package-selected-packages
   (quote
    (zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; init.el ends here
